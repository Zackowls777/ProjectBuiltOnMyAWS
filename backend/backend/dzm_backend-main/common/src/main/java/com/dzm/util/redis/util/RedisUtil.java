package com.dzm.util.redis.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import java.util.concurrent.TimeUnit;

@Component
public class RedisUtil {

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    public boolean set(String key, Object value) {
        boolean res = false;
        try {
            redisTemplate.opsForValue().set(key, value);
            res = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return res;
    }

    public boolean set(String key, Object value, long timeOutSeconds) {
        if(timeOutSeconds <= 0) {
            return set(key, value);
        }
        boolean res = false;
        try {
            redisTemplate.opsForValue().set(key, value, timeOutSeconds, TimeUnit.SECONDS);
            res = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return res;
    }

    public boolean exists(String key) {
        try {
            return redisTemplate.hasKey(key);
        } catch (Exception e) {
            return false;
        }
    }

    public Object get(String key) {
        try {
            return redisTemplate.opsForValue().get(key);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}
