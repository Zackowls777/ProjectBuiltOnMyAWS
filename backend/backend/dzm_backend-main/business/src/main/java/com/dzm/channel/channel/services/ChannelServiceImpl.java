package com.dzm.channel.channel.services;

import com.dzm.aspect.cache.DistributeCache;
import com.dzm.channel.channel.ChannelService;
import com.dzm.channel.channel.body.response.*;
import com.dzm.exception.ServiceException;
import com.dzm.mapper.ChannelMapper;
import com.dzm.mapper.ChannelSectionMapper;
import com.dzm.mapper.UserInfoMapper;
import com.dzm.model.*;
import com.dzm.order.OrderService;
import com.dzm.user.UserService;
import com.dzm.user.body.response.UserInfoBasicResponseBody;
import com.dzm.user.body.response.UserInfoListResponseBody;
import com.dzm.user.body.response.UserInfoRetrieveResponseBody;
import com.dzm.util.s3.util.S3Util;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.dubbo.config.annotation.DubboReference;

import org.apache.dubbo.config.annotation.DubboService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.*;
import java.util.stream.Collectors;


@DubboService(version = "1.0.0")
public class ChannelServiceImpl implements ChannelService {

    @Autowired
    private ChannelMapper channelMapper;

    @Autowired
    private S3Util s3Util;

    @DubboReference(version = "1.0.0", loadbalance = "roundrobin", check = false)
    private UserService userService;

    @DubboReference(version = "1.0.0", loadbalance = "roundrobin", check = false)
    private OrderService orderService;

    @Override
    public String ping() throws ServiceException {
        return "channel service pong";
    }

    /***
     *
     * @param identifierTimeStamp 作为 createTime 幂等校验
     * @param userId
     * @param title
     * @param description
     * @param price
     * @param inventory
     * @return
     * @throws ServiceException
     */
    @Override
    public void createChannel(long identifierTimeStamp, String userId, String title, String description, String cover, int price, int inventory) throws ServiceException {
        ChannelExample example = new ChannelExample();
        ChannelExample.Criteria criteria = example.createCriteria();
        criteria.andCreatorEqualTo(userId).andCreatedTimeEqualTo(identifierTimeStamp);
        List<ChannelWithBLOBs> channels = channelMapper.selectByExampleWithBLOBs(example);
        ChannelWithBLOBs channel = null;
        if(channels != null && !channels.isEmpty()) {
            channel = channels.get(0);
        }
        if(channel == null) {
            channel = ChannelWithBLOBs.builder()
                    .creator(userId)
                    .price(price)
                    .inventory(inventory)
                    .createdTime(identifierTimeStamp)
                    .title(title)
                    .cover(cover)
                    .description(description)
                    .build();
            channelMapper.insert(channel);
        }
    }

    @Override
    public void updateChannel(long identifierTimeStamp, String userId, String channelId, String title, String description, String cover, int price, int inventory) throws ServiceException {
        ChannelWithBLOBs channel = fetchChannelById(channelId);
        if(!channel.getCreator().equals(userId)) {
            throw ServiceException.builder()
                    .message(String.format("Channel [%s] non exist.", channelId))
                    .build();
        }
        if(channel.getModifiedTime() != identifierTimeStamp) {
            channel.setTitle(title);
            channel.setDescription(description);
            channel.setPrice(price);
            channel.setInventory(inventory);
            channel.setCover(cover);
            channelMapper.updateByPrimaryKeyWithBLOBs(channel);
        }
    }

    @Override
    public void deleteChannel(long identifierTimeStamp, String userId, String channelId) throws ServiceException {
        ChannelWithBLOBs channel = channelMapper.selectByPrimaryKey(channelId);
        if(channel == null || !channel.getCreator().equals(userId)) {
            throw ServiceException.builder()
                    .message(String.format("Channel [%s] non exist.", channelId))
                    .build();
        }
        if(channel.getIsDeleted()) {
            if(channel.getModifiedTime() != identifierTimeStamp) {
                throw ServiceException.builder()
                        .message(String.format("Channel [%s] has been deleted.", channelId))
                        .build();
            }
        } else {
            channel.setModifiedTime(identifierTimeStamp);
            channel.setIsDeleted(true);
            channelMapper.updateByPrimaryKeySelective(channel);
        }
    }

    @Override
    public List<ChannelListBasicResponseBody> listChannel(long identifierTimeStamp, List<String> channelIds) throws ServiceException {
        ChannelExample example = new ChannelExample();
        ChannelExample.Criteria criteria = example.createCriteria();
        criteria.andIdIn(channelIds);
        List<ChannelWithBLOBs> channels = channelMapper.selectByExampleWithBLOBs(example);
        List<ChannelListBasicResponseBody> responseBodies = new ArrayList<>();
        channels.forEach(channel -> {
            responseBodies.add(ChannelListBasicResponseBody.builder()
                            .id(channel.getId())
                            .title(channel.getTitle())
                            .price(channel.getPrice())
                            .createdTime(channel.getCreatedTime())
                            .inventory(channel.getInventory())
                            .cover(s3Util.generatePreSignedGetObjectUrl(channel.getCover()))
                            .unSignedCoverKey(channel.getCover())
                            .build());
        });
        return responseBodies;
    }

    @Override
    public List<ChannelListResponseBody> listChannelForCreator(long identifierTimeStamp, String creatorId) throws ServiceException {
        ChannelExample example = new ChannelExample();
        ChannelExample.Criteria criteria = example.createCriteria();
        criteria.andCreatorEqualTo(creatorId);
        example.setOrderByClause("created_time desc");
        List<ChannelWithBLOBs> channels = channelMapper.selectByExampleWithBLOBs(example);
        return convert(channels);
    }

    @Override
    @DistributeCache(scene = "list-channel-by-recommendation", parametersKey = {"userId", "pageNumber", "pageSize"}, duration = 30)
    public PageInfo<ChannelListResponseBody> listChannelByRecommendation(long identifierTimeStamp, String userId, int pageNumber, int pageSize) throws ServiceException {

        // if userid == "", recommend for anonymous user.

        ChannelExample example = new ChannelExample();
        ChannelExample.Criteria criteria = example.createCriteria();
        criteria.andIsDeletedEqualTo(false);
        example.setOrderByClause("created_time desc");
        PageHelper.startPage(pageNumber, pageSize);
        List<ChannelWithBLOBs> channels = channelMapper.selectByExampleWithBLOBs(example);
        PageInfo<ChannelWithBLOBs> pageInfoOfChannelWithBLOBs = new PageInfo<>(channels);
        List<ChannelListResponseBody> responseBodies = convert(channels);
        PageInfo<ChannelListResponseBody> pageInfo = new PageInfo<>(responseBodies);
        pageInfo.setTotal(pageInfoOfChannelWithBLOBs.getTotal());
        pageInfo.setPageSize(pageInfoOfChannelWithBLOBs.getPageSize());
        pageInfo.setPageNum(pageInfoOfChannelWithBLOBs.getPageNum());
        pageInfo.setIsLastPage(pageInfoOfChannelWithBLOBs.isIsLastPage());
        return pageInfo;
    }

    @Override
    public PageInfo<ChannelListResponseBody> listChannelBySearch(long identifierTimeStamp, String search, int pageNumber, int pageSize) throws ServiceException {

        PageHelper.startPage(pageNumber, pageSize);
        List<ChannelWithBLOBs> channels = channelMapper.selectByTitleOrDescription("%" + search + "%");
        PageInfo<ChannelWithBLOBs> pageInfoOfChannelWithBLOBs = new PageInfo<>(channels);
        List<ChannelListResponseBody> responseBodies = convert(channels);
        PageInfo<ChannelListResponseBody> pageInfo = new PageInfo<>(responseBodies);
        pageInfo.setTotal(pageInfoOfChannelWithBLOBs.getTotal());
        pageInfo.setPageSize(pageInfoOfChannelWithBLOBs.getPageSize());
        pageInfo.setPageNum(pageInfoOfChannelWithBLOBs.getPageNum());
        pageInfo.setIsLastPage(pageInfoOfChannelWithBLOBs.isIsLastPage());
        return pageInfo;

    }

    @Override
    public ChannelRetrieveResponseBody retrieveChannel(long identifierTimeStamp, String channelId) throws ServiceException {
        ChannelWithBLOBs channel = fetchChannelById(channelId);
        UserInfoRetrieveResponseBody creator = userService.retrieveUserInfo(channel.getCreator());
        return ChannelRetrieveResponseBody.builder()
                .id(channel.getId())
                .title(channel.getTitle())
                .description(channel.getDescription())
                .price(channel.getPrice())
                .createdTime(channel.getCreatedTime())
                .inventory(channel.getInventory())
                .cover(s3Util.generatePreSignedGetObjectUrl(channel.getCover()))
                .unSignedCoverKey(channel.getCover())
                .creatorAvatar(creator.getAvatar())
                .creatorId(creator.getId())
                .creatorNickname(creator.getNickname())
                .build();
    }

    @Override
    public void occupyInventory(long identifierTimeStamp, String channelId, String userId) throws ServiceException {
        ChannelWithBLOBs channel = fetchChannelById(channelId);
        channel.setInventory(channel.getInventory() - 1);
        channelMapper.updateByPrimaryKeySelective(channel);
    }

    @Override
    public void revokeInventory(long identifierTimeStamp, String channelId, String userId) throws ServiceException {
        ChannelWithBLOBs channel = fetchChannelById(channelId);
        channel.setInventory(channel.getInventory() + 1);
        channelMapper.updateByPrimaryKeySelective(channel);
    }

    private ChannelWithBLOBs fetchChannelById(String channelId) {
        ChannelWithBLOBs channel = channelMapper.selectByPrimaryKey(channelId);
        if(channel == null || channel.getIsDeleted()) {
            throw ServiceException.builder()
                    .message(String.format("Channel [%s] non exist.", channelId))
                    .build();
        }
        return channel;
    }

    private List<ChannelListResponseBody> convert(List<ChannelWithBLOBs> channels) {

        List<String> creatorsId = channels.stream().map(ChannelWithBLOBs::getCreator).collect(Collectors.toSet()).stream().toList();

        Map<String, UserInfoBasicResponseBody> creatorMap = new HashMap<>();
        if(creatorsId.size() == 1) {
            UserInfoRetrieveResponseBody creator = userService.retrieveUserInfo(creatorsId.get(0));
            creatorMap.put(creator.getId(), creator);
        } else if(creatorsId.size() > 1) {
            List<UserInfoListResponseBody> creators = userService.listUserInfo(creatorsId);
            creators.forEach(creator -> {
                creatorMap.put(creator.getId(), creator);
            });
        }

        List<ChannelListResponseBody> responseBodies = new ArrayList<>();
        channels.forEach(channel -> {
            responseBodies.add(ChannelListResponseBody.builder()
                    .id(channel.getId())
                    .title(channel.getTitle())
                    .price(channel.getPrice())
                    .createdTime(channel.getCreatedTime())
                    .inventory(channel.getInventory())
                    .creatorAvatar(creatorMap.containsKey(channel.getCreator()) ? creatorMap.get(channel.getCreator()).getAvatar() : "")
                    .creatorId(creatorMap.containsKey(channel.getCreator()) ? creatorMap.get(channel.getCreator()).getId() : "")
                    .cover(s3Util.generatePreSignedGetObjectUrl(channel.getCover()))
                    .unSignedCoverKey(channel.getCover())
                    .creatorNickname(creatorMap.containsKey(channel.getCreator()) ? creatorMap.get(channel.getCreator()).getNickname() : "")
                    .build());
        });

        return responseBodies;

    }

}
