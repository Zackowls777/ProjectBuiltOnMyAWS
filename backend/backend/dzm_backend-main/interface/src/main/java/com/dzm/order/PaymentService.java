package com.dzm.order;

import com.dzm.exception.ServiceException;
import com.dzm.order.body.response.PaymentCreateResponseBody;
import com.dzm.order.body.response.PaymentExecuteResponseBody;

public interface PaymentService {

    String ping() throws ServiceException;

    PaymentCreateResponseBody createPayment(long identifierTimeStamp, String userId, String orderId, int paymentChannel, String description, String cancelUrl, String successUrl) throws ServiceException;

    PaymentExecuteResponseBody executePaypalPayment(long identifierTimeStamp, String paymentId, String payerId) throws ServiceException;

    void  cancelPaypalPayment(long identifierTimeStamp, String token) throws ServiceException;

    String handlePaypalWebhookNotification(long identifierTimeStamp, String notification) throws ServiceException;

}
