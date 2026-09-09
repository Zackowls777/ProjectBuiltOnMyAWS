package com.dzm.controller.user;

import com.dzm.config.interceptor.auth.LoginAuthChecker;
import com.dzm.controller.user.body.request.*;
import com.dzm.response.ServiceResponse;
import com.dzm.user.UserService;
import com.dzm.user.body.response.UserInfoRetrieveResponseBody;
import com.dzm.user.body.response.UserLoginResponseBody;
import com.dzm.user.body.response.UserRegisterResponseBody;
import com.dzm.util.jwt.JWTPayload;
import com.dzm.util.s3.util.S3Util;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.apache.dubbo.config.annotation.DubboReference;
import org.hibernate.validator.constraints.Length;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Payload;
import javax.validation.Valid;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;
import java.util.HashMap;
import java.util.UUID;

@RestController
@RequestMapping(path = "/user")
public class UserServiceController {

    @DubboReference(version = "1.0.0", loadbalance = "roundrobin", check = false)
    private UserService userService;

    @GetMapping("/ping")
    public ServiceResponse ping() {
        return ServiceResponse.builder().result(userService.ping()).build();
    }

    @PostMapping("/retrieve-verify-code")
    public ServiceResponse retrieveVerifyCode(@RequestBody @Validated RetrieveVerifyCodeRequestBody body) {
        userService.retrieveVerifyCode(System.currentTimeMillis(), body.getEmail(), body.getType());
        return ServiceResponse.builder().build();
    }


    @PostMapping("/signup")
    public ServiceResponse signup(@RequestBody @Validated RegisterRequestBody body) {
        UserRegisterResponseBody responseBody = userService.register(System.currentTimeMillis(), body.getEmail(), body.getCode(), body.getPassword());
        return ServiceResponse.builder().result(responseBody).build();
    }

    @PostMapping("/reset-password")
    public ServiceResponse resetPassword(@RequestBody @Validated ResetPasswordRequestBody body) {
        userService.resetPassword(System.currentTimeMillis(), body.getEmail(), body.getCode(), body.getPassword());
        return ServiceResponse.builder().build();
    }

    @PostMapping("/login")
    public ServiceResponse login(@RequestBody @Validated LoginRequestBody body) {
        UserLoginResponseBody responseBody = userService.login(body.getEmail(), body.getPassword());
        return ServiceResponse.builder().result(responseBody).build();
    }

    @GetMapping("/retrieve")
    @LoginAuthChecker
    public ServiceResponse retrieve(HttpServletRequest request) {
        JWTPayload payload = (JWTPayload) request.getAttribute("jwt_payload");
        UserInfoRetrieveResponseBody user = userService.retrieveUserInfo(payload.getUserId());
        return ServiceResponse.builder().result(user).build();
    }

    @PostMapping("/update")
    @LoginAuthChecker
    public ServiceResponse update(
            @RequestBody @Validated UserInfoUpdateRequestBody body,
            HttpServletRequest request) {
        JWTPayload payload = (JWTPayload) request.getAttribute("jwt_payload");
        userService.updateUserInfo(System.currentTimeMillis(), payload.getUserId(), body.getNickname(), body.getAvatar());
        return ServiceResponse.builder().build();
    }

}
