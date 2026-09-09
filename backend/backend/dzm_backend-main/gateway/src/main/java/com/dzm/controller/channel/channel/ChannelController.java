package com.dzm.controller.channel.channel;

import com.dzm.channel.channel.ChannelService;
import com.dzm.channel.channel.body.response.*;
import com.dzm.config.interceptor.auth.LoginAuthChecker;
import com.dzm.controller.channel.channel.body.request.ChannelCreateRequestBody;
import com.dzm.controller.channel.channel.body.request.ChannelDeleteRequestBody;
import com.dzm.controller.channel.channel.body.request.ChannelUpdateRequestBody;
import com.dzm.controller.order.body.request.OrderCreateRequestBody;
import com.dzm.order.body.response.OrderCreateResponseBody;
import com.dzm.response.ServiceResponse;
import com.dzm.util.jwt.JWTPayload;
import com.github.pagehelper.PageInfo;
import org.apache.dubbo.config.annotation.DubboReference;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import java.util.List;

@RestController
@RequestMapping(path = "/channel")
public class ChannelController {

    @DubboReference(version = "1.0.0", loadbalance = "roundrobin", check = false)
    private ChannelService channelService;

    @GetMapping(path = "ping")
    public ServiceResponse ping() {
        return ServiceResponse.builder().result(channelService.ping()).build();
    }


    @PostMapping(path = "/create")
    @LoginAuthChecker
    public ServiceResponse create(
            @RequestBody ChannelCreateRequestBody body,
            HttpServletRequest request
    ) {
        JWTPayload payload = (JWTPayload) request.getAttribute("jwt_payload");
        channelService.createChannel(
                System.currentTimeMillis(), payload.getUserId(),
                body.getTitle(), body.getDescription(), body.getCover(), body.getPrice(), body.getInventory()
                );
        return ServiceResponse.builder().build();
    }

    @PostMapping(path = "/update")
    @LoginAuthChecker
    public ServiceResponse update(
            @RequestBody ChannelUpdateRequestBody body,
            HttpServletRequest request
    ) {
        JWTPayload payload = (JWTPayload) request.getAttribute("jwt_payload");
        channelService.updateChannel(
                System.currentTimeMillis(), payload.getUserId(),
                body.getId(), body.getTitle(), body.getDescription(), body.getCover(), body.getPrice(), body.getInventory()
        );
        return ServiceResponse.builder().build();
    }

    @PostMapping(path = "/delete")
    @LoginAuthChecker
    public ServiceResponse delete(
            @RequestBody ChannelDeleteRequestBody body,
            HttpServletRequest request
    ) {
        JWTPayload payload = (JWTPayload) request.getAttribute("jwt_payload");
        channelService.deleteChannel(
                System.currentTimeMillis(), payload.getUserId(), body.getId()
        );
        return ServiceResponse.builder().build();
    }

    @GetMapping(path = "/retrieve")
    public ServiceResponse retrieve(
            @RequestParam("channel_id") String channelId
    ) {
        ChannelRetrieveResponseBody responseBody = channelService.retrieveChannel(System.currentTimeMillis(), channelId);
        return ServiceResponse.builder().result(responseBody).build();
    }

    @GetMapping(path = "/list-for-creator")
    @LoginAuthChecker
    public ServiceResponse listForCreator(HttpServletRequest request) {
        JWTPayload payload = (JWTPayload) request.getAttribute("jwt_payload");
        List<ChannelListResponseBody> responseBodies = channelService.listChannelForCreator(System.currentTimeMillis(), payload.getUserId());
        return ServiceResponse.builder().result(responseBodies).build();
    }

    @GetMapping(path = "/list-by-recommendation")
    public ServiceResponse listByRecommendationForAuthUser(
            @RequestParam("page_number") @Min(value = 1) Integer pageNumber,
            @RequestParam("page_size") @Min(value = 1) @Max(value = 20) Integer pageSize,
            HttpServletRequest request
    ) {
        JWTPayload payload = (JWTPayload) request.getAttribute("jwt_payload");
        PageInfo<ChannelListResponseBody> responseBodies = channelService.listChannelByRecommendation(System.currentTimeMillis(), payload.getUserId(), pageNumber, pageSize);
        return ServiceResponse.builder().result(responseBodies).build();
    }

    @GetMapping(path = "/list-by-search")
    public ServiceResponse listBySearch(
            @RequestParam("page_number") @Min(value = 1) Integer pageNumber,
            @RequestParam("page_size") @Min(value = 1) @Max(value = 20) Integer pageSize,
            @RequestParam("search") String search,
            HttpServletRequest request
    ) {
        PageInfo<ChannelListResponseBody> responseBodies = channelService.listChannelBySearch(System.currentTimeMillis(), search, pageNumber, pageSize);
        return ServiceResponse.builder().result(responseBodies).build();
    }

}
