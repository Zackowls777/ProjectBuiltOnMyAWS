package com.dzm.mapper;

import com.dzm.model.ChannelSection;
import com.dzm.model.ChannelSectionExample;
import com.dzm.model.ChannelSectionWithBLOBs;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface ChannelSectionMapper {
    long countByExample(ChannelSectionExample example);

    int deleteByExample(ChannelSectionExample example);

    int deleteByPrimaryKey(String id);

    int insert(ChannelSectionWithBLOBs record);

    int insertSelective(ChannelSectionWithBLOBs record);

    List<ChannelSectionWithBLOBs> selectByTitleOrDescription(@Param("search") String search);

    List<ChannelSectionWithBLOBs> selectByExampleWithBLOBs(ChannelSectionExample example);

    List<ChannelSection> selectByExample(ChannelSectionExample example);

    ChannelSectionWithBLOBs selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") ChannelSectionWithBLOBs record, @Param("example") ChannelSectionExample example);

    int updateByExampleWithBLOBs(@Param("record") ChannelSectionWithBLOBs record, @Param("example") ChannelSectionExample example);

    int updateByExample(@Param("record") ChannelSection record, @Param("example") ChannelSectionExample example);

    int updateByPrimaryKeySelective(ChannelSectionWithBLOBs record);

    int updateByPrimaryKeyWithBLOBs(ChannelSectionWithBLOBs record);

    int updateByPrimaryKey(ChannelSection record);
}