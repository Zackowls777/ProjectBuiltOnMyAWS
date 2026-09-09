package com.dzm.channel.section.services;

import com.dzm.aspect.cache.DistributeCache;
import com.dzm.channel.section.ChannelSectionService;
import com.dzm.channel.section.body.response.ChannelSectionListResponseBody;
import com.dzm.channel.section.body.response.ChannelSectionRetrieveResponseBody;
import com.dzm.exception.ServiceException;
import com.dzm.mapper.ChannelMapper;
import com.dzm.mapper.ChannelSectionMapper;
import com.dzm.model.*;
import com.dzm.order.OrderService;
import com.dzm.user.UserService;
import com.dzm.user.body.response.UserInfoListResponseBody;
import com.dzm.user.body.response.UserInfoRetrieveResponseBody;
import com.dzm.util.s3.util.S3Util;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.dubbo.config.annotation.DubboReference;
import org.apache.dubbo.config.annotation.DubboService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@DubboService(version = "1.0.0")
public class ChannelSectionServiceImpl implements ChannelSectionService {

    @Autowired
    private ChannelSectionMapper channelSectionMapper;

    @Autowired
    private ChannelMapper channelMapper;

    @Autowired
    private S3Util s3Util;

    @DubboReference(version = "1.0.0", check = false, loadbalance = "roundrobin")
    private OrderService orderService;

    @DubboReference(version = "1.0.0", check = false, loadbalance = "roundrobin")
    private UserService userService;

    @Override
    public String ping() throws ServiceException {
        return "channel section service pong";
    }

    @Override
    public void createChannelSection(long identifierTimeStamp, String userId, String channelId, String title, String description, String cover, String video, int duration) throws ServiceException {
        ChannelSectionExample example = new ChannelSectionExample();
        ChannelSectionExample.Criteria criteria = example.createCriteria();
        criteria.andChannelEqualTo(channelId).andCreatedTimeEqualTo(identifierTimeStamp);
        if(channelSectionMapper.countByExample(example) > 0){
            return ;
        }
        Channel channel = channelMapper.selectByPrimaryKey(channelId);
        if(channel == null || channel.getIsDeleted() || !channel.getCreator().equals(userId)){
            throw ServiceException.builder()
                    .message(String.format("Channel with id [%s] not found or permission denied.", channelId))
                    .build();
        }
        ChannelSectionWithBLOBs section = ChannelSectionWithBLOBs.builder()
                .channel(channelId)
                .title(title)
                .description(description)
                .cover(cover)
                .video(video)
                .duration(duration)
                .build();
        channelSectionMapper.insert(section);
    }

    @Override
    public void deleteChannelSection(long identifierTimeStamp, String userId, String channelSectionId) throws ServiceException {
        ChannelSection channelSection = channelSectionMapper.selectByPrimaryKey(channelSectionId);
        if(channelSection == null){
            throw ServiceException.builder()
                    .message(String.format("Channel section with id [%s] not found.", channelSectionId))
                    .build();
        }
        if(channelSection.getIsDeleted()){
            if(channelSection.getModifiedTime() == identifierTimeStamp) {
                return;
            }
            throw ServiceException.builder()
                    .message(String.format("Channel section with id [%s] has been deleted.", channelSectionId))
                    .build();
        }
        Channel channel = channelMapper.selectByPrimaryKey(channelSection.getChannel());
        if(channel == null || channel.getIsDeleted() || !channel.getCreator().equals(userId)){
            throw ServiceException.builder()
                    .message(String.format("Channel with id [%s] not found or permission denied.", channelSection.getChannel()))
                    .build();
        }
        channelSection.setIsDeleted(true);
        channelSection.setModifiedTime(identifierTimeStamp);
        channelSectionMapper.updateByPrimaryKey(channelSection);
    }

    @Override
    public void updateChannelSection(long identifierTimeStamp, String userId, String channelSectionId, String title, String description, String cover, String video, int duration) throws ServiceException {
        System.out.println(description);
        ChannelSectionWithBLOBs channelSection = channelSectionMapper.selectByPrimaryKey(channelSectionId);
        if(channelSection == null || channelSection.getIsDeleted()){
            throw ServiceException.builder()
                    .message(String.format("Channel section with id [%s] not found.", channelSectionId))
                    .build();
        }
        if(channelSection.getModifiedTime() == identifierTimeStamp){
            return;
        }
        Channel channel = channelMapper.selectByPrimaryKey(channelSection.getChannel());
        if(channel == null || channel.getIsDeleted() || !channel.getCreator().equals(userId)){
            throw ServiceException.builder()
                    .message(String.format("Channel with id [%s] not found or permission denied.", channelSection.getChannel()))
                    .build();
        }
        channelSection.setTitle(title);
        channelSection.setDescription(description);
        channelSection.setCover(cover);
        channelSection.setVideo(video);
        channelSection.setDuration(duration);
        channelSection.setModifiedTime(identifierTimeStamp);
        channelSectionMapper.updateByPrimaryKeyWithBLOBs(channelSection);
    }

    @Override
    public ChannelSectionRetrieveResponseBody retrieveChannelSection(long identifierTimeStamp, String userId, String channelSectionId) throws ServiceException {
        ChannelSectionWithBLOBs channelSection = channelSectionMapper.selectByPrimaryKey(channelSectionId);
        if(channelSection == null || channelSection.getIsDeleted()){
            throw ServiceException.builder()
                    .message(String.format("Channel section with id [%s] not found.", channelSectionId))
                    .build();
        }
        ChannelWithBLOBs channel = channelMapper.selectByPrimaryKey(channelSection.getChannel());
        if(channel == null || channel.getIsDeleted()){
            throw ServiceException.builder()
                    .message(String.format("Channel with id [%s] not found or permission denied.", channelSection.getChannel()))
                    .build();
        }
        boolean access = !userId.isEmpty() &&
                (channel.getCreator().equals(userId) ||
                    orderService.checkChannelAccessByPaidOrder(identifierTimeStamp, userId, channel.getId()).isAccess());

        UserInfoRetrieveResponseBody creator = userService.retrieveUserInfo(channel.getCreator());

        return ChannelSectionRetrieveResponseBody.builder()
                .id(channelSection.getId())
                .channelId(channelSection.getChannel())
                .channelCreatorId(creator.getId())
                .channelCreatorAvatar(creator.getAvatar())
                .channelCreatorNickname(creator.getNickname())
                .channelTitle(channel.getTitle())
                .channelCover(s3Util.generatePreSignedGetObjectUrl(channel.getCover()))
                .title(channelSection.getTitle())
                .description(channelSection.getDescription())
                .cover(s3Util.generatePreSignedGetObjectUrl(channelSection.getCover()))
                .unSignedCoverKey(channelSection.getCover())
                .access(access)
                .video(access ? s3Util.generatePreSignedGetObjectUrl(channelSection.getVideo()) : "")
                .unSignedVideoKey(channelSection.getVideo())
                .duration(channelSection.getDuration())
                .createdTime(channelSection.getCreatedTime())
                .build();
    }

    @Override
    public PageInfo<ChannelSectionListResponseBody> listSectionsForChannel(long identifierTimeStamp, String userId, String channelId, int pageNumber, int pageSize) throws ServiceException {

        ChannelWithBLOBs channel = channelMapper.selectByPrimaryKey(channelId);
        if(channel == null || channel.getIsDeleted()){
            throw ServiceException.builder()
                    .message(String.format("Channel with id [%s] not found.", channelId))
                    .build();
        }

        ChannelSectionExample example = new ChannelSectionExample();
        ChannelSectionExample.Criteria criteria = example.createCriteria();
        criteria.andChannelEqualTo(channelId);
        example.setOrderByClause("created_time desc");
        PageHelper.startPage(pageNumber, pageSize);
        List<ChannelSectionWithBLOBs> channelSections = channelSectionMapper.selectByExampleWithBLOBs(example);
        PageInfo<ChannelSectionWithBLOBs> channelSectionsPageInfo = new PageInfo<>(channelSections);

        UserInfoRetrieveResponseBody creator = userService.retrieveUserInfo(channel.getCreator());

        List<ChannelSectionListResponseBody> responseBodies = new ArrayList<>();
        channelSections.forEach(channelSection -> {
            responseBodies.add(
                    ChannelSectionListResponseBody.builder()
                            .id(channelSection.getId())
                            .channelId(channelSection.getChannel())
                            .channelCreatorId(creator.getId())
                            .channelCreatorNickname(creator.getNickname())
                            .channelCreatorAvatar(creator.getAvatar())
                            .title(channelSection.getTitle())
                            .cover(s3Util.generatePreSignedGetObjectUrl(channelSection.getCover()))
                            .unSignedCoverKey(channelSection.getCover())
                            .duration(channelSection.getDuration())
                            .createdTime(channelSection.getCreatedTime())
                            .build()
            );
        });
        PageInfo<ChannelSectionListResponseBody> pageInfo = new PageInfo<>(responseBodies);
        pageInfo.setTotal(channelSectionsPageInfo.getTotal());
        pageInfo.setPageSize(channelSectionsPageInfo.getPageSize());
        pageInfo.setPageNum(channelSectionsPageInfo.getPageNum());
        pageInfo.setIsLastPage(channelSectionsPageInfo.isIsLastPage());
        return pageInfo;
    }

    @Override
    @DistributeCache(scene = "list-channel-section-by-recommendation", parametersKey = {"userId", "pageNumber", "pageSize"}, duration = 30)
    public PageInfo<ChannelSectionListResponseBody> listChannelSectionsByRecommendation(long identifierTimeStamp, String userId, int pageNumber, int pageSize) throws ServiceException {
        // if userid == "", recommend for anonymous user.

        ChannelSectionExample sectionExample = new ChannelSectionExample();
        ChannelSectionExample.Criteria sectionExampleCriteria = sectionExample.createCriteria();
        sectionExampleCriteria.andIsDeletedEqualTo(false);
        sectionExample.setOrderByClause("created_time desc");
        PageHelper.startPage(pageNumber, pageSize);
        List<ChannelSectionWithBLOBs> channelSections = channelSectionMapper.selectByExampleWithBLOBs(sectionExample);
        PageInfo<ChannelSectionWithBLOBs> channelSectionsPageInfo = new PageInfo<>(channelSections);

        List<ChannelSectionListResponseBody> responseBodies = new ArrayList<>();
        if(channelSectionsPageInfo.getTotal() == 0) {
            PageInfo<ChannelSectionListResponseBody> pageInfo = new PageInfo<>(responseBodies);
            pageInfo.setTotal(channelSectionsPageInfo.getTotal());
            pageInfo.setPageSize(channelSectionsPageInfo.getPageSize());
            pageInfo.setPageNum(channelSectionsPageInfo.getPageNum());
            pageInfo.setIsLastPage(channelSectionsPageInfo.isIsLastPage());
            return pageInfo;
        }

        List<String> channelsId = channelSections.stream().map(ChannelSectionWithBLOBs::getChannel).collect(Collectors.toSet()).stream().toList();

        ChannelExample channelExample = new ChannelExample();
        ChannelExample.Criteria channelExampleCriteria = channelExample.createCriteria();
        channelExampleCriteria.andIdIn(channelsId);
        List<Channel> channels = channelMapper.selectByExample(channelExample);

        Map<String, Channel> channelMap = channels.stream().collect(Collectors.toMap(Channel::getId, channel -> channel));

        List<String> creatorsId = channels.stream().map(Channel::getCreator).collect(Collectors.toSet()).stream().toList();

        List<UserInfoListResponseBody> creators = userService.listUserInfo(creatorsId);

        Map<String, UserInfoListResponseBody> userInfoMap = creators.stream().collect(Collectors.toMap(UserInfoListResponseBody::getId, user -> user));

        channelSections.forEach(channelSection -> {
            Channel channel = channelMap.getOrDefault(channelSection.getChannel(), null);
            UserInfoListResponseBody creator = null;
            if(channel != null) {
                creator = userInfoMap.getOrDefault(channel.getCreator(), null);
            }
            responseBodies.add(
                    ChannelSectionListResponseBody.builder()
                            .id(channelSection.getId())
                            .channelId(channelSection.getChannel())
                            .channelCreatorId(creator == null ? "": creator.getId())
                            .channelCreatorNickname(creator == null ? "": creator.getNickname())
                            .channelCreatorAvatar(creator == null ? "": creator.getAvatar())
                            .title(channelSection.getTitle())
                            .cover(s3Util.generatePreSignedGetObjectUrl(channelSection.getCover()))
                            .unSignedCoverKey(channelSection.getCover())
                            .duration(channelSection.getDuration())
                            .createdTime(channelSection.getCreatedTime())
                            .build()
            );
        });
        PageInfo<ChannelSectionListResponseBody> pageInfo = new PageInfo<>(responseBodies);
        pageInfo.setTotal(channelSectionsPageInfo.getTotal());
        pageInfo.setPageSize(channelSectionsPageInfo.getPageSize());
        pageInfo.setPageNum(channelSectionsPageInfo.getPageNum());
        pageInfo.setIsLastPage(channelSectionsPageInfo.isIsLastPage());
        return pageInfo;

    }

    @Override
    public PageInfo<ChannelSectionListResponseBody> listChannelSectionsBySearch(long identifierTimeStamp, String search, int pageNumber, int pageSize) throws ServiceException {

        PageHelper.startPage(pageNumber, pageSize);
        List<ChannelSectionWithBLOBs> channelSections = channelSectionMapper.selectByTitleOrDescription("%" + search + "%");
        PageInfo<ChannelSectionWithBLOBs> channelSectionsPageInfo = new PageInfo<>(channelSections);

        List<ChannelSectionListResponseBody> responseBodies = new ArrayList<>();
        if(channelSectionsPageInfo.getTotal() == 0) {
            PageInfo<ChannelSectionListResponseBody> pageInfo = new PageInfo<>(responseBodies);
            pageInfo.setTotal(channelSectionsPageInfo.getTotal());
            pageInfo.setPageSize(channelSectionsPageInfo.getPageSize());
            pageInfo.setPageNum(channelSectionsPageInfo.getPageNum());
            pageInfo.setIsLastPage(channelSectionsPageInfo.isIsLastPage());
            return pageInfo;
        }

        List<String> channelsId = channelSections.stream().map(ChannelSectionWithBLOBs::getChannel).collect(Collectors.toSet()).stream().toList();

        ChannelExample channelExample = new ChannelExample();
        ChannelExample.Criteria channelExampleCriteria = channelExample.createCriteria();
        channelExampleCriteria.andIdIn(channelsId);
        List<Channel> channels = channelMapper.selectByExample(channelExample);

        Map<String, Channel> channelMap = channels.stream().collect(Collectors.toMap(Channel::getId, channel -> channel));

        List<String> creatorsId = channels.stream().map(Channel::getCreator).collect(Collectors.toSet()).stream().toList();

        List<UserInfoListResponseBody> creators = userService.listUserInfo(creatorsId);

        Map<String, UserInfoListResponseBody> userInfoMap = creators.stream().collect(Collectors.toMap(UserInfoListResponseBody::getId, user -> user));

        channelSections.forEach(channelSection -> {
            Channel channel = channelMap.getOrDefault(channelSection.getChannel(), null);
            UserInfoListResponseBody creator = null;
            if(channel != null) {
                creator = userInfoMap.getOrDefault(channel.getCreator(), null);
            }
            responseBodies.add(
                    ChannelSectionListResponseBody.builder()
                            .id(channelSection.getId())
                            .channelId(channelSection.getChannel())
                            .channelCreatorId(creator == null ? "": creator.getId())
                            .channelCreatorNickname(creator == null ? "": creator.getNickname())
                            .channelCreatorAvatar(creator == null ? "": creator.getAvatar())
                            .title(channelSection.getTitle())
                            .cover(s3Util.generatePreSignedGetObjectUrl(channelSection.getCover()))
                            .unSignedCoverKey(channelSection.getCover())
                            .duration(channelSection.getDuration())
                            .createdTime(channelSection.getCreatedTime())
                            .build()
            );
        });
        PageInfo<ChannelSectionListResponseBody> pageInfo = new PageInfo<>(responseBodies);
        pageInfo.setTotal(channelSectionsPageInfo.getTotal());
        pageInfo.setPageSize(channelSectionsPageInfo.getPageSize());
        pageInfo.setPageNum(channelSectionsPageInfo.getPageNum());
        pageInfo.setIsLastPage(channelSectionsPageInfo.isIsLastPage());
        return pageInfo;
    }
}
