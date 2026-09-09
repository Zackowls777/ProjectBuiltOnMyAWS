package com.dzm.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.util.UUID;

@SuperBuilder
@AllArgsConstructor
@NoArgsConstructor
public class QuantStockData {

    @Builder.Default
    private String id = UUID.randomUUID().toString().replace("-", "");

    private String symbol;

    private String startDay;

    private String endDay;

    @Builder.Default
    private String dataInCsv = "";

    @Builder.Default
    private Long createdTime = System.currentTimeMillis();

    @Builder.Default
    private Long modifiedTime = System.currentTimeMillis();

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getSymbol() {
        return symbol;
    }

    public void setSymbol(String symbol) {
        this.symbol = symbol == null ? null : symbol.trim();
    }

    public String getStartDay() {
        return startDay;
    }

    public void setStartDay(String startDay) {
        this.startDay = startDay == null ? null : startDay.trim();
    }

    public String getEndDay() {
        return endDay;
    }

    public void setEndDay(String endDay) {
        this.endDay = endDay == null ? null : endDay.trim();
    }

    public String getDataInCsv() {
        return dataInCsv;
    }

    public void setDataInCsv(String dataInCsv) {
        this.dataInCsv = dataInCsv == null ? null : dataInCsv.trim();
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