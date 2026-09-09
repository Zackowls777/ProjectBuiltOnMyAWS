package com.dzm.aspect.cache;

import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;


@Configuration
public class DistributeCacheConfig {

    @Bean
    @ConditionalOnMissingBean
    public DistributeCacheAspect distributeCacheAspect() {
        return new DistributeCacheAspect();
    }

}
