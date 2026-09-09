package com.dzm.util.password;

import lombok.Data;
import lombok.Getter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import java.nio.charset.StandardCharsets;
import java.security.spec.KeySpec;
import java.util.Base64;
import java.util.Random;

@Component
@Data
@Getter
@ConfigurationProperties(
        prefix = "password.util"
)
public class PasswordUtil {

    private String algorithm;
    private int iteration;
    private int encodePwdLength;

    private SecretKeyFactory getSecretKeyFactoryInstance(String algorithm) {
        try {
            if(algorithm.equals("pbkdf2_sha256")) {
                return SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
            }
            return SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private String getSalt() {
        String str="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        Random random = new Random();
        StringBuilder sb= new StringBuilder();
        for(int i = 0; i < 32; i++){
            int number=random.nextInt(62);
            sb.append(str.charAt(number));
        }
        return sb.toString();
    }

    private String hashfunction(String algorithm, String pwd, String salt, int iteration) {
        SecretKeyFactory keyFactory = getSecretKeyFactoryInstance(algorithm);
        KeySpec keySpec = new PBEKeySpec(
                pwd.toCharArray(),
                salt.getBytes(StandardCharsets.UTF_8),
                iteration,
                256
        );
        SecretKey secretKey = null;
        try {
            secretKey = keyFactory.generateSecret(keySpec);
            byte[] rawHash = secretKey.getEncoded();
            byte[] hash = Base64.getEncoder().encode(rawHash);
            return new String(hash);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    public String encode(String pwd) {
        String salt = getSalt(), algorithm = getAlgorithm();
        int iteration = getIteration();
        String hash = hashfunction(algorithm, pwd, salt, iteration);
        return String.format("%s$%d$%s$%s", algorithm, iteration, salt, hash);
    }

    public boolean verify(String pwd, String encodePwd) {
        String[] parts = encodePwd.split("\\$");
        if (parts.length != 4) {
            return false;
        }
        int iterations = Integer.parseInt(parts[1]);
        String algorithm = parts[0], salt = parts[2];
        String hash = hashfunction(algorithm, pwd, salt, iterations);
        return hash.equals(parts[3]);
    }

}
