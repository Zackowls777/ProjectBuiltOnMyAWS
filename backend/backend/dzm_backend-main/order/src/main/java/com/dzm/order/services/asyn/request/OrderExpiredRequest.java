package com.dzm.order.services.asyn.request;

import lombok.*;
import org.checkerframework.checker.units.qual.A;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderExpiredRequest {

    private String orderId;
    private String channelId;
    private Long createTime;
    private Long expireTime;

}
