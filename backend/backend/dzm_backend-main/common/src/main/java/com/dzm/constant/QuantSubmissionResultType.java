package com.dzm.constant;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum QuantSubmissionResultType {

    PENDING(-3),
    RUNNING(-2),
    WRONG(-1),
    SUCCESS(0),
    CPU_TIME_LIMIT_EXCEEDED(1),
    REAL_TIME_LIMIT_EXCEEDED(2),
    MEMORY_LIMIT_EXCEEDED(3),
    RUNTIME_ERROR(4),
    SYSTEM_ERROR(5),
    COMPILE_ERROR(6),
    NO_COMPILE_ERROR(7);
    final int result;

}
