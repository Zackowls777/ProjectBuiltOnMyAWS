package com.dzm.quant.services.asyn;

import com.dzm.constant.QuantSubmissionResultType;
import com.dzm.mapper.QuantStockDataMapper;
import com.dzm.mapper.QuantSubmissionMapper;
import com.dzm.model.QuantStockData;
import com.dzm.model.QuantSubmission;
import com.dzm.model.QuantSubmissionWithBLOBs;
import com.dzm.quant.services.asyn.request.QuantFetchStackDataRequest;
import com.dzm.quant.services.asyn.request.QuantSubmissionRequest;
import com.dzm.util.json.JSONUtil;
import com.dzm.util.password.PasswordUtil;
import com.dzm.util.quant.QuantUtil;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.kafka.support.Acknowledgment;
import org.springframework.stereotype.Component;

@Component
public class QuantAsynServiceListener {

    private static final Logger log = LoggerFactory.getLogger(QuantAsynServiceListener.class);

    @Autowired
    private QuantUtil quantUtil;

    @Autowired
    private JSONUtil jsonUtil;

    @Autowired
    private QuantStockDataMapper dataMapper;

    @Autowired
    private QuantSubmissionMapper submissionMapper;
    @Autowired
    private PasswordUtil passwordUtil;

    @KafkaListener(id = "quant-fetch-stock-data-listener",
            idIsGroup = false, topics = "quant-fetch-stock-data",
            containerFactory = "kafkaListenerContainerFactory")
    public void fetchStockData(String message, Acknowledgment ack) {

        log.info("received message: " + message);
        ack.acknowledge();

        try {
            QuantFetchStackDataRequest request = jsonUtil.parseJSON(message, QuantFetchStackDataRequest.class);

            JSONObject response = jsonUtil.parseJSON(
                    quantUtil.fetchStockData(request.getSymbol(), request.getStartDay(), request.getEndDay())
            );

            String dataInCsv = response.getString("data");

            log.info(message + "-> response: " + response);

            QuantStockData stockData = dataMapper.selectByPrimaryKey(request.getId());
            stockData.setDataInCsv(dataInCsv);
            dataMapper.updateByPrimaryKey(stockData);

        } catch (Exception e) {

        }



    }

    @KafkaListener(id = "quant-submission-listener",
            idIsGroup = false, topics = "quant-submission",
            containerFactory = "kafkaListenerContainerFactory")
    public void submission(String message, Acknowledgment ack) {

        log.info("received message: " + message);
        ack.acknowledge();

        try {
            QuantSubmissionRequest request = jsonUtil.parseJSON(message, QuantSubmissionRequest.class);

            QuantSubmissionWithBLOBs submission = submissionMapper.selectByPrimaryKey(request.getSubmissionId());

            submission.setResult(QuantSubmissionResultType.RUNNING.getResult());
            submissionMapper.updateByPrimaryKeySelective(submission);

            JSONObject response = jsonUtil.parseJSON(
                    quantUtil.submit(request.getDataCSV(), request.getCode())
            );
            log.info(message + "-> response: " + response);

            JSONObject data = response.getJSONObject("data");
            Integer result = data.getInt("result");
            String output = "";
            if(data.has("output")) {
                output = data.getString("output");
            }
            if(data.has("error") && !data.getString("error").isEmpty()) {
                if(!output.isEmpty()) {
                    output += "\n\n";
                }
                output += "Error: " + data.getString("error");
            }

            submission.setResult(result);
            submission.setOutput(output);
            submissionMapper.updateByPrimaryKeySelective(submission);

        } catch (Exception e) {

        }



    }

}
