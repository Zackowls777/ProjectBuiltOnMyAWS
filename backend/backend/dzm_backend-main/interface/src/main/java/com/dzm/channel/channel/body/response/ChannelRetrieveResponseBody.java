package com.dzm.channel.channel.body.response;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

@SuperBuilder
@Getter
@Setter
public class ChannelRetrieveResponseBody extends ChannelBasicResponseBody {

    String description;

    String creatorId;

    String creatorNickname;

    String creatorAvatar;

}
