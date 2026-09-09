package com.dzm.util.email;

import com.dzm.exception.ServiceException;
import com.dzm.constant.ServiceResponseStatusType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.MailException;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

@Component
public class EmailUtil {

    @Autowired
    private MailSender mailSender;

    @Value("${spring.mail.username}")
    private String fromEmail;

    @Async
    public void sendEmail(String toEmail, String subject, String content) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(fromEmail);
        message.setTo(toEmail);
        message.setSubject(subject);
        message.setText(content);
        try {
            mailSender.send(message);
        } catch (MailException e) {
            throw ServiceException.builder()
                    .status(ServiceResponseStatusType.SERVER_ERROR.getStatus())
                    .serverErrorMessage("email send failed: " + e.getMessage())
                    .message("failed to send email")
                    .build();
        }
    }

}
