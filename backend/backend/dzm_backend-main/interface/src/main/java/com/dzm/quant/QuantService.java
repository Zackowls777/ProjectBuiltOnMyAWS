package com.dzm.quant;

import com.dzm.exception.ServiceException;
import com.dzm.quant.body.response.QuantStockDataFetchResponseBody;
import com.dzm.quant.body.response.QuantSubmissionResponseBody;

public interface QuantService {

    String ping() throws ServiceException;

    QuantStockDataFetchResponseBody fetchStockData(long identifierTimeStamp, String user, String symbol, String startDay, String endDay) throws ServiceException;

    QuantSubmissionResponseBody submit(long identifierTimeStamp, String user, String symbol, String startDay, String endDay, String code) throws ServiceException;

    QuantSubmissionResponseBody fetchSubmissionResult(long identifierTimeStamp, String user, String submissionId) throws ServiceException;

}
