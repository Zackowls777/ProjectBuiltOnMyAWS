package com.dzm.util.quant;

import com.dzm.exception.ServiceException;
import lombok.Data;
import lombok.Getter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.web.client.RestTemplate;

import javax.swing.table.TableRowSorter;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@Component
@Data
@Getter
@ConfigurationProperties(
        prefix = "quant.util"
)
public class QuantUtil {

    private String server;

    private String token;

    private Map<String, Object> config = new HashMap<>(){{
        put("compile", new HashMap<String, Object>(){{
            put("src_name", "solution.py");
            put("exe_name", "__pycache__/solution.cpython-36.pyc");
            put("max_cpu_time", 1000 * 30);
            put("max_real_time", 5000);
            put("max_memory", 512 * 1024 * 1024);
            put("compile_command", "/usr/bin/python3 -m py_compile {src_path}");
        }});
        put("run", new HashMap<String, Object>(){{
            put("command", "/usr/bin/python3 {exe_path} {input_file_path}");
            put("seccomp_rule", null);
            put("env", new ArrayList<>(){{
                add("PYTHONIOENCODING=UTF-8");
                add("LANG=en_US.UTF-8");
                add("LANGUAGE=en_US:en");
                add("LC_ALL=en_US.UTF-8");
            }});
        }});
    }};

    private String post(String url, Map<String, Object> data) {
        RestTemplate client = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        HttpMethod method = HttpMethod.POST;
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("X-Judge-Server-Token", getEncodeToken());
        HttpEntity<Map<String, Object>> requestEntity = new HttpEntity<>(data, headers);
        return client.exchange(url, method, requestEntity, String.class).getBody();
    }

    private String getEncodeToken() {
        try {
            MessageDigest messageDigest;
            messageDigest = MessageDigest.getInstance("SHA-256");
            messageDigest.update(token.getBytes("UTF-8"));
            byte[] bytes = messageDigest.digest();
            StringBuilder stringBuilder = new StringBuilder();
            for (int i = 0; i < bytes.length; i++){
                String temp = Integer.toHexString(bytes[i] & 0xFF);
                if (temp.length() == 1){
                    stringBuilder.append("0");
                }
                stringBuilder.append(temp);
            }
            return stringBuilder.toString();
        } catch (Exception e) {
            throw ServiceException.builder().message(e.toString()).build();
        }

    }


    public String ping() {
        return post(server + "/ping", new HashMap<>());
    }

    public String fetchStockData(String symbol, String startDay, String endDay) {
        Map<String, Object> data = new HashMap<>(){{
            put("symbol", symbol);
            put("start_day", startDay);
            put("end_day", endDay);
        }};
        return post(server + "/fetch_stock_daily_data_as_s3_csv_key", data);
    }

    public String submit(String dataCSV, String code) {
        Map<String, Object> data = new HashMap<>(){{
            put("test_cases", new ArrayList<>(){{
                add(new HashMap<String, Object>(){{
                    put("input", dataCSV);
                }});
            }});
            put("src", code);
            put("language_config", config);
            put("max_cpu_time", 1000 * 30);
            put("max_memory", 512 * 1024 * 1024);
            put("output", true);
        }};
        return post(server + "/judge", data);
    }


}
