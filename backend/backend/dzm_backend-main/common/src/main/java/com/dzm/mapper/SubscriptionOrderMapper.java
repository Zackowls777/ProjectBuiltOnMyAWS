package com.dzm.mapper;

import com.dzm.model.SubscriptionOrder;
import com.dzm.model.SubscriptionOrderExample;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface SubscriptionOrderMapper {
    long countByExample(SubscriptionOrderExample example);

    int deleteByExample(SubscriptionOrderExample example);

    int deleteByPrimaryKey(String id);

    int insert(SubscriptionOrder record);

    int insertSelective(SubscriptionOrder record);

    List<SubscriptionOrder> selectByExample(SubscriptionOrderExample example);

    SubscriptionOrder selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") SubscriptionOrder record, @Param("example") SubscriptionOrderExample example);

    int updateByExample(@Param("record") SubscriptionOrder record, @Param("example") SubscriptionOrderExample example);

    int updateByPrimaryKeySelective(SubscriptionOrder record);

    int updateByPrimaryKey(SubscriptionOrder record);
}