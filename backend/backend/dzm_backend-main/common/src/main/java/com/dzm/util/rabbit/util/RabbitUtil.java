package com.dzm.util.rabbit.util;

import com.dzm.exception.ServiceException;
import org.springframework.amqp.core.MessageProperties;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.rabbitmq.client.Channel;
import org.springframework.amqp.core.Message;

@Component
public class RabbitUtil {

    @Autowired
    private RabbitTemplate rabbitTemplate;

    /***
     * @param msg: JSON String
     */
    public void sendMessage(String exchange, String routingKey, String msg) {
        try {
            rabbitTemplate.convertAndSend(exchange, routingKey, msg);
        } catch (Exception e) {
            throw ServiceException.builder()
                    .serverErrorMessage(e.getMessage())
                    .message("message send error.")
                    .build();
        }
    }

    /***
     *
     * @param msg: JSON String
     * @param timeToLiveSeconds： 设定过期时间 消息过期后放入dead letter queue
     */
    public void sendMessage(String exchange, String routingKey, String msg, long timeToLiveSeconds) {
        MessageProperties messageProperties = new MessageProperties();
        messageProperties.setExpiration(String.valueOf(timeToLiveSeconds * 1000));
        Message message = new Message(msg.getBytes(), messageProperties);
        try {
            rabbitTemplate.convertAndSend(exchange, routingKey, message);
        } catch (Exception e) {
            throw ServiceException.builder()
                    .serverErrorMessage(e.getMessage())
                    .message("message send error.")
                    .build();
        }

    }

    /***
     * 返回ack，false表示不批处理
     */
    public void ack(Channel channel, Message message) {
        try {
            channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
        } catch (Exception e) {
            throw ServiceException.builder()
                    .serverErrorMessage(e.getMessage())
                    .message("message ack error.")
                    .build();
        }
    }

    /***
     * 返回nack，false表示不批处理，true表示重新放回队列
     */
    public void nack(Channel channel, Message message) {
        try {
            channel.basicNack(message.getMessageProperties().getDeliveryTag(), false, true);
        } catch (Exception e) {
            throw ServiceException.builder()
                    .serverErrorMessage(e.getMessage())
                    .message("message nack error.")
                    .build();
        }
    }

    /***
     * 拒收消息，false表示不重新放入queue
     */
    public void reject(Channel channel, Message message) {
        try {
            channel.basicReject(message.getMessageProperties().getDeliveryTag(), false);
        } catch (Exception e) {
            throw ServiceException.builder()
                    .serverErrorMessage(e.getMessage())
                    .message("message reject error.")
                    .build();
        }
    }



}
