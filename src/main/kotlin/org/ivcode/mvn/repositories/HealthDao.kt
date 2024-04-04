package org.ivcode.mvn.repositories

import org.apache.ibatis.annotations.Mapper
import org.apache.ibatis.annotations.Select
import org.ivcode.mvn.repositories.sql.HEALTH_CHECK

@Mapper
public interface HealthDao {

    @Select(HEALTH_CHECK)
    public fun healthCheck(): Int
}