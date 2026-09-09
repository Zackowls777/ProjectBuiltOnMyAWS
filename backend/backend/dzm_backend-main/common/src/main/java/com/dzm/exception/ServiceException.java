package com.dzm.exception;

import com.dzm.constant.ServiceResponseStatusType;
import lombok.*;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
public class ServiceException extends RuntimeException{

    @Builder.Default
    private int status = ServiceResponseStatusType.FAILURE.getStatus();

    @Builder.Default
    private String message = "";

    @Builder.Default
    private String serverErrorMessage = "";

}