package com.dzm.order.body.response;

import lombok.Builder;
import lombok.Getter;

import java.io.Serializable;

@Getter
@Builder
public class PaymentCreateResponseBody implements Serializable {

    String url;
}
