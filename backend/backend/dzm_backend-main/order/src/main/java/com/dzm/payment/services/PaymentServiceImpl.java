package com.dzm.payment.services;

import com.dzm.aspect.lock.DistributeLock;
import com.dzm.constant.OrderStatusType;
import com.dzm.constant.PaymentStatusType;
import com.dzm.exception.ServiceException;
import com.dzm.mapper.PaypalPaymentMapper;
import com.dzm.mapper.SubscriptionOrderMapper;
import com.dzm.model.PaypalPayment;
import com.dzm.model.PaypalPaymentExample;
import com.dzm.model.SubscriptionOrder;
import com.dzm.order.PaymentService;
import com.dzm.order.body.response.PaymentCreateResponseBody;
import com.dzm.order.body.response.PaymentExecuteResponseBody;
import com.dzm.payment.channel.paypal.config.PaypalPaymentIntent;
import com.dzm.payment.channel.paypal.config.PaypalPaymentMethod;
import com.dzm.payment.channel.paypal.service.PaypalService;
import com.paypal.api.payments.Links;
import com.paypal.api.payments.Payment;
import com.paypal.base.rest.PayPalRESTException;
import org.apache.dubbo.config.annotation.DubboService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.net.URL;
import java.util.List;


@DubboService(version = "1.0.0")
public class PaymentServiceImpl implements PaymentService {

    private static final Logger log = LoggerFactory.getLogger(PaymentService.class);

    @Autowired
    private PaypalPaymentMapper paypalPaymentMapper;

    @Autowired
    private SubscriptionOrderMapper subscriptionOrderMapper;

    @Autowired
    private PaypalService paypalService;

    public String ping() {
        return "payment service pong";
    }

    /***
     *
     * @param identifierTimeStamp 作为 created time 幂等校验
     * @param userId
     * @param orderId
     * @param paymentChannel
     * @return payment url
     *
     * @DistributeLock : lock for order
     */
    @DistributeLock(scene = "payment-create", parametersKey = {"orderId"}, waitTime = 1000)
    public PaymentCreateResponseBody createPayment(long identifierTimeStamp, String userId, String orderId, int paymentChannel, String description, String cancelUrl, String successUrl) {
        SubscriptionOrder order = subscriptionOrderMapper.selectByPrimaryKey(orderId);
        if(order == null) {
            throw ServiceException.builder()
                    .message(String.format("Order id: [%s] non exist.", orderId))
                    .build();
        }
        if(!order.getUser().equals(userId)) {
            throw ServiceException.builder()
                    .message(String.format("Order [%s] doesn't belong to you.", orderId))
                    .build();
        }
        switch (paymentChannel) {
            case 1: {
                PaypalPaymentExample paypalPaymentExample = new PaypalPaymentExample();
                PaypalPaymentExample.Criteria paypalPaymentExampleCriteria = paypalPaymentExample.createCriteria();
                paypalPaymentExampleCriteria.andSubscriptionOrderEqualTo(orderId);
                List<PaypalPayment> paypalPayments = paypalPaymentMapper.selectByExample(paypalPaymentExample);

                // 创建新payment
                try {
                    Payment payment = paypalService.createPayment(
                            order.getPaymentPrice(),
                            "USD",
                            PaypalPaymentMethod.paypal,
                            PaypalPaymentIntent.sale,
                            description,
                            cancelUrl,
                            successUrl);
                    for(Links links : payment.getLinks()) {
                        if(links.getRel().equals("approval_url")) {
                            String approval_url = links.getHref(), token = "";
                            for(String q: new URL(approval_url).getQuery().split("&")) {
                                if(q.startsWith("token")) {
                                    token = q.substring("token=".length());
                                }
                            }
                            PaypalPayment paypalPayment = PaypalPayment.builder()
                                    .id(payment.getId())
                                    .token(token)
                                    .approvalUrl(approval_url)
                                    .subscriptionOrder(orderId)
                                    .createdTime(identifierTimeStamp)
                                    .build();
                            paypalPaymentMapper.insert(paypalPayment);
                            return PaymentCreateResponseBody.builder()
                                    .url(approval_url)
                                    .build();
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    throw ServiceException.builder()
                            .message(String.format("Failed to create payment for order [%s].", orderId))
                            .build();
                }
            }
            default: {
                throw ServiceException.builder()
                        .serverErrorMessage(String.format("Payment chanel [%s] non exist.", paymentChannel))
                        .message("This payment chanel non exist.").build();
            }
        }
    }

    /***
     *
     * @param identifierTimeStamp 作为 modified time 幂等校验
     * @param paymentId
     * @param payerId
     * @return “success” or “”
     *
     * @DistributeLock lock for payment
     */
    @DistributeLock(scene = "payment-paypal-execute", parametersKey = {"paymentId"}, waitTime = 1000)
    public PaymentExecuteResponseBody executePaypalPayment(long identifierTimeStamp, String paymentId, String payerId) {
        PaypalPayment paypalPayment = paypalPaymentMapper.selectByPrimaryKey(paymentId);
        if(paypalPayment == null) {
            throw ServiceException.builder()
                    .message(String.format("Payment id: [%s] non exist.", paymentId))
                    .build();
        }

        SubscriptionOrder order = subscriptionOrderMapper.selectByPrimaryKey(paypalPayment.getSubscriptionOrder());
        // 幂等校验
        if(paypalPayment.getModifiedTime() == identifierTimeStamp) {
            return PaymentExecuteResponseBody.builder().channelId(order.getChannel()).build();
        }
        paypalPayment.checkStatus(PaymentStatusType.UNPAID.getStatus());
        order.checkStatus(PaymentStatusType.UNPAID.getStatus());
        try {
            Payment payment = paypalService.executePayment(paymentId, payerId);
            if(payment.getState().equals("approved")){
                paypalPayment.setPayer(payerId);
                paypalPayment.setStatus(PaymentStatusType.PAID.getStatus());
                paypalPayment.setModifiedTime(identifierTimeStamp);
                paypalPaymentMapper.updateByPrimaryKey(paypalPayment);
                order.setStatus(OrderStatusType.PAID.getStatus());
                order.setModifiedTime(identifierTimeStamp);
                subscriptionOrderMapper.updateByPrimaryKey(order);
                return PaymentExecuteResponseBody.builder().channelId(order.getChannel()).build();
            }
        } catch (PayPalRESTException e) {
            log.error(e.getMessage(), e);
            throw new RuntimeException(e);
        }
        throw ServiceException.builder()
                .message(String.format("Payment : [%s] execute failed.", paymentId))
                .build();
    }

    /***
     *
     * @param identifierTimeStamp 作为 modified time 幂等校验
     * @param token
     * @return
     */
    public void cancelPaypalPayment(long identifierTimeStamp, String token) {
        PaypalPaymentExample paypalPaymentExample = new PaypalPaymentExample();
        PaypalPaymentExample.Criteria paypalPaymentExampleCriteria = paypalPaymentExample.createCriteria();
        paypalPaymentExampleCriteria.andTokenEqualTo(token);
        List<PaypalPayment> paypalPayments = paypalPaymentMapper.selectByExample(paypalPaymentExample);
        if(paypalPayments.isEmpty()) {
            throw ServiceException.builder()
                    .serverErrorMessage(String.format("Payment token: [%s] non exist.", token))
                    .message("Payment token non exist.").build();
        }
        PaypalPayment paypalPayment = paypalPayments.get(0);
        // 幂等校验
        if(paypalPayment.getModifiedTime() != identifierTimeStamp) {
            paypalPayment.checkStatus(PaymentStatusType.UNPAID.getStatus());
            paypalPayment.setStatus(PaymentStatusType.CANCELED.getStatus());
            paypalPayment.setModifiedTime(identifierTimeStamp);
            paypalPaymentMapper.updateByPrimaryKey(paypalPayment);
        }
    }

    public String handlePaypalWebhookNotification(long identifierTimeStamp, String notification) {
        return "success";
    }

}
