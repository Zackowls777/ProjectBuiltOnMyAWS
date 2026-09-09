package com.dzm.mapper;

import com.dzm.model.QuantSubmission;
import com.dzm.model.QuantSubmissionExample;
import com.dzm.model.QuantSubmissionWithBLOBs;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface QuantSubmissionMapper {
    long countByExample(QuantSubmissionExample example);

    int deleteByExample(QuantSubmissionExample example);

    int deleteByPrimaryKey(String id);

    int insert(QuantSubmissionWithBLOBs record);

    int insertSelective(QuantSubmissionWithBLOBs record);

    List<QuantSubmissionWithBLOBs> selectByExampleWithBLOBs(QuantSubmissionExample example);

    List<QuantSubmission> selectByExample(QuantSubmissionExample example);

    QuantSubmissionWithBLOBs selectByPrimaryKey(String id);

    int updateByExampleSelective(@Param("record") QuantSubmissionWithBLOBs record, @Param("example") QuantSubmissionExample example);

    int updateByExampleWithBLOBs(@Param("record") QuantSubmissionWithBLOBs record, @Param("example") QuantSubmissionExample example);

    int updateByExample(@Param("record") QuantSubmission record, @Param("example") QuantSubmissionExample example);

    int updateByPrimaryKeySelective(QuantSubmissionWithBLOBs record);

    int updateByPrimaryKeyWithBLOBs(QuantSubmissionWithBLOBs record);

    int updateByPrimaryKey(QuantSubmission record);
}