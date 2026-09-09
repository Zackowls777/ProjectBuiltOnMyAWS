package com.dzm.model;

import java.util.ArrayList;
import java.util.List;

public class QuantStockDataExample {
    protected String orderByClause;

    protected boolean distinct;

    protected List<Criteria> oredCriteria;

    public QuantStockDataExample() {
        oredCriteria = new ArrayList<>();
    }

    public void setOrderByClause(String orderByClause) {
        this.orderByClause = orderByClause;
    }

    public String getOrderByClause() {
        return orderByClause;
    }

    public void setDistinct(boolean distinct) {
        this.distinct = distinct;
    }

    public boolean isDistinct() {
        return distinct;
    }

    public List<Criteria> getOredCriteria() {
        return oredCriteria;
    }

    public void or(Criteria criteria) {
        oredCriteria.add(criteria);
    }

    public Criteria or() {
        Criteria criteria = createCriteriaInternal();
        oredCriteria.add(criteria);
        return criteria;
    }

    public Criteria createCriteria() {
        Criteria criteria = createCriteriaInternal();
        if (oredCriteria.size() == 0) {
            oredCriteria.add(criteria);
        }
        return criteria;
    }

    protected Criteria createCriteriaInternal() {
        Criteria criteria = new Criteria();
        return criteria;
    }

    public void clear() {
        oredCriteria.clear();
        orderByClause = null;
        distinct = false;
    }

    protected abstract static class GeneratedCriteria {
        protected List<Criterion> criteria;

        protected GeneratedCriteria() {
            super();
            criteria = new ArrayList<>();
        }

        public boolean isValid() {
            return criteria.size() > 0;
        }

        public List<Criterion> getAllCriteria() {
            return criteria;
        }

        public List<Criterion> getCriteria() {
            return criteria;
        }

        protected void addCriterion(String condition) {
            if (condition == null) {
                throw new RuntimeException("Value for condition cannot be null");
            }
            criteria.add(new Criterion(condition));
        }

        protected void addCriterion(String condition, Object value, String property) {
            if (value == null) {
                throw new RuntimeException("Value for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value));
        }

        protected void addCriterion(String condition, Object value1, Object value2, String property) {
            if (value1 == null || value2 == null) {
                throw new RuntimeException("Between values for " + property + " cannot be null");
            }
            criteria.add(new Criterion(condition, value1, value2));
        }

        public Criteria andIdIsNull() {
            addCriterion("id is null");
            return (Criteria) this;
        }

        public Criteria andIdIsNotNull() {
            addCriterion("id is not null");
            return (Criteria) this;
        }

        public Criteria andIdEqualTo(String value) {
            addCriterion("id =", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotEqualTo(String value) {
            addCriterion("id <>", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdGreaterThan(String value) {
            addCriterion("id >", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdGreaterThanOrEqualTo(String value) {
            addCriterion("id >=", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdLessThan(String value) {
            addCriterion("id <", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdLessThanOrEqualTo(String value) {
            addCriterion("id <=", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdLike(String value) {
            addCriterion("id like", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotLike(String value) {
            addCriterion("id not like", value, "id");
            return (Criteria) this;
        }

        public Criteria andIdIn(List<String> values) {
            addCriterion("id in", values, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotIn(List<String> values) {
            addCriterion("id not in", values, "id");
            return (Criteria) this;
        }

        public Criteria andIdBetween(String value1, String value2) {
            addCriterion("id between", value1, value2, "id");
            return (Criteria) this;
        }

        public Criteria andIdNotBetween(String value1, String value2) {
            addCriterion("id not between", value1, value2, "id");
            return (Criteria) this;
        }

        public Criteria andSymbolIsNull() {
            addCriterion("symbol is null");
            return (Criteria) this;
        }

        public Criteria andSymbolIsNotNull() {
            addCriterion("symbol is not null");
            return (Criteria) this;
        }

        public Criteria andSymbolEqualTo(String value) {
            addCriterion("symbol =", value, "symbol");
            return (Criteria) this;
        }

        public Criteria andSymbolNotEqualTo(String value) {
            addCriterion("symbol <>", value, "symbol");
            return (Criteria) this;
        }

        public Criteria andSymbolGreaterThan(String value) {
            addCriterion("symbol >", value, "symbol");
            return (Criteria) this;
        }

        public Criteria andSymbolGreaterThanOrEqualTo(String value) {
            addCriterion("symbol >=", value, "symbol");
            return (Criteria) this;
        }

        public Criteria andSymbolLessThan(String value) {
            addCriterion("symbol <", value, "symbol");
            return (Criteria) this;
        }

        public Criteria andSymbolLessThanOrEqualTo(String value) {
            addCriterion("symbol <=", value, "symbol");
            return (Criteria) this;
        }

        public Criteria andSymbolLike(String value) {
            addCriterion("symbol like", value, "symbol");
            return (Criteria) this;
        }

        public Criteria andSymbolNotLike(String value) {
            addCriterion("symbol not like", value, "symbol");
            return (Criteria) this;
        }

        public Criteria andSymbolIn(List<String> values) {
            addCriterion("symbol in", values, "symbol");
            return (Criteria) this;
        }

        public Criteria andSymbolNotIn(List<String> values) {
            addCriterion("symbol not in", values, "symbol");
            return (Criteria) this;
        }

        public Criteria andSymbolBetween(String value1, String value2) {
            addCriterion("symbol between", value1, value2, "symbol");
            return (Criteria) this;
        }

        public Criteria andSymbolNotBetween(String value1, String value2) {
            addCriterion("symbol not between", value1, value2, "symbol");
            return (Criteria) this;
        }

        public Criteria andStartDayIsNull() {
            addCriterion("start_day is null");
            return (Criteria) this;
        }

        public Criteria andStartDayIsNotNull() {
            addCriterion("start_day is not null");
            return (Criteria) this;
        }

        public Criteria andStartDayEqualTo(String value) {
            addCriterion("start_day =", value, "startDay");
            return (Criteria) this;
        }

        public Criteria andStartDayNotEqualTo(String value) {
            addCriterion("start_day <>", value, "startDay");
            return (Criteria) this;
        }

        public Criteria andStartDayGreaterThan(String value) {
            addCriterion("start_day >", value, "startDay");
            return (Criteria) this;
        }

        public Criteria andStartDayGreaterThanOrEqualTo(String value) {
            addCriterion("start_day >=", value, "startDay");
            return (Criteria) this;
        }

        public Criteria andStartDayLessThan(String value) {
            addCriterion("start_day <", value, "startDay");
            return (Criteria) this;
        }

        public Criteria andStartDayLessThanOrEqualTo(String value) {
            addCriterion("start_day <=", value, "startDay");
            return (Criteria) this;
        }

        public Criteria andStartDayLike(String value) {
            addCriterion("start_day like", value, "startDay");
            return (Criteria) this;
        }

        public Criteria andStartDayNotLike(String value) {
            addCriterion("start_day not like", value, "startDay");
            return (Criteria) this;
        }

        public Criteria andStartDayIn(List<String> values) {
            addCriterion("start_day in", values, "startDay");
            return (Criteria) this;
        }

        public Criteria andStartDayNotIn(List<String> values) {
            addCriterion("start_day not in", values, "startDay");
            return (Criteria) this;
        }

        public Criteria andStartDayBetween(String value1, String value2) {
            addCriterion("start_day between", value1, value2, "startDay");
            return (Criteria) this;
        }

        public Criteria andStartDayNotBetween(String value1, String value2) {
            addCriterion("start_day not between", value1, value2, "startDay");
            return (Criteria) this;
        }

        public Criteria andEndDayIsNull() {
            addCriterion("end_day is null");
            return (Criteria) this;
        }

        public Criteria andEndDayIsNotNull() {
            addCriterion("end_day is not null");
            return (Criteria) this;
        }

        public Criteria andEndDayEqualTo(String value) {
            addCriterion("end_day =", value, "endDay");
            return (Criteria) this;
        }

        public Criteria andEndDayNotEqualTo(String value) {
            addCriterion("end_day <>", value, "endDay");
            return (Criteria) this;
        }

        public Criteria andEndDayGreaterThan(String value) {
            addCriterion("end_day >", value, "endDay");
            return (Criteria) this;
        }

        public Criteria andEndDayGreaterThanOrEqualTo(String value) {
            addCriterion("end_day >=", value, "endDay");
            return (Criteria) this;
        }

        public Criteria andEndDayLessThan(String value) {
            addCriterion("end_day <", value, "endDay");
            return (Criteria) this;
        }

        public Criteria andEndDayLessThanOrEqualTo(String value) {
            addCriterion("end_day <=", value, "endDay");
            return (Criteria) this;
        }

        public Criteria andEndDayLike(String value) {
            addCriterion("end_day like", value, "endDay");
            return (Criteria) this;
        }

        public Criteria andEndDayNotLike(String value) {
            addCriterion("end_day not like", value, "endDay");
            return (Criteria) this;
        }

        public Criteria andEndDayIn(List<String> values) {
            addCriterion("end_day in", values, "endDay");
            return (Criteria) this;
        }

        public Criteria andEndDayNotIn(List<String> values) {
            addCriterion("end_day not in", values, "endDay");
            return (Criteria) this;
        }

        public Criteria andEndDayBetween(String value1, String value2) {
            addCriterion("end_day between", value1, value2, "endDay");
            return (Criteria) this;
        }

        public Criteria andEndDayNotBetween(String value1, String value2) {
            addCriterion("end_day not between", value1, value2, "endDay");
            return (Criteria) this;
        }

        public Criteria andDataInCsvIsNull() {
            addCriterion("data_in_csv is null");
            return (Criteria) this;
        }

        public Criteria andDataInCsvIsNotNull() {
            addCriterion("data_in_csv is not null");
            return (Criteria) this;
        }

        public Criteria andDataInCsvEqualTo(String value) {
            addCriterion("data_in_csv =", value, "dataInCsv");
            return (Criteria) this;
        }

        public Criteria andDataInCsvNotEqualTo(String value) {
            addCriterion("data_in_csv <>", value, "dataInCsv");
            return (Criteria) this;
        }

        public Criteria andDataInCsvGreaterThan(String value) {
            addCriterion("data_in_csv >", value, "dataInCsv");
            return (Criteria) this;
        }

        public Criteria andDataInCsvGreaterThanOrEqualTo(String value) {
            addCriterion("data_in_csv >=", value, "dataInCsv");
            return (Criteria) this;
        }

        public Criteria andDataInCsvLessThan(String value) {
            addCriterion("data_in_csv <", value, "dataInCsv");
            return (Criteria) this;
        }

        public Criteria andDataInCsvLessThanOrEqualTo(String value) {
            addCriterion("data_in_csv <=", value, "dataInCsv");
            return (Criteria) this;
        }

        public Criteria andDataInCsvLike(String value) {
            addCriterion("data_in_csv like", value, "dataInCsv");
            return (Criteria) this;
        }

        public Criteria andDataInCsvNotLike(String value) {
            addCriterion("data_in_csv not like", value, "dataInCsv");
            return (Criteria) this;
        }

        public Criteria andDataInCsvIn(List<String> values) {
            addCriterion("data_in_csv in", values, "dataInCsv");
            return (Criteria) this;
        }

        public Criteria andDataInCsvNotIn(List<String> values) {
            addCriterion("data_in_csv not in", values, "dataInCsv");
            return (Criteria) this;
        }

        public Criteria andDataInCsvBetween(String value1, String value2) {
            addCriterion("data_in_csv between", value1, value2, "dataInCsv");
            return (Criteria) this;
        }

        public Criteria andDataInCsvNotBetween(String value1, String value2) {
            addCriterion("data_in_csv not between", value1, value2, "dataInCsv");
            return (Criteria) this;
        }

        public Criteria andCreatedTimeIsNull() {
            addCriterion("created_time is null");
            return (Criteria) this;
        }

        public Criteria andCreatedTimeIsNotNull() {
            addCriterion("created_time is not null");
            return (Criteria) this;
        }

        public Criteria andCreatedTimeEqualTo(Long value) {
            addCriterion("created_time =", value, "createdTime");
            return (Criteria) this;
        }

        public Criteria andCreatedTimeNotEqualTo(Long value) {
            addCriterion("created_time <>", value, "createdTime");
            return (Criteria) this;
        }

        public Criteria andCreatedTimeGreaterThan(Long value) {
            addCriterion("created_time >", value, "createdTime");
            return (Criteria) this;
        }

        public Criteria andCreatedTimeGreaterThanOrEqualTo(Long value) {
            addCriterion("created_time >=", value, "createdTime");
            return (Criteria) this;
        }

        public Criteria andCreatedTimeLessThan(Long value) {
            addCriterion("created_time <", value, "createdTime");
            return (Criteria) this;
        }

        public Criteria andCreatedTimeLessThanOrEqualTo(Long value) {
            addCriterion("created_time <=", value, "createdTime");
            return (Criteria) this;
        }

        public Criteria andCreatedTimeIn(List<Long> values) {
            addCriterion("created_time in", values, "createdTime");
            return (Criteria) this;
        }

        public Criteria andCreatedTimeNotIn(List<Long> values) {
            addCriterion("created_time not in", values, "createdTime");
            return (Criteria) this;
        }

        public Criteria andCreatedTimeBetween(Long value1, Long value2) {
            addCriterion("created_time between", value1, value2, "createdTime");
            return (Criteria) this;
        }

        public Criteria andCreatedTimeNotBetween(Long value1, Long value2) {
            addCriterion("created_time not between", value1, value2, "createdTime");
            return (Criteria) this;
        }

        public Criteria andModifiedTimeIsNull() {
            addCriterion("modified_time is null");
            return (Criteria) this;
        }

        public Criteria andModifiedTimeIsNotNull() {
            addCriterion("modified_time is not null");
            return (Criteria) this;
        }

        public Criteria andModifiedTimeEqualTo(Long value) {
            addCriterion("modified_time =", value, "modifiedTime");
            return (Criteria) this;
        }

        public Criteria andModifiedTimeNotEqualTo(Long value) {
            addCriterion("modified_time <>", value, "modifiedTime");
            return (Criteria) this;
        }

        public Criteria andModifiedTimeGreaterThan(Long value) {
            addCriterion("modified_time >", value, "modifiedTime");
            return (Criteria) this;
        }

        public Criteria andModifiedTimeGreaterThanOrEqualTo(Long value) {
            addCriterion("modified_time >=", value, "modifiedTime");
            return (Criteria) this;
        }

        public Criteria andModifiedTimeLessThan(Long value) {
            addCriterion("modified_time <", value, "modifiedTime");
            return (Criteria) this;
        }

        public Criteria andModifiedTimeLessThanOrEqualTo(Long value) {
            addCriterion("modified_time <=", value, "modifiedTime");
            return (Criteria) this;
        }

        public Criteria andModifiedTimeIn(List<Long> values) {
            addCriterion("modified_time in", values, "modifiedTime");
            return (Criteria) this;
        }

        public Criteria andModifiedTimeNotIn(List<Long> values) {
            addCriterion("modified_time not in", values, "modifiedTime");
            return (Criteria) this;
        }

        public Criteria andModifiedTimeBetween(Long value1, Long value2) {
            addCriterion("modified_time between", value1, value2, "modifiedTime");
            return (Criteria) this;
        }

        public Criteria andModifiedTimeNotBetween(Long value1, Long value2) {
            addCriterion("modified_time not between", value1, value2, "modifiedTime");
            return (Criteria) this;
        }
    }

    public static class Criteria extends GeneratedCriteria {
        protected Criteria() {
            super();
        }
    }

    public static class Criterion {
        private String condition;

        private Object value;

        private Object secondValue;

        private boolean noValue;

        private boolean singleValue;

        private boolean betweenValue;

        private boolean listValue;

        private String typeHandler;

        public String getCondition() {
            return condition;
        }

        public Object getValue() {
            return value;
        }

        public Object getSecondValue() {
            return secondValue;
        }

        public boolean isNoValue() {
            return noValue;
        }

        public boolean isSingleValue() {
            return singleValue;
        }

        public boolean isBetweenValue() {
            return betweenValue;
        }

        public boolean isListValue() {
            return listValue;
        }

        public String getTypeHandler() {
            return typeHandler;
        }

        protected Criterion(String condition) {
            super();
            this.condition = condition;
            this.typeHandler = null;
            this.noValue = true;
        }

        protected Criterion(String condition, Object value, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.typeHandler = typeHandler;
            if (value instanceof List<?>) {
                this.listValue = true;
            } else {
                this.singleValue = true;
            }
        }

        protected Criterion(String condition, Object value) {
            this(condition, value, null);
        }

        protected Criterion(String condition, Object value, Object secondValue, String typeHandler) {
            super();
            this.condition = condition;
            this.value = value;
            this.secondValue = secondValue;
            this.typeHandler = typeHandler;
            this.betweenValue = true;
        }

        protected Criterion(String condition, Object value, Object secondValue) {
            this(condition, value, secondValue, null);
        }
    }
}