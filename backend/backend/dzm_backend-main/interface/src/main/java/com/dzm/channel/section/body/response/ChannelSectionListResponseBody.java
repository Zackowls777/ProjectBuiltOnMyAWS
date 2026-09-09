package com.dzm.channel.section.body.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.util.UUID;

@SuperBuilder
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class ChannelSectionListResponseBody extends ChannelSectionBasicResponseBody {

    @Builder.Default
    private String redundant = UUID.randomUUID().toString();

}
