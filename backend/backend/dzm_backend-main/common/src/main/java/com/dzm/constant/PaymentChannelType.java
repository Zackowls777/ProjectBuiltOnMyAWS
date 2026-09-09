package com.dzm.constant;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum PaymentChannelType {
    PAYPAL(1);
    final int type;
}
