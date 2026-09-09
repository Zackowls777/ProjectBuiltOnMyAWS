package com.dzm.quant.services.asyn.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class QuantFetchStackDataRequest {

    private String id;

    private String symbol;

    private String startDay;

    private String endDay;

}
