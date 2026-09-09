package com.dzm.aspect.cache;

import java.lang.annotation.*;

@Documented
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface DistributeCache {

    /**
     * 缓存的场景
     */
    public String scene();

    /**
     * 加锁的key，优先取key()，如果没有，parametersKey()
     */
    public String key() default DistributeCacheConstant.NONE_KEY;

    /**
     * 以参数作为key
     */
    public String[] parametersKey() default {};

    /**
     * 限流器区间时长，秒
     * 默认情况下，不做过期处理
     */
    public int duration() default DistributeCacheConstant.DEFAULT_DURATION;
}