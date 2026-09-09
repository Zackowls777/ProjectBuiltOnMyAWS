package com.dzm.controller.user.body.request;

import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;

@NoArgsConstructor
@Getter
public class ResetPasswordRequestBody {

    @NotNull(message = "Please check email info")
    @Email(message = "Please check email info")
    private String email;

    @NotNull(message = "Please check code info")
    private String code;

    @NotNull(message = "Please check password info")
    private String password;

}
