package com.dzm.aspect.lock;

import com.dzm.exception.ServiceException;
import com.dzm.util.redisson.util.RedissonUtil;
import com.dzm.constant.ServiceResponseStatusType;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.redisson.api.RLock;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.StandardReflectionParameterNameDiscoverer;
import org.springframework.expression.EvaluationContext;
import org.springframework.expression.Expression;
import org.springframework.expression.spel.standard.SpelExpressionParser;
import org.springframework.expression.spel.support.StandardEvaluationContext;
import org.springframework.stereotype.Component;

import java.lang.reflect.Method;
import java.lang.reflect.Parameter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

@Aspect
@Component
public class DistributeLockAspect {

    @Autowired
    private RedissonUtil redissonUtil;

    private static final Logger LOG = LoggerFactory.getLogger(DistributeLockAspect.class);

    @Pointcut("@annotation(com.dzm.aspect.lock.DistributeLock)")
    public void distributeLock() { }

    @Around("distributeLock()")
    public Object around(ProceedingJoinPoint pjp) throws Exception {

        Object response = null;
        MethodSignature methodSignature = (MethodSignature) pjp.getSignature();
        Method method = methodSignature.getMethod();
        DistributeLock distributeLock = method.getAnnotation(DistributeLock.class);

        String scene = distributeLock.scene();
        String key = distributeLock.key();
        String[] parametersKey = distributeLock.parametersKey();
        if (parametersKey != null && parametersKey.length > 0) {
            Object[] args = pjp.getArgs();
            String[] parameterNames = methodSignature.getParameterNames();
            Map<String, String> parametersMap = new HashMap<>();
            for(int i = 0; i < Math.min(parameterNames.length, args.length); i++) {
                parametersMap.put(parameterNames[i], args[i].toString());
            }
            ArrayList<String> argsKey = new ArrayList<>();
            Arrays.stream(parametersKey).forEach(k -> {
                argsKey.add(parametersMap.getOrDefault(k, "null"));
            });
            key = key + "#" + String.join(",", argsKey);
        }
        String lockKey = scene + "#" + key;

        int expireTime = distributeLock.expireTime();
        int waitTime = distributeLock.waitTime();
        RLock rLock = redissonUtil.getLock(lockKey);
        boolean lockResult = false;
        if (waitTime == DistributeLockConstant.DEFAULT_WAIT_TIME) {
            if (expireTime == DistributeLockConstant.DEFAULT_EXPIRE_TIME) {
                LOG.info(String.format("lock for key : %s", lockKey));
                rLock.lock();
            } else {
                LOG.info(String.format("lock for key : %s , expire : %s", lockKey, expireTime));
                rLock.lock(expireTime, TimeUnit.MILLISECONDS);
            }
            lockResult = true;
        } else {
            if (expireTime == DistributeLockConstant.DEFAULT_EXPIRE_TIME) {
                LOG.info(String.format("try lock for key : %s , wait : %s", lockKey, waitTime));
                lockResult = rLock.tryLock(waitTime, TimeUnit.MILLISECONDS);
            } else {
                LOG.info(String.format("try lock for key : %s , expire : %s , wait : %s", lockKey, expireTime, waitTime));
                lockResult = rLock.tryLock(waitTime, expireTime, TimeUnit.MILLISECONDS);
            }
        }

        if (!lockResult) {
            LOG.warn(String.format("lock failed for key : %s , expire : %s", lockKey, expireTime));
            throw ServiceException.builder()
                    .status(ServiceResponseStatusType.LOCK_FAILED.getStatus())
                    .serverErrorMessage("acquire lock failed... key : " + lockKey)
                    .message("wait a moment ...")
                    .build();
        }

        try {
            LOG.info(String.format("lock success for key : %s , expire : %s", lockKey, expireTime));
            response = pjp.proceed();
        } catch (ServiceException e) {
            throw e;
        } catch (Throwable e) {
            e.printStackTrace();
            throw ServiceException.builder()
                    .status(ServiceResponseStatusType.SERVER_ERROR.getStatus())
                    .serverErrorMessage(e.getMessage())
                    .build();
        } finally {
            rLock.unlock();
            LOG.info(String.format("unlock for key : %s , expire : %s", lockKey, expireTime));
        }
        return response;
    }
}
