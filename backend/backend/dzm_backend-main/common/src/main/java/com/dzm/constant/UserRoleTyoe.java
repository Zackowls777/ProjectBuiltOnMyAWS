package com.dzm.constant;


import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum UserRoleTyoe {
    ANONYMOUS(0),
    GENERAL(1),
    ADMIN(2);
    final int role;
}
