package com.dzm.user.body.response;

import lombok.Getter;
import lombok.experimental.SuperBuilder;

import java.io.Serializable;


@SuperBuilder
@Getter
public class UserInfoBasicResponseBody implements Serializable {


    private String id;

    private String username;

    private String nickname;

    private String avatar;

    private String unSignedAvatarKey;

}
