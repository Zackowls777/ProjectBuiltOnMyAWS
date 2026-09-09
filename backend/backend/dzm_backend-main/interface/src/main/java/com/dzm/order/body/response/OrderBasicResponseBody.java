package com.dzm.order.body.response;

import lombok.Getter;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

import java.io.Serializable;

@SuperBuilder
@Getter
@Setter
public class OrderBasicResponseBody implements Serializable {

    private String orderId;

    private String channelId;

    private String channelTitle;

    private Integer paymentPrice;

    private Integer status;

    private Long createdTime;

}
