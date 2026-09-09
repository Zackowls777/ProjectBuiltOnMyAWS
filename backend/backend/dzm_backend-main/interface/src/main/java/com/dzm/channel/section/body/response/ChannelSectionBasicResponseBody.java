package com.dzm.channel.section.body.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.io.Serializable;
import java.util.UUID;

@SuperBuilder
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class ChannelSectionBasicResponseBody implements Serializable {

    private String id;

    private String channelId;

    private String channelCreatorId;

    private String channelCreatorNickname;

    private String channelCreatorAvatar;

    private String title;

    private String cover;

    private String unSignedCoverKey;

    private Integer duration;

    private Long createdTime;

}
