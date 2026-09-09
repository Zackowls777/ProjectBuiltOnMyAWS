package com.dzm.aspect.lock;

import java.lang.annotation.*;


@Documented
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface DistributeLock {

    /**
     * 锁的场景
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
     * 超时时间，毫秒
     * 默认情况下不设置超时时间，会自动续期
     */
    public int expireTime() default DistributeLockConstant.DEFAULT_EXPIRE_TIME;

    /**
     * 加锁等待时长，毫秒
     * 默认情况下不设置等待时长，不做等待
     */
    public int waitTime() default DistributeLockConstant.DEFAULT_WAIT_TIME;
}
