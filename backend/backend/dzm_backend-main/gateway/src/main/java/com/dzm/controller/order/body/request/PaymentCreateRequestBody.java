package com.dzm.controller.order.body.request;

import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotNull;

@NoArgsConstructor
@Getter
public class PaymentCreateRequestBody {

    @NotNull
    String order;

    int paymentChannel;

    String description;

    String cancelUrl;

    String successUrl;

}
