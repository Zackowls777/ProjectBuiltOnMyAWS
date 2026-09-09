package com.dzm.channel.section.body.response;

import lombok.Getter;
import lombok.experimental.SuperBuilder;

@SuperBuilder
@Getter
public class ChannelSectionRetrieveResponseBody extends ChannelSectionBasicResponseBody {

    private String channelTitle;

    private String channelCover;

    private String description;

    private String video;

    private String unSignedVideoKey;

    private boolean access;

}
