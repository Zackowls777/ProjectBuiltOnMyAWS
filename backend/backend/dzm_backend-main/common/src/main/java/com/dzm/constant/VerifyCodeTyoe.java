package com.dzm.constant;


import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum VerifyCodeTyoe {
    REGISTER(0),
    RESET_PWD(1),
    LOGIN(2);
    final int codeType;
}
