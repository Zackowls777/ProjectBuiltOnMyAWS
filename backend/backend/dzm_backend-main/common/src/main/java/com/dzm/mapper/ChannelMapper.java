package com.dzm.mapper;

import com.dzm.model.Channel;
import com.dzm.model.ChannelExample;
import com.dzm.model.ChannelWithBLOBs;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface ChannelMapper {
    long countByExample(ChannelExample example);

    int deleteByExample(ChannelExample example);

    int deleteByPrimaryKey(String id);

    int insert(ChannelWithBLOBs record);

    int insertSelective(ChannelWithBLOBs record);

    List<ChannelWithBLOBs> selectByTitleOrDescription(@Param("search") String search);

    List<ChannelWithBLOBs> selectByExampleWithBLOBs(ChannelExample example);

    List<Channel> selectByExample(ChannelExample example);

    ChannelWithBLOBs selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") ChannelWithBLOBs record, @Param("example") ChannelExample example);

    int updateByExampleWithBLOBs(@Param("record") ChannelWithBLOBs record, @Param("example") ChannelExample example);

    int updateByExample(@Param("record") Channel record, @Param("example") ChannelExample example);

    int updateByPrimaryKeySelective(ChannelWithBLOBs record);

    int updateByPrimaryKeyWithBLOBs(ChannelWithBLOBs record);

    int updateByPrimaryKey(Channel record);
}