package com.dzm.aspect.limiter;

import com.dzm.aspect.lock.DistributeLockConstant;

import java.lang.annotation.*;

@Documented
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface DistributeRateLimiter {

    /**
     * 限流器的场景
     */
    public String scene();

    /**
     * 加锁的key，优先取key()，如果没有，parametersKey()
     */
    public String key() default DistributeLockConstant.NONE_KEY;

    /**
     * 以参数作为key
     */
    public String[] parametersKey() default {};

    /**
     * 限流器区间时长内限流次数
     * 默认情况下不设置，不做限流
     */
    public int limit() default DistributeRateLimiterConstant.DEFAULT_LIMIT;

    /**
     * 限流器区间时长，秒
     * 默认情况下，不做限流
     */
    public int duration() default DistributeRateLimiterConstant.DEFAULT_DURATION;
}