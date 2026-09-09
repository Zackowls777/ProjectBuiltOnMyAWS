package com.dzm.model;

import com.dzm.constant.OrderStatusType;
import com.dzm.exception.ServiceException;
import com.mysql.cj.x.protobuf.MysqlxCrud;
import lombok.Builder;
import lombok.Data;

import java.io.Serializable;
import java.util.UUID;

@Builder
public class SubscriptionOrder implements Serializable {

    @Builder.Default
    private String id = UUID.randomUUID().toString().replace("-", "");

    private String user;

    private String channel;

    private Integer paymentPrice;

    @Builder.Default
    private Integer status = OrderStatusType.UNPAID.getStatus();

    @Builder.Default
    private Boolean isDeleted = false;

    @Builder.Default
    private Long createdTime = System.currentTimeMillis();

    @Builder.Default
    private Long modifiedTime = System.currentTimeMillis();

    public void checkStatus(int expectedStatus) throws ServiceException {
        if(status == expectedStatus) {
            return;
        }
        if(status == OrderStatusType.UNPAID.getStatus()) {
            throw ServiceException.builder().message(String.format("order [%s] has not been paid", id)).build();
        }
        if(status == OrderStatusType.PAID.getStatus()) {
            throw ServiceException.builder().message(String.format("order [%s] has been paid", id)).build();
        }
        if(status == OrderStatusType.CANCELED.getStatus()) {
            throw ServiceException.builder().message(String.format("order [%s] has been canceled", id)).build();
        }
        if(status == OrderStatusType.EXPIRED.getStatus()) {
            throw ServiceException.builder().message(String.format("order [%s] has been expired", id)).build();
        }
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user == null ? null : user.trim();
    }

    public String getChannel() {
        return channel;
    }

    public void setChannel(String channel) {
        this.channel = channel == null ? null : channel.trim();
    }

    public Integer getPaymentPrice() {
        return paymentPrice;
    }

    public void setPaymentPrice(Integer paymentPrice) {
        this.paymentPrice = paymentPrice;
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