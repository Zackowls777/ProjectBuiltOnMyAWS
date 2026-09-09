package com.dzm.controller.channel.channel.body.request;


import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
public class ChannelUpdateRequestBody {

    private String id;

    private String title;

    private String description;

    private String cover;

    private Integer price;

    private Integer inventory;

}
