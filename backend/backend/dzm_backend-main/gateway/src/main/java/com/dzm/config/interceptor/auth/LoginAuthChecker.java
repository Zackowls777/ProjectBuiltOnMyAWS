package com.dzm.config.interceptor.auth;

import java.lang.annotation.*;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.METHOD})
public @interface LoginAuthChecker {
    int[] requiredRoles() default {};
}