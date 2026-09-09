package com.dzm.config.interceptor.auth;

import com.dzm.constant.ServiceResponseStatusType;
import com.dzm.constant.UserRoleTyoe;
import com.dzm.exception.ServiceException;
import com.dzm.model.UserInfo;
import com.dzm.util.jwt.JWTPayload;
import com.dzm.util.jwt.JWTUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Method;

public class LoginAuthInterceptor implements HandlerInterceptor {

    @Autowired
    private JWTUtil jwtUtil;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (!(handler instanceof HandlerMethod)) {
            return true;
        }
        String token = null;
        Cookie[] cookies = request.getCookies();
        for(Cookie cookie: cookies == null ? new Cookie[0] : cookies) {
            if(cookie.getName().equals("token")) {
                token = cookie.getValue();
                break;
            }
        }
        JWTPayload payload = JWTPayload.builder().build();
        if(token != null) {
            payload = jwtUtil.validTokenAndConvertToJWTPayload(token);
        }
        request.setAttribute("jwt_payload", payload);
        Method method = ((HandlerMethod)handler).getMethod();
        LoginAuthChecker loginAuthChecker = method.getAnnotation(LoginAuthChecker.class);
        if(loginAuthChecker != null) {
            if(payload.getRole() == UserRoleTyoe.ANONYMOUS.getRole()) {
                throw ServiceException.builder()
                        .status(ServiceResponseStatusType.NON_AUTH.getStatus())
                        .message("Sorry, please sing in your account.")
                        .build();
            }
            if(!UserInfo.checkRoles(payload.role, loginAuthChecker.requiredRoles())) {
                throw ServiceException.builder()
                        .status(ServiceResponseStatusType.ROLE_DENIED.getStatus())
                        .serverErrorMessage(String.format("User [%s] permission denied.", payload.userId))
                        .message("Sorry, you do not have access rights.")
                        .build();
            }
        }
        return true;
    }
}