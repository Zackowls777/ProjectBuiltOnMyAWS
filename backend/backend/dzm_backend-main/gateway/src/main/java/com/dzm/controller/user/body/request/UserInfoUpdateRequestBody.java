package com.dzm.controller.user.body.request;

import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;

@NoArgsConstructor
@Getter
public class UserInfoUpdateRequestBody {

    private String nickname;

    private String avatar;

}
