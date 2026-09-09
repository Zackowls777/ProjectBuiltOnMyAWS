package com.dzm.util.redisson.util;

import org.redisson.api.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class RedissonUtil {

    @Autowired
    private RedissonClient redissonClient;

    public RLock getLock(String key) {
        return redissonClient.getLock("lock:" + key);
    }

    public RRateLimiter getRateLimiter(String key) {

        return redissonClient.getRateLimiter("rate-limiter:" + key);

    }

}
