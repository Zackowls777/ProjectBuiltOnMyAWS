package com.dzm.channel.channel.body.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.io.Serializable;

@SuperBuilder
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class ChannelBasicResponseBody implements Serializable {

    private String id;

    private String title;

    private String cover;

    private String unSignedCoverKey;

    private Integer price;

    private Integer inventory;

    private Long createdTime;

}
