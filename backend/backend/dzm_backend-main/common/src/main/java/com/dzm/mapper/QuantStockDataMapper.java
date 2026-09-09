package com.dzm.mapper;

import com.dzm.model.QuantStockData;
import com.dzm.model.QuantStockDataExample;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface QuantStockDataMapper {
    long countByExample(QuantStockDataExample example);

    int deleteByExample(QuantStockDataExample example);

    int deleteByPrimaryKey(String id);

    int insert(QuantStockData record);

    int insertSelective(QuantStockData record);

    List<QuantStockData> selectByExample(QuantStockDataExample example);

    QuantStockData selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") QuantStockData record, @Param("example") QuantStockDataExample example);

    int updateByExample(@Param("record") QuantStockData record, @Param("example") QuantStockDataExample example);

    int updateByPrimaryKeySelective(QuantStockData record);

    int updateByPrimaryKey(QuantStockData record);
}