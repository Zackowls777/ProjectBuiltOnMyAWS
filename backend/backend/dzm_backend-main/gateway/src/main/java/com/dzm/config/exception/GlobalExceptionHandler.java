package com.dzm.config.exception;


import com.dzm.constant.ServiceResponseStatusType;
import com.dzm.exception.ServiceException;
import com.dzm.response.ServiceResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.http.HttpStatus;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;

@ControllerAdvice
@ResponseBody
@ResponseStatus(HttpStatus.ACCEPTED)
public class GlobalExceptionHandler {

    private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ServiceResponse handleMethodArgumentNotValidException(MethodArgumentNotValidException e) {
        BindingResult result = e.getBindingResult();
        FieldError error = result.getFieldError();
        String message = String.format("%s : %s", error.getField(), error.getDefaultMessage());
        return ServiceResponse.builder()
                .message(message)
                .status(ServiceResponseStatusType.FAILURE.getStatus())
                .build();
    }

    @ExceptionHandler(ConstraintViolationException.class)
    public ServiceResponse handleConstraintViolationException(ConstraintViolationException e){
        for(ConstraintViolation<?> s:e.getConstraintViolations()){
            return ServiceResponse.builder()
                    .message(s.getInvalidValue() + " : " + s.getMessage())
                    .status(ServiceResponseStatusType.FAILURE.getStatus())
                    .build();
        }
        return ServiceResponse.builder()
                .message("constraintViolationException")
                .status(ServiceResponseStatusType.FAILURE.getStatus())
                .build();
    }

    @ExceptionHandler(ServiceException.class)
    public ServiceResponse handleServiceException(ServiceException e){
        logger.error(e.getServerErrorMessage());
        return ServiceResponse.builder()
                .message(e.getMessage())
                .status(e.getStatus()).build();
    }

    @ExceptionHandler(Exception.class)
    public ServiceResponse handleException(Exception e){
        logger.error(e.getMessage());
        return ServiceResponse.builder()
                .message("Server Error.")
                .status(ServiceResponseStatusType.SERVER_ERROR.getStatus())
                .build();
    }

}


