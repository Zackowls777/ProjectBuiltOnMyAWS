package com.dzm.services;

import com.dzm.aspect.limiter.DistributeRateLimiter;
import com.dzm.services.asyn.request.EmailSentRequest;
import com.dzm.constant.VerifyCodeType;
import com.dzm.exception.ServiceException;
import com.dzm.mapper.UserInfoMapper;
import com.dzm.mapper.VerifyCodeMapper;
import com.dzm.user.body.response.UserInfoListResponseBody;
import com.dzm.user.body.response.UserInfoRetrieveResponseBody;
import com.dzm.user.body.response.UserLoginResponseBody;
import com.dzm.user.body.response.UserRegisterResponseBody;
import com.dzm.util.kafka.util.KafkaUtil;
import com.dzm.model.UserInfo;
import com.dzm.model.UserInfoExample;
import com.dzm.model.VerifyCode;
import com.dzm.model.VerifyCodeExample;
import com.dzm.user.UserService;
import com.dzm.util.json.JSONUtil;
import com.dzm.util.jwt.JWTPayload;
import com.dzm.util.jwt.JWTUtil;
import com.dzm.util.password.PasswordUtil;
import com.dzm.util.s3.util.S3Util;
import org.apache.dubbo.config.annotation.DubboService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@DubboService(version = "1.0.0")
public class UserServiceImpl implements UserService {

    @Autowired
    private PasswordUtil passwordUtil;

    @Autowired
    private JWTUtil jwtUtil;

    @Autowired
    private JSONUtil jsonUtil;

    @Autowired
    private KafkaUtil kafkaUtil;

    @Autowired
    private VerifyCodeMapper verifyCodeMapper;

    @Autowired
    private UserInfoMapper userInfoMapper;

    @Value("${user.verify-code.validity}")
    private int validity = 300;

    @Autowired
    private S3Util s3Util;

    @Override
    public String ping() {
        return "user service pong";
    }

    /***
     *
     * @param identifierTimeStamp 作为created time 幂等校验
     * @param email
     * @param code
     * @param password
     * @return
     */
    @Override
    public UserRegisterResponseBody register(long identifierTimeStamp, String email, String code, String password) {
        if(!checkVerifyCode(email, code, VerifyCodeType.REGISTER.getType())) {
            throw ServiceException.builder().message("Invalid verify code.").build();
        }
        UserInfo user = fetchUserInfoByEmail(email, false);
        if(user != null) {
            if(user.getCreatedTime() != identifierTimeStamp) {
                throw ServiceException.builder().message("This email has been registered.").build();
            }
        } else {
            String encodePassword = passwordUtil.encode(password);
            user = UserInfo.builder()
                    .email(email).nickname(email.split("@")[0])
                    .password(encodePassword)
                    .createdTime(identifierTimeStamp)
                    .build();
            userInfoMapper.insert(user);
        }
        String token = jwtUtil.generateToken(
                                JWTPayload.builder()
                                        .userId(user.getId())
                                        .email(email)
                                        .role(user.getRole())
                                        .build()
                        );
        return UserRegisterResponseBody.builder().token(token).build();
    }

    /***
     *
     * @param identifierTimeStamp 作为 modified time 幂等校验
     * @param email
     * @param code
     * @param password
     * @return
     */
    @Override
    public void resetPassword(long identifierTimeStamp, String email, String code, String password) {
        UserInfo user = fetchUserInfoByEmail(email);
        if(user == null) {
            throw ServiceException.builder().message("This email had not been registered.").build();
        }
        if(user.getModifiedTime() != identifierTimeStamp) {
            if(!passwordUtil.verify(code, user.getPassword()) && !checkVerifyCode(email, code, VerifyCodeType.RESET_PASSWORD.getType())) {
                throw ServiceException.builder().message("Invalid verify code or password.").build();
            }
            user.setPassword(passwordUtil.encode(password));
            user.setModifiedTime(identifierTimeStamp);
            userInfoMapper.updateByPrimaryKey(user);
        }
    }

    @Override
    public UserLoginResponseBody login(String email, String password) {
        UserInfo userInfo = fetchUserInfoByEmail(email);
        if(userInfo == null) {
            throw ServiceException.builder().message("This email has not been registered.").build();
        }
        if(!passwordUtil.verify(password, userInfo.getPassword())) {
            throw ServiceException.builder().message("Invalid Password.").build();
        }
        String token = jwtUtil.generateToken(
                                JWTPayload.builder()
                                        .userId(userInfo.getId())
                                        .email(email)
                                        .role(userInfo.getRole())
                                        .build()
                        );
        return UserLoginResponseBody.builder().token(token).build();
    }

    /***
     *
     * @param identifierTimeStamp 作为created time 幂等校验
     * @param email
     * @param type
     */
    @Override
    @DistributeRateLimiter(scene = "user#retrieve-verify-code", parametersKey = {"email", "type"}, duration = 60, limit = 1)
    public void retrieveVerifyCode(long identifierTimeStamp, String email, int type) {
        String code = generateCode();
        VerifyCode verifyCode = VerifyCode.builder()
                .email(email).code(code).type(type)
                .createdTime(identifierTimeStamp)
                .build();
        verifyCodeMapper.insert(verifyCode);

        EmailSentRequest sendDTO = EmailSentRequest.builder()
                .toEmail(email)
                .subject("verify code")
                .content(code)
                .build();

        kafkaUtil.send("email-send-verifycode", jsonUtil.toJSON(sendDTO));
    }

    @Override
    public void updateUserInfo(long identifierTimeStamp, String userId, String nickname, String avatar) throws ServiceException {
        UserInfo userInfo = fetchUserInfoById(userId);
        if(userInfo.getModifiedTime() != identifierTimeStamp) {
            userInfo.setModifiedTime(identifierTimeStamp);
            userInfo.setNickname(nickname);
            userInfo.setAvatar(avatar);
            userInfoMapper.updateByPrimaryKey(userInfo);
        }
    }

    @Override
    public UserInfoRetrieveResponseBody retrieveUserInfo(String userId) throws ServiceException {
        UserInfo userInfo = fetchUserInfoById(userId);
        return UserInfoRetrieveResponseBody.builder()
                .id(userInfo.getId())
                .username(userInfo.getUsername())
                .nickname(userInfo.getNickname())
                .avatar(s3Util.generatePreSignedGetObjectUrl(userInfo.getAvatar()))
                .unSignedAvatarKey(userInfo.getAvatar())
                .email(userInfo.getEmail())
                .role(userInfo.getRole())
                .build();

    }

    @Override
    public List<UserInfoListResponseBody> listUserInfo(List<String> usersId) throws ServiceException {
        UserInfoExample userInfoExample = new UserInfoExample();
        UserInfoExample.Criteria criteria = userInfoExample.createCriteria();
        criteria.andIdIn(usersId);
        List<UserInfo> users = userInfoMapper.selectByExample(userInfoExample);
        List<UserInfoListResponseBody> responseBodies = new ArrayList<>();
        users.forEach(user -> {
            responseBodies.add(UserInfoListResponseBody.builder()
                    .id(user.getId())
                    .username(user.getUsername())
                    .nickname(user.getNickname())
                    .avatar(s3Util.generatePreSignedGetObjectUrl(user.getAvatar()))
                    .unSignedAvatarKey(user.getAvatar())
                    .build());
        });
        return responseBodies;
    }

    private String generateCode() {
        String str="ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        Random random = new Random();
        StringBuilder sb= new StringBuilder();
        for(int i = 0; i < 4; i++){
            int number=random.nextInt(str.length());
            sb.append(str.charAt(number));
        }
        return sb.toString();
    }

    private UserInfo fetchUserInfoById(String userId) {
        return fetchUserInfoById(userId, true);
    }

    private UserInfo fetchUserInfoById(String userId, boolean throwExceptionIfAbsent) {
        UserInfo userInfo = userInfoMapper.selectByPrimaryKey(userId);
        if(userInfo == null || userInfo.getIsDeleted()) {
            if(throwExceptionIfAbsent) {
                throw ServiceException.builder()
                        .message(String.format("User with id [%s] not found.", userId))
                        .build();
            }
            return null;
        }
        return userInfo;
    }

    private UserInfo fetchUserInfoByEmail(String email) {
        return fetchUserInfoByEmail(email, true);
    }

    private UserInfo fetchUserInfoByEmail(String email, boolean throwExceptionIfAbsent) {
        UserInfoExample userInfoExample = new UserInfoExample();
        UserInfoExample.Criteria criteria = userInfoExample.createCriteria();
        criteria.andEmailEqualTo(email).andIsDeletedEqualTo(false);
        List<UserInfo> users = userInfoMapper.selectByExample(userInfoExample);
        if(users == null || users.isEmpty()) {
            if(throwExceptionIfAbsent) {
                throw ServiceException.builder()
                        .message(String.format("User with email [%s] not found.", email))
                        .build();
            }
            return null;
        }
        return users.get(0);
    }


    private boolean checkVerifyCode(String email, String code, int type) {
        VerifyCodeExample verifyCodeExample = new VerifyCodeExample();
        VerifyCodeExample.Criteria criteria = verifyCodeExample.createCriteria();
        long currentTimeStamp = System.currentTimeMillis();
        criteria.andCodeEqualTo(code).andEmailEqualTo(email).andTypeEqualTo(type).andIsDeletedEqualTo(false);
        criteria.andCreatedTimeGreaterThanOrEqualTo(currentTimeStamp - validity * 1000);
        List<VerifyCode> codes = verifyCodeMapper.selectByExample(verifyCodeExample);
        if(codes == null || codes.isEmpty()) {
            return false;
        }
        VerifyCode verifyCode = codes.get(0);
        verifyCode.setModifiedTime(currentTimeStamp);
        verifyCode.setIsDeleted(true);
        verifyCodeMapper.updateByPrimaryKey(verifyCode);
        return true;
    }

}
