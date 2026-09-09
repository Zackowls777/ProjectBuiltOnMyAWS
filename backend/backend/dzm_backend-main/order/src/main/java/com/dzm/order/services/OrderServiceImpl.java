package com.dzm.order.services;

import com.dzm.channel.channel.ChannelService;
import com.dzm.channel.channel.body.response.ChannelListBasicResponseBody;
import com.dzm.channel.channel.body.response.ChannelRetrieveResponseBody;
import com.dzm.constant.OrderStatusType;
import com.dzm.exception.ServiceException;
import com.dzm.mapper.SubscriptionOrderMapper;
import com.dzm.model.SubscriptionOrder;
import com.dzm.model.SubscriptionOrderExample;
import com.dzm.order.OrderService;
import com.dzm.order.body.response.ChannelAccessCheckByPaidOrderResponseBody;
import com.dzm.order.body.response.OrderCreateResponseBody;
import com.dzm.order.body.response.OrderListResponseBody;
import com.dzm.order.services.asyn.request.OrderExpiredRequest;
import com.dzm.util.json.JSONUtil;
import com.dzm.util.rabbit.config.RabbitConfig;
import com.dzm.util.rabbit.util.RabbitUtil;
import org.apache.dubbo.config.annotation.DubboReference;
import org.apache.dubbo.config.annotation.DubboService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import java.util.*;
import java.util.stream.Collectors;

@DubboService(version = "1.0.0")
public class OrderServiceImpl implements OrderService {

    private static final Logger log = LoggerFactory.getLogger(OrderService.class);

    @DubboReference(version = "1.0.0", loadbalance = "roundrobin", check = false)
    private ChannelService channelService;

    @Autowired
    private SubscriptionOrderMapper subscriptionOrderMapper;

    @Autowired
    private RabbitUtil rabbitUtil;

    @Autowired
    private JSONUtil jsonUtil;

    @Value("${order.time-to-live-seconds}")
    private long orderTimeToLiveSeconds;

    @Override
    public String ping() {
        return "order service pong";

    }

    /***
     *
     * @param identifierTimeStamp 作为 created time 幂等校验
     * @param userId
     * @param channelId
     * @return
     */
    @Override
    public OrderCreateResponseBody createOrder(long identifierTimeStamp, String userId, String channelId) {

        ChannelRetrieveResponseBody channel = channelService.retrieveChannel(identifierTimeStamp, channelId);
        SubscriptionOrderExample example = new SubscriptionOrderExample();
        SubscriptionOrderExample.Criteria criteria = example.createCriteria();
        criteria.andChannelEqualTo(channelId)
                .andUserEqualTo(userId)
                .andStatusIn(new ArrayList<>(){{
                    add(OrderStatusType.PAID.getStatus());
                    add(OrderStatusType.UNPAID.getStatus());
                }});
        example.setOrderByClause("created_time desc");
        List<SubscriptionOrder> orders = subscriptionOrderMapper.selectByExample(example);
        if(orders != null && !orders.isEmpty()) {
            SubscriptionOrder order = orders.get(0);
            if(order.getCreatedTime() == identifierTimeStamp) {
                return OrderCreateResponseBody.builder()
                        .orderId(order.getId())
                        .channelId(channelId)
                        .channelTitle(channel.getTitle())
                        .createdTime(order.getCreatedTime())
                        .status(order.getStatus())
                        .paymentPrice(order.getPaymentPrice())
                        .build();
            }
            throw ServiceException.builder()
                    .message(String.format("Order for channel [%s] already exists, order id: [%s].", channelId, orders.get(0).getId()))
                    .build();
        }
        if(channel.getInventory() <= 0) {
            throw ServiceException.builder()
                    .message(String.format("Channel [%s] in a short inventory.", channel.getTitle()))
                    .build();
        }
        SubscriptionOrder order = SubscriptionOrder.builder()
                .user(userId)
                .channel(channelId)
                .paymentPrice(channel.getPrice())
                .createdTime(identifierTimeStamp)
                .build();
        subscriptionOrderMapper.insert(order);
        channelService.occupyInventory(identifierTimeStamp, order.getChannel(), userId);
        OrderExpiredRequest req = OrderExpiredRequest.builder()
                .orderId(order.getId())
                .channelId(channelId)
                .createTime(order.getCreatedTime())
                .expireTime(orderTimeToLiveSeconds * 1000 + order.getCreatedTime())
                .build();
        rabbitUtil.sendMessage(RabbitConfig.DZM_EXCHANGE, RabbitConfig.DZM_ROUTING_KEY, jsonUtil.toJSON(req), orderTimeToLiveSeconds);
        return OrderCreateResponseBody.builder()
                .orderId(order.getId())
                .channelId(channelId)
                .channelTitle(channel.getTitle())
                .createdTime(order.getCreatedTime())
                .status(order.getStatus())
                .paymentPrice(order.getPaymentPrice())
                .build();
    }

    /***
     *
     * @param identifierTimeStamp 作为 modified time 幂等校验
     * @param userId
     * @param orderId
     */
    @Override
    public void cancelOrder(long identifierTimeStamp, String userId, String orderId) {
        SubscriptionOrder order = subscriptionOrderMapper.selectByPrimaryKey(orderId);
        if(order == null || !order.getUser().equals(userId)) {
            throw ServiceException.builder()
                    .message(String.format("Order [%s] not exist.", orderId))
                    .build();
        } else if(order.getModifiedTime() == identifierTimeStamp) {
            return ;
        }
        order.checkStatus(OrderStatusType.UNPAID.getStatus());
        order.setStatus(OrderStatusType.CANCELED.getStatus());
        order.setModifiedTime(identifierTimeStamp);
        subscriptionOrderMapper.updateByPrimaryKeySelective(order);
        channelService.revokeInventory(identifierTimeStamp, order.getChannel(), userId);
    }

    @Override
    public List<OrderListResponseBody> listOrder(long identifierTimeStamp, String userId) throws ServiceException {

        // fetch orders
        SubscriptionOrderExample example = new SubscriptionOrderExample();
        SubscriptionOrderExample.Criteria criteria = example.createCriteria();
        criteria.andUserEqualTo(userId);
        example.setOrderByClause("created_time desc");
        List<SubscriptionOrder> orders = subscriptionOrderMapper.selectByExample(example);

        // fetch channels
        List<String> channelsId = orders.stream().map(SubscriptionOrder::getChannel).collect(Collectors.toList());
        List<ChannelListBasicResponseBody> channels = channelService.listChannel(identifierTimeStamp, channelsId);
        Map<String, String> channelId2Title = new HashMap<>();
        channels.forEach(channel -> {channelId2Title.put(channel.getId(), channel.getTitle());});

        // build response bodies
        List<OrderListResponseBody> responseBodies = new ArrayList<>();
        orders.forEach(order -> {
            responseBodies.add(OrderListResponseBody.builder()
                            .orderId(order.getId())
                            .channelId(order.getChannel())
                            .channelTitle(channelId2Title.getOrDefault(order.getChannel(), ""))
                            .paymentPrice(order.getPaymentPrice())
                            .createdTime(order.getCreatedTime())
                            .status(order.getStatus())
                            .build());
        });
        return responseBodies;
    }

    @Override
    public ChannelAccessCheckByPaidOrderResponseBody checkChannelAccessByPaidOrder(long identifierTimeStamp, String userId, String channelId) throws ServiceException {
        SubscriptionOrderExample example = new SubscriptionOrderExample();
        SubscriptionOrderExample.Criteria criteria = example.createCriteria();
        criteria.andUserEqualTo(userId)
                .andChannelEqualTo(channelId)
                .andStatusEqualTo(OrderStatusType.PAID.getStatus());
        boolean access = subscriptionOrderMapper.countByExample(example) > 0;
        return ChannelAccessCheckByPaidOrderResponseBody.builder()
                .channelId(channelId).access(access)
                .build();
    }

}
