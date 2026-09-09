package com.dzm.aspect.cache;

import com.dzm.aspect.limiter.DistributeRateLimiter;
import com.dzm.aspect.limiter.DistributeRateLimiterConstant;
import com.dzm.constant.ServiceResponseStatusType;
import com.dzm.exception.ServiceException;
import com.dzm.util.redis.util.RedisUtil;
import com.dzm.util.redisson.util.RedissonUtil;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.redisson.api.RRateLimiter;
import org.redisson.api.RateIntervalUnit;
import org.redisson.api.RateType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

@Aspect
@Component
public class DistributeCacheAspect {

    @Autowired
    private RedisUtil redisUtil;

    private static final Logger LOG = LoggerFactory.getLogger(DistributeCacheAspect.class);

    @Pointcut("@annotation(com.dzm.aspect.cache.DistributeCache)")
    public void distributeCache() { }

    @Around("distributeCache()")
    public Object around(ProceedingJoinPoint pjp) throws Exception {

        Object response = null;
        MethodSignature methodSignature = (MethodSignature) pjp.getSignature();
        Method method = methodSignature.getMethod();
        DistributeCache distributeCache = method.getAnnotation(DistributeCache.class);

        String scene = distributeCache.scene();
        String key = distributeCache.key();
        String[] parametersKey = distributeCache.parametersKey();
        if (parametersKey != null && parametersKey.length > 0) {
            Object[] args = pjp.getArgs();
            String[] parameterNames = methodSignature.getParameterNames();
            Map<String, String> parametersMap = new HashMap<>();
            for(int i = 0; i < Math.min(parameterNames.length, args.length); i++) {
                String arg = "";
                try {
                    arg = args[i].toString();
                } catch (Exception e) {
                    arg = "" + args[i];
                }
                parametersMap.put(parameterNames[i], arg);
            }
            ArrayList<String> argsKey = new ArrayList<>();
            Arrays.stream(parametersKey).forEach(k -> {
                argsKey.add(parametersMap.getOrDefault(k, "null"));
            });
            key = key + "#" + String.join(",", argsKey);
        }
        String cacheKey = scene + "#" + key;
        int duration = distributeCache.duration();

        response = redisUtil.get(cacheKey);

        if(response == null) {
            try {
                response = pjp.proceed();
                if(duration == DistributeCacheConstant.DEFAULT_DURATION) {
                    redisUtil.set(cacheKey, response);
                } else {
                    redisUtil.set(cacheKey, response, duration);
                }
            } catch (ServiceException e) {
                throw e;
            } catch (Throwable e) {
                e.printStackTrace();
                throw ServiceException.builder()
                        .status(ServiceResponseStatusType.SERVER_ERROR.getStatus())
                        .serverErrorMessage(e.getMessage())
                        .build();
            }
        }
        return response;
    }
}
