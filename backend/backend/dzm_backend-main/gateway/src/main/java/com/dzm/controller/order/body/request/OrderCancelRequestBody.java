package com.dzm.controller.order.body.request;


import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotNull;

@NoArgsConstructor
@Getter
public class OrderCancelRequestBody {

    @NotNull
    String order;

}
