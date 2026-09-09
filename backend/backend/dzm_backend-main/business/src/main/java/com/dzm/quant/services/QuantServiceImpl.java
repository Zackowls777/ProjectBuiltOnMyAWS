package com.dzm.quant.services;

import com.dzm.aspect.limiter.DistributeRateLimiter;
import com.dzm.aspect.lock.DistributeLock;
import com.dzm.constant.QuantSubmissionResultType;
import com.dzm.constant.ServiceResponseStatusType;
import com.dzm.exception.ServiceException;
import com.dzm.mapper.QuantStockDataMapper;
import com.dzm.mapper.QuantSubmissionMapper;
import com.dzm.model.QuantStockData;
import com.dzm.model.QuantStockDataExample;
import com.dzm.model.QuantSubmissionExample;
import com.dzm.model.QuantSubmissionWithBLOBs;
import com.dzm.quant.QuantService;
import com.dzm.quant.body.response.QuantStockDataFetchResponseBody;
import com.dzm.quant.body.response.QuantSubmissionResponseBody;
import com.dzm.quant.services.asyn.request.QuantFetchStackDataRequest;
import com.dzm.quant.services.asyn.request.QuantSubmissionRequest;
import com.dzm.util.json.JSONUtil;
import com.dzm.util.kafka.util.KafkaUtil;
import com.dzm.util.s3.util.S3Util;
import org.apache.dubbo.config.annotation.DubboService;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

@DubboService(version = "1.0.0")
public class QuantServiceImpl implements QuantService {

    @Autowired
    private QuantSubmissionMapper submissionMapper;

    @Autowired
    private QuantStockDataMapper dataMapper;

    @Autowired
    private KafkaUtil kafkaUtil;

    @Autowired
    private JSONUtil jsonUtil;

    @Autowired
    private S3Util s3Util;

    @Override
    public String ping() throws ServiceException {
        return "quant service pong";
    }

    @Override
    @DistributeLock(scene = "quant-fetch-stock-data", parametersKey = {"symbol", "startDay", "endDay"})
    public QuantStockDataFetchResponseBody fetchStockData(long identifierTimeStamp, String user, String symbol, String startDay, String endDay) throws ServiceException {
        QuantStockDataExample example = new QuantStockDataExample();
        QuantStockDataExample.Criteria criteria = example.createCriteria();
        criteria.andSymbolEqualTo(symbol).andStartDayEqualTo(startDay).andEndDayEqualTo(endDay);
        List<QuantStockData> dataList = dataMapper.selectByExample(example);

        boolean load = true;
        for(QuantStockData data : dataList) {
            if(!data.getDataInCsv().isEmpty()) {
                return QuantStockDataFetchResponseBody.builder()
                        .dataCsv(s3Util.generatePreSignedGetObjectUrl(data.getDataInCsv())).loading(false)
                        .build();
            } else if(data.getCreatedTime() > identifierTimeStamp - 60000) {
                load = false;
            }
        }

        if(load) {

            QuantStockData data = QuantStockData.builder()
                    .symbol(symbol).startDay(startDay).endDay(endDay).createdTime(identifierTimeStamp)
                    .build();
            dataMapper.insert(data);
            kafkaUtil.send("quant-fetch-stock-data", jsonUtil.toJSON(
                    QuantFetchStackDataRequest.builder()
                            .id(data.getId()).symbol(symbol).startDay(startDay).endDay(endDay)
                            .build()
            ));
        }
        return QuantStockDataFetchResponseBody.builder().build();
    }

    @Override
    public QuantSubmissionResponseBody submit(long identifierTimeStamp, String user, String symbol, String startDay, String endDay, String code) throws ServiceException {
        QuantStockData data = null;
        try {
            QuantStockDataExample example = new QuantStockDataExample();
            QuantStockDataExample.Criteria criteria = example.createCriteria();
            criteria.andSymbolEqualTo(symbol).andStartDayEqualTo(startDay).andEndDayEqualTo(endDay);
            data = dataMapper.selectByExample(example).get(0);
        } catch (Exception e) {
            throw ServiceException.builder().message(String.format("no data for %s: %s -> %s", symbol, startDay, endDay)).build();
        }
        QuantSubmissionExample example = new QuantSubmissionExample();
        QuantSubmissionExample.Criteria criteria = example.createCriteria();
        criteria.andUserEqualTo(user).andSymbolEqualTo(symbol)
                .andStartDayEqualTo(startDay).andEndDayEqualTo(endDay)
                .andCreatedTimeEqualTo(identifierTimeStamp);

        QuantSubmissionWithBLOBs submission = QuantSubmissionWithBLOBs.builder()
                .symbol(symbol).startDay(startDay).endDay(endDay)
                .user(user).code(code)
                .result(QuantSubmissionResultType.PENDING.getResult())
                .createdTime(identifierTimeStamp)
                .build();
        if(submissionMapper.countByExample(example) == 0) {
            submissionMapper.insert(submission);
            kafkaUtil.send("quant-submission", jsonUtil.toJSON(
                    QuantSubmissionRequest.builder()
                            .submissionId(submission.getId())
                            .code(code).dataCSV(data.getDataInCsv())
                            .build()
            ));
        } else {
            submission = submissionMapper.selectByExampleWithBLOBs(example).get(0);
        }
        return QuantSubmissionResponseBody.builder()
                .submissionId(submission.getId())
                .result(submission.getResult())
                .output(submission.getOutput())
                .build();
    }

    @Override
    public QuantSubmissionResponseBody fetchSubmissionResult(long identifierTimeStamp, String user, String submissionId) throws ServiceException {
        QuantSubmissionWithBLOBs submission = submissionMapper.selectByPrimaryKey(submissionId);
        if(submission == null) {
            throw ServiceException.builder().message(String.format("no submission found for %s", submissionId)).build();
        }
        if(!submission.getUser().equals(user)) {
            throw ServiceException.builder()
                    .status(ServiceResponseStatusType.PERMISSION_DENIED.getStatus())
                    .message(String.format("you don't hava the submission for %s", submissionId))
                    .build();
        }
        return QuantSubmissionResponseBody.builder()
                .submissionId(submission.getId())
                .result(submission.getResult())
                .output(submission.getOutput())
                .build();
    }
}
