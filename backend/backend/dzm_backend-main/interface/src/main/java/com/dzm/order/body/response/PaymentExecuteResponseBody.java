package com.dzm.order.body.response;

import lombok.Builder;
import lombok.Getter;

import java.io.Serializable;

@Getter
@Builder
public class PaymentExecuteResponseBody implements Serializable {

    String orderId;

    String channelId;

}
