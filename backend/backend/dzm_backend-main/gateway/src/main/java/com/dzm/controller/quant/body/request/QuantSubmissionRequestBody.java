package com.dzm.controller.quant.body.request;

import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
public class QuantSubmissionRequestBody {

    private String symbol;

    private String startDay;

    private String endDay;

    private String code;

}
