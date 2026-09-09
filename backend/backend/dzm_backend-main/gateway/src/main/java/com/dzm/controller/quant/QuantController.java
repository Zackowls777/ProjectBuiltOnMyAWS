package com.dzm.controller.quant;

import com.dzm.config.interceptor.auth.LoginAuthChecker;
import com.dzm.controller.order.body.request.OrderCreateRequestBody;
import com.dzm.controller.quant.body.request.QuantSubmissionRequestBody;
import com.dzm.order.body.response.ChannelAccessCheckByPaidOrderResponseBody;
import com.dzm.quant.QuantService;
import com.dzm.quant.body.response.QuantStockDataFetchResponseBody;
import com.dzm.quant.body.response.QuantSubmissionResponseBody;
import com.dzm.response.ServiceResponse;
import com.dzm.util.jwt.JWTPayload;
import org.apache.dubbo.config.annotation.DubboReference;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping(path = "/quant")
public class QuantController {

    @DubboReference(version = "1.0.0", loadbalance = "roundrobin", check = false)
    private QuantService quantService;

    @GetMapping(path = "/fetch-stock-data")
    @LoginAuthChecker
    public ServiceResponse fetchStockData(
            @RequestParam("symbol") String symbol,
            @RequestParam("start_day") String startDay,
            @RequestParam("end_day") String endDay,
            HttpServletRequest request
    ) {
        JWTPayload payload = (JWTPayload) request.getAttribute("jwt_payload");
        QuantStockDataFetchResponseBody body = quantService.fetchStockData(
                System.currentTimeMillis(), payload.getUserId(), symbol, startDay, endDay);
        return ServiceResponse.builder().result(body).build();
    }

    @PostMapping(path = "/submit")
    @LoginAuthChecker
    public ServiceResponse submit(
            @RequestBody QuantSubmissionRequestBody requestBody,
            HttpServletRequest request
    ) {
        JWTPayload payload = (JWTPayload) request.getAttribute("jwt_payload");
        QuantSubmissionResponseBody responseBody = quantService.submit(
                System.currentTimeMillis(), payload.getUserId(), requestBody.getSymbol(),
                requestBody.getStartDay(), requestBody.getEndDay(), requestBody.getCode()
        );
        return ServiceResponse.builder().result(responseBody).build();
    }

    @GetMapping(path = "/fetch-submission-result")
    @LoginAuthChecker
    public ServiceResponse fetchSubmissionResult(
            @RequestParam("submission_id") String submissionId,
            HttpServletRequest request
    ) {
        JWTPayload payload = (JWTPayload) request.getAttribute("jwt_payload");
        QuantSubmissionResponseBody responseBody = quantService.fetchSubmissionResult(
                System.currentTimeMillis(), payload.getUserId(), submissionId
        );
        return ServiceResponse.builder().result(responseBody).build();
    }

}
