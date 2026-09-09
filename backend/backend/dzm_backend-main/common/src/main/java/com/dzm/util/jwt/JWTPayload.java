package com.dzm.util.jwt;

import com.dzm.constant.UserRoleTyoe;
import lombok.Builder;
import lombok.Getter;

@Builder
@Getter
public class JWTPayload {

    @Builder.Default
    public String userId = "";

    @Builder.Default
    public String email = "";

    @Builder.Default
    public int role = UserRoleTyoe.ANONYMOUS.getRole();

}
