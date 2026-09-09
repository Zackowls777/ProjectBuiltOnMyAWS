package com.dzm.controller.user.body.request;

import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;

@NoArgsConstructor
@Getter
public class RetrieveVerifyCodeRequestBody {

    @NotNull(message = "Please check email info")
    @Email(message = "Please check email info")
    private String email;

    private int type;

}
