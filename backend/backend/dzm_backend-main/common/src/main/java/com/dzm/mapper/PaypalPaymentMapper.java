package com.dzm.mapper;

import com.dzm.model.PaypalPayment;
import com.dzm.model.PaypalPaymentExample;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface PaypalPaymentMapper {
    long countByExample(PaypalPaymentExample example);

    int deleteByExample(PaypalPaymentExample example);

    int deleteByPrimaryKey(String id);

    int insert(PaypalPayment record);

    int insertSelective(PaypalPayment record);

    List<PaypalPayment> selectByExample(PaypalPaymentExample example);

    PaypalPayment selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") PaypalPayment record, @Param("example") PaypalPaymentExample example);

    int updateByExample(@Param("record") PaypalPayment record, @Param("example") PaypalPaymentExample example);

    int updateByPrimaryKeySelective(PaypalPayment record);

    int updateByPrimaryKey(PaypalPayment record);
}