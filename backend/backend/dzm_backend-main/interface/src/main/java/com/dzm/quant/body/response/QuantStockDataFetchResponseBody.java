package com.dzm.quant.body.response;

import lombok.Builder;
import lombok.Getter;

import java.io.Serializable;

@Builder
@Getter
public class QuantStockDataFetchResponseBody implements Serializable {

    @Builder.Default
    String dataCsv = "";

    @Builder.Default
    boolean loading = true;

}
