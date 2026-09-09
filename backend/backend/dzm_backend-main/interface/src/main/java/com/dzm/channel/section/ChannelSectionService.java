package com.dzm.channel.section;

import com.dzm.channel.section.body.response.ChannelSectionListResponseBody;
import com.dzm.channel.section.body.response.ChannelSectionRetrieveResponseBody;
import com.dzm.exception.ServiceException;
import com.github.pagehelper.PageInfo;

import java.util.List;

public interface ChannelSectionService {

    String ping() throws ServiceException;

    void createChannelSection(long identifierTimeStamp, String userId, String channelId, String title, String description, String cover, String video, int duration) throws ServiceException;

    void deleteChannelSection(long identifierTimeStamp, String userId, String channelSectionId) throws ServiceException;

    void updateChannelSection(long identifierTimeStamp, String userId, String channelSectionId, String title, String description, String cover, String video, int duration) throws ServiceException;

    ChannelSectionRetrieveResponseBody retrieveChannelSection(long identifierTimeStamp, String userId, String channelSectionId) throws ServiceException;

    PageInfo<ChannelSectionListResponseBody> listSectionsForChannel(long identifierTimeStamp, String userId, String channelId, int pageNumber, int pageSize) throws ServiceException;

    PageInfo<ChannelSectionListResponseBody> listChannelSectionsByRecommendation(long identifierTimeStamp, String userId, int pageNumber, int pageSize) throws ServiceException;

    PageInfo<ChannelSectionListResponseBody> listChannelSectionsBySearch(long identifierTimeStamp, String search, int pageNumber, int pageSize) throws ServiceException;

}
