package com.dzm.order;

import com.dzm.exception.ServiceException;
import com.dzm.order.body.response.ChannelAccessCheckByPaidOrderResponseBody;
import com.dzm.order.body.response.OrderCreateResponseBody;
import com.dzm.order.body.response.OrderListResponseBody;

import java.util.List;

public interface OrderService {

    String ping() throws ServiceException;

    OrderCreateResponseBody createOrder(long identifierTimeStamp, String userId, String channelId) throws ServiceException;

    void cancelOrder(long identifierTimeStamp, String userId, String orderId) throws ServiceException;

    List<OrderListResponseBody> listOrder(long identifierTimeStamp, String userId) throws ServiceException;

    ChannelAccessCheckByPaidOrderResponseBody checkChannelAccessByPaidOrder(long identifierTimeStamp, String userId, String channelId) throws ServiceException;

}
