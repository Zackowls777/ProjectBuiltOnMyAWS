package com.dzm.channel.channel;

import com.dzm.channel.channel.body.response.*;
import com.dzm.exception.ServiceException;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;

import java.util.List;

public interface ChannelService {

    String ping() throws ServiceException;

    void createChannel(long identifierTimeStamp, String userId, String title, String description, String cover, int price, int inventory) throws ServiceException;

    void updateChannel(long identifierTimeStamp, String userId, String channelId, String title, String description, String cover, int price, int inventory) throws ServiceException;

    void deleteChannel(long identifierTimeStamp, String userId, String channelId) throws ServiceException;

    List<ChannelListBasicResponseBody> listChannel(long identifierTimeStamp, List<String> channelIds) throws ServiceException;

    List<ChannelListResponseBody> listChannelForCreator(long identifierTimeStamp, String userId) throws ServiceException;

    PageInfo<ChannelListResponseBody> listChannelByRecommendation(long identifierTimeStamp, String userId, int pageNumber, int pageSize) throws ServiceException;

    PageInfo<ChannelListResponseBody> listChannelBySearch(long identifierTimeStamp, String search, int pageNumber, int pageSize) throws ServiceException;

    ChannelRetrieveResponseBody retrieveChannel(long identifierTimeStamp, String channelId) throws ServiceException;

    void occupyInventory(long identifierTimeStamp, String channelId, String userId) throws ServiceException;

    void revokeInventory(long identifierTimeStamp, String channelId, String userId) throws ServiceException;

}
