package com.dzm.controller.s3;

import com.dzm.config.interceptor.auth.LoginAuthChecker;
import com.dzm.constant.ServiceResponseStatusType;
import com.dzm.controller.s3.body.request.PreSignS3KeyRequestBody;
import com.dzm.controller.s3.body.response.PreSignS3KeyResponseBody;
import com.dzm.exception.ServiceException;
import com.dzm.response.ServiceResponse;
import com.dzm.util.jwt.JWTPayload;
import com.dzm.util.s3.util.S3Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping(path = "/s3")
public class S3Controller {

    @Autowired
    private S3Util s3Util;

    @PostMapping("/pre-sign-s3-key")
    @LoginAuthChecker
    public ServiceResponse preSignS3Key(
            @RequestBody @Validated PreSignS3KeyRequestBody body,
            HttpServletRequest request
            ) {
        JWTPayload payload = (JWTPayload) request.getAttribute("jwt_payload");
        String userId = payload.getUserId();
        if(!body.getKey().startsWith(userId)) {
            throw ServiceException.builder()
                    .status(ServiceResponseStatusType.PERMISSION_DENIED.getStatus())
                    .build();
        }
        String getUrl = s3Util.generatePreSignedGetObjectUrl(body.getKey(), 60);
        String putUrl = s3Util.generatePreSignedPutObjectUrl(body.getKey(), body.getMd5());
        PreSignS3KeyResponseBody result = PreSignS3KeyResponseBody.builder()
                .preSignedGetUrl(getUrl)
                .preSignedPutUrl(putUrl)
                .build();
        return ServiceResponse.builder().result(result).build();
    }
}
