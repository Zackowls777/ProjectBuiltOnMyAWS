package com.dzm.config;

import com.github.pagehelper.PageInterceptor;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.context.annotation.Configuration;
import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.util.List;
import java.util.Properties;


@Configuration
public class PageHelperConfig {

    /**
     * 可能存在多个连接工厂，是允许这么注入的
     */
    @Resource
    private List<SqlSessionFactory> sqlSessionFactoryList;

    @PostConstruct
    public void initConfig(){
        PageInterceptor pageInterceptor = new PageInterceptor();
        Properties properties = new Properties();

        properties.setProperty("helperDialect","mysql");

        pageInterceptor.setProperties(properties);
        sqlSessionFactoryList.forEach(factory ->factory.getConfiguration().addInterceptor(pageInterceptor));
    }
}

