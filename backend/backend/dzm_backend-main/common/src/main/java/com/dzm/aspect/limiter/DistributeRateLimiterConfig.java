package com.dzm.aspect.limiter;

import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;


@Configuration
public class DistributeRateLimiterConfig {

    @Bean
    @ConditionalOnMissingBean
    public DistributeRateLimiterAspect distributeRateLimiterAspect() {
        return new DistributeRateLimiterAspect();
    }

}
