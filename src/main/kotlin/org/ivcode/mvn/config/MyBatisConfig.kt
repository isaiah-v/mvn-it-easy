package org.ivcode.mvn.config

import com.zaxxer.hikari.HikariDataSource
import org.apache.ibatis.mapping.DatabaseIdProvider
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration

// --== Supported JDBC Drivers ==-- //
private const val DRIVER_H2 = "org.h2.Driver"
private const val DRIVER_MYSQL = "com.mysql.jdbc.Driver"
private const val DRIVER_MYSQL2 = "com.mysql.cj.jdbc.Driver"

@Configuration
public class MyBatisConfig {

    /**
     * Defines the database id based on the driver's class name.
     *
     * To define vendor specific sql, use the "databaseId" property in the mybatis annotations.
     *
     * @see [org.apache.ibatis.annotations.Select.databaseId]
     * @see [org.apache.ibatis.annotations.Insert.databaseId]
     * @see [org.apache.ibatis.annotations.Update.databaseId]
     * @see [org.apache.ibatis.annotations.Delete.databaseId]
     */
    @Bean
    public fun createDatabaseIdProvider(): DatabaseIdProvider =
        DatabaseIdProvider { dataSource ->
            when(val driver = (dataSource as HikariDataSource).driverClassName) {
                DRIVER_H2 -> "h2"
                DRIVER_MYSQL, DRIVER_MYSQL2 -> "mysql"
                else -> throw IllegalArgumentException("unsupported driver: $driver")
            }
        }
}