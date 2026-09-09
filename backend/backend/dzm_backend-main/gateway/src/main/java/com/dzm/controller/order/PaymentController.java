package com.dzm.controller.order;


import com.dzm.config.interceptor.auth.LoginAuthChecker;
import com.dzm.controller.order.body.request.PaymentCreateRequestBody;
import com.dzm.order.PaymentService;
import com.dzm.order.body.response.PaymentCreateResponseBody;
import com.dzm.order.body.response.PaymentExecuteResponseBody;
import com.dzm.response.ServiceResponse;
import com.dzm.util.jwt.JWTPayload;
import org.apache.dubbo.config.annotation.DubboReference;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping(path = "/payment")
public class PaymentController {

    @DubboReference(version = "1.0.0", loadbalance = "roundrobin", check = false)
    private PaymentService paymentService;

    @GetMapping(path = "ping")
    public ServiceResponse ping() {
        return ServiceResponse.builder().result(paymentService.ping()).build();
    }

    @PostMapping(path = "/create")
    @LoginAuthChecker
    public ServiceResponse createPayment(
            @RequestBody PaymentCreateRequestBody body, HttpServletRequest request
            ) {
        JWTPayload payload = (JWTPayload) request.getAttribute("jwt_payload");
        PaymentCreateResponseBody result = paymentService.createPayment(System.currentTimeMillis(), payload.getUserId(), body.getOrder(), body.getPaymentChannel(), body.getDescription(), body.getCancelUrl(), body.getSuccessUrl());
        return ServiceResponse.builder().result(result).build();
    }

    @GetMapping(path = "/paypal/execute")
    public ServiceResponse executePaypalPayment(
            @RequestParam("paymentId") String paymentId,
            @RequestParam("token") String token,
            @RequestParam("PayerID") String payerId
    ) {
        PaymentExecuteResponseBody result = paymentService.executePaypalPayment(System.currentTimeMillis(), paymentId, payerId);
        return ServiceResponse.builder().result(result).build();
    }

    @GetMapping(path = "/paypal/cancel")
    public ServiceResponse cancelPaypalPayment(
            @RequestParam("token") String token
    ) {
        paymentService.cancelPaypalPayment(System.currentTimeMillis(), token);
        return ServiceResponse.builder().build();
    }

}
