package com.dzm.controller.order;

import com.dzm.config.interceptor.auth.LoginAuthChecker;
import com.dzm.controller.order.body.request.OrderCancelRequestBody;
import com.dzm.controller.order.body.request.OrderCreateRequestBody;
import com.dzm.order.OrderService;
import com.dzm.order.body.response.ChannelAccessCheckByPaidOrderResponseBody;
import com.dzm.order.body.response.OrderCreateResponseBody;
import com.dzm.order.body.response.OrderListResponseBody;
import com.dzm.response.ServiceResponse;
import com.dzm.util.jwt.JWTPayload;
import org.apache.dubbo.config.annotation.DubboReference;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@RestController
@RequestMapping(path = "/order")
public class OrderController {

    @DubboReference(version = "1.0.0", loadbalance = "roundrobin", check = false)
    private OrderService orderService;

    @GetMapping(path = "ping")
    public ServiceResponse ping() {
        return ServiceResponse.builder().result(orderService.ping()).build();
    }

    @PostMapping(path = "/create")
    @LoginAuthChecker
    public ServiceResponse create(
            @RequestBody OrderCreateRequestBody body,
            HttpServletRequest request
    ) {
        JWTPayload payload = (JWTPayload) request.getAttribute("jwt_payload");
        OrderCreateResponseBody responseBody = orderService.createOrder(System.currentTimeMillis(), payload.getUserId(), body.getChannel());
        System.out.println(responseBody);
        return ServiceResponse.builder().result(responseBody).build();
    }

    @PostMapping(path = "/cancel")
    @LoginAuthChecker
    public ServiceResponse cancel(
            @RequestBody OrderCancelRequestBody body,
            HttpServletRequest request
    ) {
        JWTPayload payload = (JWTPayload) request.getAttribute("jwt_payload");
        orderService.cancelOrder(System.currentTimeMillis(), payload.getUserId(), body.getOrder());
        return ServiceResponse.builder().build();
    }

    @GetMapping(path = "/list")
    @LoginAuthChecker
    public ServiceResponse list(
            HttpServletRequest request
    ) {
        JWTPayload payload = (JWTPayload) request.getAttribute("jwt_payload");
        List<OrderListResponseBody> orders = orderService.listOrder(System.currentTimeMillis(), payload.getUserId());
        return ServiceResponse.builder().result(orders).build();
    }

    @GetMapping(path = "/check-channel-access-by-paid-order")
    @LoginAuthChecker
    public ServiceResponse checkChannelAccessByPaidOrder(
            @RequestParam("channel_id") String channelId,
            HttpServletRequest request
    ) {
        JWTPayload payload = (JWTPayload) request.getAttribute("jwt_payload");
        ChannelAccessCheckByPaidOrderResponseBody body = orderService.checkChannelAccessByPaidOrder(System.currentTimeMillis(), payload.getUserId(), channelId);
        return ServiceResponse.builder().result(body.isAccess()).build();
    }


}
