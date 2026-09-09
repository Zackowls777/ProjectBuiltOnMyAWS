package com.dzm.controller.channel.section;

import com.dzm.channel.section.ChannelSectionService;
import com.dzm.channel.section.body.response.ChannelSectionListResponseBody;
import com.dzm.channel.section.body.response.ChannelSectionRetrieveResponseBody;
import com.dzm.config.interceptor.auth.LoginAuthChecker;
import com.dzm.controller.channel.section.body.request.ChannelSectionCreateRequestBody;
import com.dzm.controller.channel.section.body.request.ChannelSectionDeleteRequestBody;
import com.dzm.controller.channel.section.body.request.ChannelSectionUpdateRequestBody;
import com.dzm.mapper.ChannelMapper;
import com.dzm.mapper.ChannelSectionMapper;
import com.dzm.model.ChannelExample;
import com.dzm.model.ChannelSectionWithBLOBs;
import com.dzm.model.ChannelWithBLOBs;
import com.dzm.response.ServiceResponse;
import com.dzm.util.jwt.JWTPayload;
import com.github.pagehelper.PageInfo;
import org.apache.dubbo.config.annotation.DubboReference;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import java.util.List;
import java.util.Random;
import java.util.UUID;


@RestController
@RequestMapping(path = "/channel-section")
public class ChannelSectionController {

    @DubboReference(version = "1.0.0", loadbalance = "roundrobin", check = false)
    private ChannelSectionService channelSectionService;

    @GetMapping(path = "ping")
    public ServiceResponse ping() {
        return ServiceResponse.builder().result(channelSectionService.ping()).build();
    }

    @PostMapping(path = "/create")
    @LoginAuthChecker
    public ServiceResponse create(
            @RequestBody ChannelSectionCreateRequestBody body,
            HttpServletRequest request
    ) {
        JWTPayload payload = (JWTPayload) request.getAttribute("jwt_payload");
        channelSectionService.createChannelSection(
                System.currentTimeMillis(), payload.getUserId(),
                body.getChannel(), body.getTitle(), body.getDescription(),
                body.getCover(), body.getVideo(), body.getDuration());
        return ServiceResponse.builder().build();
    }

    @PostMapping(path = "/delete")
    @LoginAuthChecker
    public ServiceResponse delete(
            @RequestBody ChannelSectionDeleteRequestBody body,
            HttpServletRequest request
    ) {
        JWTPayload payload = (JWTPayload) request.getAttribute("jwt_payload");
        channelSectionService.deleteChannelSection(
                System.currentTimeMillis(), payload.getUserId(), body.getId());
        return ServiceResponse.builder().build();
    }

    @PostMapping(path = "/update")
    @LoginAuthChecker
    public ServiceResponse update(
            @RequestBody ChannelSectionUpdateRequestBody body,
            HttpServletRequest request
    ) {
        JWTPayload payload = (JWTPayload) request.getAttribute("jwt_payload");
        channelSectionService.updateChannelSection(
                System.currentTimeMillis(), payload.getUserId(), body.getId(),
                body.getTitle(), body.getDescription(),
                body.getCover(), body.getVideo(), body.getDuration());
        return ServiceResponse.builder().build();
    }

    @GetMapping(path = "/retrieve")
    public ServiceResponse retrieve(
            @RequestParam("channel_section_id") String channelSectionId,
            HttpServletRequest request
    ) {
        JWTPayload payload = (JWTPayload) request.getAttribute("jwt_payload");
        ChannelSectionRetrieveResponseBody body = channelSectionService.retrieveChannelSection(
                System.currentTimeMillis(), payload.getUserId(), channelSectionId);
        return ServiceResponse.builder().result(body).build();
    }

    @GetMapping(path = "/list-for-channel")
    public ServiceResponse listForChannel(
            @RequestParam("channel_id") String channelId,
            @RequestParam("page_number") @Min(value = 1) Integer pageNumber,
            @RequestParam("page_size") @Min(value = 1) @Max(value = 20) Integer pageSize,
            HttpServletRequest request
    ) {
        JWTPayload payload = (JWTPayload) request.getAttribute("jwt_payload");
        PageInfo<ChannelSectionListResponseBody> bodies = channelSectionService.listSectionsForChannel(
                System.currentTimeMillis(), payload.getUserId(), channelId, pageNumber, pageSize);
        return ServiceResponse.builder().result(bodies).build();
    }

    @GetMapping(path = "/list-by-recommendation")
    public ServiceResponse listByRecommendation(
            @RequestParam("page_number") @Min(value = 1) Integer pageNumber,
            @RequestParam("page_size") @Min(value = 1) @Max(value = 20) Integer pageSize,
            HttpServletRequest request
    ) {
        JWTPayload payload = (JWTPayload) request.getAttribute("jwt_payload");
        PageInfo<ChannelSectionListResponseBody> bodies = channelSectionService.listChannelSectionsByRecommendation(
                System.currentTimeMillis(), payload.getUserId(), pageNumber, pageSize);
        return ServiceResponse.builder().result(bodies).build();
    }

    @GetMapping(path = "/list-by-search")
    public ServiceResponse listBySearch(
            @RequestParam("page_number") @Min(value = 1) Integer pageNumber,
            @RequestParam("page_size") @Min(value = 1) @Max(value = 20) Integer pageSize,
            @RequestParam("search") @Min(value = 1) @Max(value = 20) String search,
            HttpServletRequest request
    ) {
        PageInfo<ChannelSectionListResponseBody> bodies = channelSectionService.listChannelSectionsBySearch(
                System.currentTimeMillis(), search, pageNumber, pageSize);
        return ServiceResponse.builder().result(bodies).build();
    }

}
