package com.dzm.aspect.limiter;

import com.dzm.constant.ServiceResponseStatusType;
import com.dzm.exception.ServiceException;
import com.dzm.util.redisson.util.RedissonUtil;
import com.dzm.aspect.lock.DistributeLockConstant;
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
import org.springframework.core.StandardReflectionParameterNameDiscoverer;
import org.springframework.expression.EvaluationContext;
import org.springframework.expression.Expression;
import org.springframework.expression.spel.standard.SpelExpressionParser;
import org.springframework.expression.spel.support.StandardEvaluationContext;
import org.springframework.stereotype.Component;

import java.lang.reflect.Array;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

@Aspect
@Component
public class DistributeRateLimiterAspect {

    @Autowired
    private RedissonUtil redissonUtil;

    private static final Logger LOG = LoggerFactory.getLogger(DistributeRateLimiterAspect.class);

    @Pointcut("@annotation(com.dzm.aspect.limiter.DistributeRateLimiter)")
    public void distributeRateLimiter() { }

    @Around("distributeRateLimiter()")
    public Object around(ProceedingJoinPoint pjp) throws Exception {

        Object response = null;
        MethodSignature methodSignature = (MethodSignature) pjp.getSignature();
        Method method = methodSignature.getMethod();
        DistributeRateLimiter distributeRateLimiter = method.getAnnotation(DistributeRateLimiter.class);

        String scene = distributeRateLimiter.scene();
        String key = distributeRateLimiter.key();
        String[] parametersKey = distributeRateLimiter.parametersKey();
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
        String limiterKey = scene + "#" + key;

        int limit = distributeRateLimiter.limit();
        int duration = distributeRateLimiter.duration();

        boolean acquireResult = false;
        if(limit == DistributeRateLimiterConstant.DEFAULT_LIMIT || duration == DistributeRateLimiterConstant.DEFAULT_DURATION){
            acquireResult = true;
        } else {
            RRateLimiter rateLimiter = redissonUtil.getRateLimiter(limiterKey);
            if (!rateLimiter.isExists()) {
                rateLimiter.trySetRate(RateType.OVERALL, limit, duration, RateIntervalUnit.SECONDS);
            }
            acquireResult = rateLimiter.tryAcquire();
        }

        if (!acquireResult) {
            LOG.warn(String.format("rate limiter try acquire failed for key : %s", limiterKey));
            throw ServiceException.builder()
                    .status(ServiceResponseStatusType.RATE_LIMIT_EXCEEDED.getStatus())
                    .serverErrorMessage(String.format("rate limiter try acquire failed for key : %s", limiterKey))
                    .message("wait a moment ...")
                    .build();
        }

        try {
            LOG.info(String.format("rate limiter try acquire success for key : %s", limiterKey));
            response = pjp.proceed();
        } catch (ServiceException e) {
            throw e;
        }
        catch (Throwable e) {
            e.printStackTrace();
            throw ServiceException.builder()
                    .status(ServiceResponseStatusType.SERVER_ERROR.getStatus())
                    .serverErrorMessage(e.getMessage())
                    .build();
        }
        return response;
    }
}
