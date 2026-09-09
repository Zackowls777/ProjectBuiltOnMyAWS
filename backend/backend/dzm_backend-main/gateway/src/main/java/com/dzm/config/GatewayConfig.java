package com.dzm.config;

import com.dzm.config.interceptor.auth.LoginAuthInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;



@Configuration
public class GatewayConfig implements WebMvcConfigurer {

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")       // 访问所有资源
                .allowedOriginPatterns("*")         // 允许的跨域请求
                .allowedMethods("GET","HEAD","POST","PUT","DELETE","OPTIONS")
                .allowCredentials(true)             // 带Cookie验证
                .maxAge(3600)
                .allowedHeaders("*");
    }


    @Bean
    public LoginAuthInterceptor LoginAuthHandlerInterceptor() {
        return new LoginAuthInterceptor();
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(LoginAuthHandlerInterceptor());
    }
}