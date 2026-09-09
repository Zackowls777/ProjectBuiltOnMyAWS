package com.dzm.order.body.response;

import lombok.Builder;
import lombok.Getter;

import java.io.Serializable;

@Builder
@Getter
public class ChannelAccessCheckByPaidOrderResponseBody implements Serializable {

    private String channelId;

    private boolean access;

}
