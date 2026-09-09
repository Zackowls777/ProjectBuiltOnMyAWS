package com.dzm.util.rabbit.config;

import org.springframework.amqp.core.*;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.HashMap;
import java.util.Map;

@Configuration
public class RabbitConfig {

    public static final String DZM_EXCHANGE= "dzm.exchange";
    public static final String DZM_QUEUE= "dzm.queue";
    public static final String DZM_ROUTING_KEY = "dzm.routing-key";

    public static final String DEAD_LETTER_EXCHANGE= "dead-letter.exchange";
    public static final String DEAD_LETTER_QUEUE= "dead-letter.queue";
    public static final String DEAD_LETTER_ROUTING_KEY = "dead-letter.routing-key";

    @Bean
    public DirectExchange exchange() {
        return new DirectExchange(DZM_EXCHANGE, true, false);
    }

    @Bean
    public Queue queue() {
        Map<String, Object> arguments = new HashMap<>();
        arguments.put("x-dead-letter-exchange", DEAD_LETTER_EXCHANGE);
        arguments.put("x-dead-letter-routing-key", DEAD_LETTER_ROUTING_KEY);
        return new Queue(DZM_QUEUE, true, false, false, arguments);
    }

    @Bean
    public Binding binding(Queue queue, DirectExchange exchange) {
        return BindingBuilder.bind(queue).to(exchange).with(DZM_ROUTING_KEY);
    }

    @Bean(name = "deadLetterDirectExchange")
    public DirectExchange deadLetterDirectExchange() {
        return new DirectExchange(DEAD_LETTER_EXCHANGE, true, false);
    }

    @Bean(name = "deadLetterQueue")
    public Queue deadLetterQueue() {
        return new Queue(DEAD_LETTER_QUEUE);
    }

    @Bean(name = "deadLetterBinding")
    public Binding deadLetterBinding() {
        return BindingBuilder.bind(deadLetterQueue()).to(deadLetterDirectExchange()).with(DEAD_LETTER_ROUTING_KEY);
    }


}