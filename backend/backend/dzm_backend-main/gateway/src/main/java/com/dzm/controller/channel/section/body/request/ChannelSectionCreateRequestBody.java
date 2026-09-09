package com.dzm.controller.channel.section.body.request;

import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
public class ChannelSectionCreateRequestBody {

    private String channel;

    private String title;

    private String description;

    private String cover;

    private String video;

    private int duration;

}