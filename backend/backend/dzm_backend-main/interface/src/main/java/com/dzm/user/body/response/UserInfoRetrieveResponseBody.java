package com.dzm.user.body.response;

import lombok.experimental.SuperBuilder;


@SuperBuilder
public class UserInfoRetrieveResponseBody extends UserInfoBasicResponseBody {

    String email;

    Integer role;

}
