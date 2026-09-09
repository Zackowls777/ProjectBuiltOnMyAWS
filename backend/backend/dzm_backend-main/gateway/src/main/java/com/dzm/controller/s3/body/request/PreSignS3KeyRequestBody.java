package com.dzm.controller.s3.body.request;


import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotNull;

@NoArgsConstructor
@Getter
public class PreSignS3KeyRequestBody {

    @NotNull
    String key;

    @NotNull
    String md5;

}
