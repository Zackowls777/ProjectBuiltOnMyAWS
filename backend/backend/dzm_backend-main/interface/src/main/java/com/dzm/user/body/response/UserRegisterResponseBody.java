package com.dzm.user.body.response;

import lombok.Getter;
import lombok.experimental.SuperBuilder;

import java.io.Serializable;

@SuperBuilder
@Getter
public class UserRegisterResponseBody implements Serializable {

    private String token;

}
