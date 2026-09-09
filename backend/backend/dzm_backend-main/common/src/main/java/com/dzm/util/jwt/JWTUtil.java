package com.dzm.util.jwt;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.dzm.exception.ServiceException;
import com.dzm.constant.ServiceResponseStatusType;
import lombok.Data;
import lombok.Getter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.util.Date;

@Component
@Data
@Getter
@ConfigurationProperties(prefix = "jwt.util")
public class JWTUtil {

    private String secret;

    private long expireTime;

    private String algorithm;

    private Algorithm getJwtAlgorithm() {
        if(getAlgorithm().equals("HMAC256")) {
            return Algorithm.HMAC256(getSecret());
        }
        return Algorithm.HMAC256(getSecret());
    }

    public String generateToken(JWTPayload payload) {
        Date expiresAt = new Date();
        expiresAt.setTime(expiresAt.getTime() + getExpireTime() * 1000);
        return JWT.create()
                .withIssuedAt(new Date())
                .withExpiresAt(expiresAt)
                .withClaim("user_id", payload.getUserId())
                .withClaim("role", payload.getRole())
                .withClaim("email", payload.getEmail())
                .withIssuer("dzm")
                .sign(getJwtAlgorithm());
    }

    public JWTPayload validTokenAndConvertToJWTPayload(String token) {
        try {
            DecodedJWT decodedJWT = JWT.require(getJwtAlgorithm()).build().verify(token);
            String userId = decodedJWT.getClaim("user_id").asString().replace("-", "");
            int role = decodedJWT.getClaim("role").asInt();
            String email = decodedJWT.getClaim("email").asString();
            return JWTPayload.builder()
                    .userId(userId)
                    .role(role)
                    .email(email)
                    .build();
        } catch (Exception e) {
            return JWTPayload.builder().build();
        }
    }

}
