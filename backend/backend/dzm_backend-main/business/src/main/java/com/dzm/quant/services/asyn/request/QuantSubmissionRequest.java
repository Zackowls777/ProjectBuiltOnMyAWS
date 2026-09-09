package com.dzm.quant.services.asyn.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class QuantSubmissionRequest {

    private String submissionId;

    private String code;

    private String dataCSV;

}
