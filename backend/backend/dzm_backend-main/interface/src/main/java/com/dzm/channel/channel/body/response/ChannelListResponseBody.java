package com.dzm.channel.channel.body.response;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@SuperBuilder
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class ChannelListResponseBody extends ChannelBasicResponseBody {

    String creatorId;

    String creatorNickname;

    String creatorAvatar;

}
