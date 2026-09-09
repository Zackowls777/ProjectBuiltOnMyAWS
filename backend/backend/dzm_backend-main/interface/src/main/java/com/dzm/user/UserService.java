package com.dzm.user;

import com.dzm.exception.ServiceException;
import com.dzm.user.body.response.UserInfoListResponseBody;
import com.dzm.user.body.response.UserInfoRetrieveResponseBody;
import com.dzm.user.body.response.UserLoginResponseBody;
import com.dzm.user.body.response.UserRegisterResponseBody;

import java.util.List;

public interface UserService {

    String ping() throws ServiceException;

    UserRegisterResponseBody register(long identifierTimeStamp, String email, String code, String password) throws ServiceException ;

    void resetPassword(long identifierTimeStamp, String email, String code, String password) throws ServiceException ;

    UserLoginResponseBody login(String email, String password) throws ServiceException ;

    void retrieveVerifyCode(long identifierTimeStamp, String email, int type) throws ServiceException ;

    void updateUserInfo(long identifierTimeStamp, String userId, String nickname, String avatar) throws ServiceException;

    UserInfoRetrieveResponseBody retrieveUserInfo(String userId) throws ServiceException ;

    List<UserInfoListResponseBody> listUserInfo(List<String> usersId) throws ServiceException ;

}
