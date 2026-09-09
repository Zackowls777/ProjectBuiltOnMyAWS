package com.dzm.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import com.dzm.constant.ServiceResponseStatusType;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ServiceResponse {

    @Builder.Default
    private Object result = null;

    @Builder.Default
    private Long responseTime = System.currentTimeMillis();

    @Builder.Default
    private String message = "";

    @Builder.Default
    private int status = ServiceResponseStatusType.SUCCESS.getStatus();

}