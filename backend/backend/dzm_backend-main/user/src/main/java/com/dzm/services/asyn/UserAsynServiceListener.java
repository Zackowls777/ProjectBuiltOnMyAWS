package com.dzm.services.asyn;

import com.alibaba.fastjson2.JSON;
import com.dzm.services.asyn.request.EmailSentRequest;
import com.dzm.util.email.EmailUtil;
import com.dzm.util.json.JSONUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.kafka.support.Acknowledgment;
import org.springframework.stereotype.Component;

import java.time.Duration;

@Component
public class UserAsynServiceListener {

    private static final Logger log = LoggerFactory.getLogger(UserAsynServiceListener.class);

    @Autowired
    private EmailUtil emailUtil;

    @Autowired
    private JSONUtil jsonUtil;

    @KafkaListener(id = "user-email-notify-verifycode",
            idIsGroup = false, topics = "email-send-verifycode",
            containerFactory = "kafkaListenerContainerFactory")
    public void verifycode(String message, Acknowledgment ack) {

        log.info("received message: " + message + " at time: " + System.currentTimeMillis());

        ack.acknowledge();

        EmailSentRequest request = jsonUtil.parseJSON(message, EmailSentRequest.class);
        emailUtil.sendEmail(request.getToEmail(), request.getSubject(), request.getContent());

    }

}
