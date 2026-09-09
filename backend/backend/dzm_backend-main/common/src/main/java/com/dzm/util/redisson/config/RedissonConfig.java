package com.dzm.util.redisson.config;

import com.dzm.exception.ServiceException;
import com.dzm.util.redisson.constant.RedissonModeType;
import com.dzm.constant.ServiceResponseStatusType;
import org.redisson.Redisson;
import org.redisson.api.RedissonClient;
import org.redisson.config.Config;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;


@Configuration
public class RedissonConfig {

    @Value("${spring.redis.redisson.mode}")
    private String mode;

    /**
     * 仅仅用于sentinel模式。
     */
    @Value("${spring.redis.redisson.masterName:}")
    private String masterName;

    @Value("${spring.redis.redisson.address}")
    private String address;

    /**
     * 数据库默认0
     */
    @Value("${spring.redis.redisson.database:0}")
    private Integer database;

    @Bean
    public RedissonClient redissonClient() {

        Config config = new Config();

        if(mode.equals(RedissonModeType.SINGLE)){
            config.useSingleServer()
                    .setDatabase(database)
                    .setAddress(address);
        } else if (mode.equals(RedissonModeType.CLUSTER)) {
            String[] clusterAddresses = address.split(",");
            config.useClusterServers()
                    .addNodeAddress(clusterAddresses);
        } else if (mode.equals(RedissonModeType.SENTINEL)) {
            String[] sentinelAddresses = address.split(",");
            config.useSentinelServers()
                    .setDatabase(database)
                    .setMasterName(masterName)
                    .addSentinelAddress(sentinelAddresses);
        } else if(mode.equals(RedissonModeType.MASTER_SLAVE)){
            String[] masterSlaveAddresses = address.split(",");
            if (masterSlaveAddresses.length == 1) {
                throw new IllegalArgumentException(
                        "redis.redisson.address MUST have multiple redis addresses for master-slave mode.");
            }
            String[] slaveAddresses = new String[masterSlaveAddresses.length - 1];
            System.arraycopy(masterSlaveAddresses, 1, slaveAddresses, 0, slaveAddresses.length);
            config.useMasterSlaveServers()
                    .setDatabase(database)
                    .setMasterAddress(masterSlaveAddresses[0])
                    .addSlaveAddress(slaveAddresses);
        } else {
            throw ServiceException.builder()
                    .status(ServiceResponseStatusType.SERVER_ERROR.getStatus())
                    .serverErrorMessage("redisson mode " + mode + " is not supported.")
                    .build();
        }
        return Redisson.create(config);
    }
}
