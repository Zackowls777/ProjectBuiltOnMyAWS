package com.dzm.services.asyn.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class EmailSentRequest {

    public String toEmail;

    public String subject;

    public String content;

}
