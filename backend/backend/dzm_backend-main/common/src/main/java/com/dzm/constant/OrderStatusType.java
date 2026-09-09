package com.dzm.constant;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum OrderStatusType {
    UNPAID(0),
    PAID(1),
    CANCELED(2),
    EXPIRED(3);
    final int status;
}