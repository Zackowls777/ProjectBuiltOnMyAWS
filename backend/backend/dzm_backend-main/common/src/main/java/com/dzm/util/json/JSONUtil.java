package com.dzm.util.json;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.stereotype.Component;
import org.json.JSONObject;

@Component
public class JSONUtil {

    public String toJSON(Object src) {
        ObjectMapper mapper = new ObjectMapper();
        try {
            return mapper.writeValueAsString(src);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return "";
        }
    }

    public <T> T parseJSON(String json, Class<T> tClass) {
        ObjectMapper mapper = new ObjectMapper();
        try {
            return mapper.readValue(json, tClass);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return null;
        }
    }

    public JSONObject parseJSON(String json) {
        try {
            return new JSONObject(json);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}
