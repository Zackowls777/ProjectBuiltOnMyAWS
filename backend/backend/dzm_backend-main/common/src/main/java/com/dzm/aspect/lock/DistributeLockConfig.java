package com.dzm.aspect.lock;

import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;


@Configuration
public class DistributeLockConfig {

    @Bean
    @ConditionalOnMissingBean
    public DistributeLockAspect distributeLockAspect(){
        return new DistributeLockAspect();
    }
}
