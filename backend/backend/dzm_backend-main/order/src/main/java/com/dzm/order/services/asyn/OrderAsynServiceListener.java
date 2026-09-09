package com.dzm.order.services.asyn;


import com.dzm.channel.channel.ChannelService;
import com.dzm.constant.OrderStatusType;
import com.dzm.mapper.SubscriptionOrderMapper;
import com.dzm.model.SubscriptionOrder;
import com.dzm.order.services.asyn.request.OrderExpiredRequest;
import com.dzm.util.json.JSONUtil;
import com.dzm.util.rabbit.config.RabbitConfig;
import com.dzm.util.rabbit.util.RabbitUtil;
import com.rabbitmq.client.Channel;
import org.apache.dubbo.config.annotation.DubboReference;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class OrderAsynServiceListener {

    @Autowired
    private JSONUtil jsonUtil;

    @Autowired
    private RabbitUtil rabbitUtil;

    @Autowired
    private SubscriptionOrderMapper subscriptionOrderMapper;

    @DubboReference(version = "1.0.0", loadbalance = "roundrobin", check = false)
    private ChannelService channelService;

    @RabbitListener(queues = RabbitConfig.DEAD_LETTER_QUEUE)
    public void deadLetterConsume(String msg, Channel channel, Message message) {

        OrderExpiredRequest req = jsonUtil.parseJSON(msg, OrderExpiredRequest.class);

        SubscriptionOrder order = subscriptionOrderMapper.selectByPrimaryKey(req.getOrderId());
        if(order != null && order.getStatus().equals(OrderStatusType.UNPAID.getStatus())) {
            order.setStatus(OrderStatusType.EXPIRED.getStatus());
            subscriptionOrderMapper.updateByPrimaryKeySelective(order);
            channelService.revokeInventory(System.currentTimeMillis(), order.getChannel(), order.getUser());
        }

        rabbitUtil.ack(channel, message);
    }

}









