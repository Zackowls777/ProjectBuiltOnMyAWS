package com.dzm.controller.s3.body.response;

import lombok.Builder;
import lombok.Getter;

import java.io.Serializable;

@Builder
@Getter
public class PreSignS3KeyResponseBody implements Serializable {

    String preSignedPutUrl;

    String preSignedGetUrl;

}
