package com.dzm.controller.channel.channel.body.request;


import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotNull;

@NoArgsConstructor
@Getter
public class ChannelCreateRequestBody {

    private String title;

    private String description;

    private String cover;

    private Integer price;

    private Integer inventory;

}
