package com.dzm.constant;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum VerifyCodeType {
    REGISTER(0),
    RESET_PASSWORD(1),
    LOGIN(2);
    final int type;
}