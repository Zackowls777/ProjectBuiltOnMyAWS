package com.dzm.quant.body.response;

import lombok.Builder;
import lombok.Getter;

import java.io.Serializable;

@Builder
@Getter
public class QuantSubmissionResponseBody implements Serializable {

    public String submissionId;

    public Integer result;

    public String output;

}
