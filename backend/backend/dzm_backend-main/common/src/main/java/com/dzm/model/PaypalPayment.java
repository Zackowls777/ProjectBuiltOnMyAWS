package com.dzm.model;

import com.dzm.constant.PaymentStatusType;
import com.dzm.exception.ServiceException;
import lombok.Builder;

import java.io.Serializable;
import java.util.UUID;


@Builder
public class PaypalPayment implements Serializable {

    @Builder.Default
    private String id = UUID.randomUUID().toString().replace("-", "");

    private String subscriptionOrder;

    private String token;

    private String approvalUrl;

    @Builder.Default
    private String payer = "";

    @Builder.Default
    private Integer status = PaymentStatusType.UNPAID.getStatus();

    @Builder.Default
    private Boolean isDeleted = false;

    @Builder.Default
    private Long createdTime = System.currentTimeMillis();

    @Builder.Default
    private Long modifiedTime = System.currentTimeMillis();

    public void checkStatus(int expectedStatus) throws ServiceException {
        if(!this.getStatus().equals(expectedStatus) && this.getStatus().equals(PaymentStatusType.UNPAID.getStatus())) {
            throw ServiceException.builder()
                    .serverErrorMessage(String.format("Payment id: %s has not been paid.", this.getId()))
                    .message("This payment has not been paid.").build();
        }
        if(!this.getStatus().equals(expectedStatus) && this.getStatus().equals(PaymentStatusType.CANCELED.getStatus())) {
            throw ServiceException.builder()
                    .serverErrorMessage(String.format("Payment id: %s has been canceled.", this.getId()))
                    .message("This payment has been canceled.").build();
        }
        if(!this.getStatus().equals(expectedStatus) && this.getStatus().equals(PaymentStatusType.EXPIRED.getStatus())) {
            throw ServiceException.builder()
                    .serverErrorMessage(String.format("Payment id: %s has expired..", this.getId()))
                    .message("This payment has expired.").build();
        }
        if(!this.getStatus().equals(expectedStatus) && this.getStatus().equals(PaymentStatusType.PAID.getStatus())) {
            throw ServiceException.builder()
                    .serverErrorMessage(String.format("Payment id: %s has been paid.", this.getId()))
                    .message("This payment has been paid.").build();
        }
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getSubscriptionOrder() {
        return subscriptionOrder;
    }

    public void setSubscriptionOrder(String subscriptionOrder) {
        this.subscriptionOrder = subscriptionOrder == null ? null : subscriptionOrder.trim();
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token == null ? null : token.trim();
    }

    public String getApprovalUrl() {
        return approvalUrl;
    }

    public void setApprovalUrl(String approvalUrl) {
        this.approvalUrl = approvalUrl == null ? null : approvalUrl.trim();
    }

    public String getPayer() {
        return payer;
    }

    public void setPayer(String payer) {
        this.payer = payer == null ? null : payer.trim();
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Boolean getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(Boolean isDeleted) {
        this.isDeleted = isDeleted;
    }

    public Long getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(Long createdTime) {
        this.createdTime = createdTime;
    }

    public Long getModifiedTime() {
        return modifiedTime;
    }

    public void setModifiedTime(Long modifiedTime) {
        this.modifiedTime = modifiedTime;
    }
}