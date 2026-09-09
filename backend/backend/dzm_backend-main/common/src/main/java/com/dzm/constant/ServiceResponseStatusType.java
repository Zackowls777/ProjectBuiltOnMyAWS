package com.dzm.constant;


import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ServiceResponseStatusType {
    SUCCESS(1),
    FAILURE(0),
    NON_AUTH(2),
    ROLE_DENIED(3),
    PERMISSION_DENIED(4),
    SERVER_BUSY(5),
    SERVER_ERROR(6),
    LOCK_FAILED(7),
    RATE_LIMIT_EXCEEDED(8),;
    final int status;
}
