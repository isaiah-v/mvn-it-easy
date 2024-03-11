package org.ivcode.mvn.repositories

import org.apache.ibatis.annotations.Delete
import org.apache.ibatis.annotations.Insert
import org.apache.ibatis.annotations.Mapper
import org.apache.ibatis.annotations.Options
import org.apache.ibatis.annotations.Result
import org.apache.ibatis.annotations.Select
import org.apache.ibatis.annotations.Update
import org.ivcode.mvn.repositories.model.BasicAuthEntity

private const val CREATE_BASIC_AUTH = """
 INSERT INTO basic_auth (`username`, `write`, `salt`, `hash`)
 VALUES(#{username}, #{write}, #{salt}, #{hash})
"""

private const val READ_BASIC_AUTH = """
 SELECT * FROM basic_auth WHERE `username`=#{username}
"""

private const val READ_BASIC_AUTH_ALL = """
 SELECT * FROM basic_auth
"""

private const val UPDATE_BASIC_AUTH = """
 UPDATE basic_auth
 SET `username`=#{username}, `write`=#{write}, `salt`=#{salt}, `hash`=#{hash}
 WHERE `id`=#{id}
"""

private const val DELETE_BASIC_AUTH = """
 DELETE FROM basic_auth
 WHERE `id`=#{id}
"""

private const val DELETE_BASIC_AUTH_BY_USERNAME = """
 DELETE FROM basic_auth
 WHERE `username`=#{username}
"""

@Mapper
public interface BasicAuthDao {

    @Insert(CREATE_BASIC_AUTH)
    @Options(useGeneratedKeys = true, keyProperty = "id", keyColumn = "ID")
    public fun create(basicAuth: BasicAuthEntity)

    @Select(READ_BASIC_AUTH)
    @Result(property = "id", column = "ID")
    @Result(property = "username", column = "USERNAME")
    @Result(property = "write", column = "WRITE")
    @Result(property = "salt", column = "SALT")
    @Result(property = "hash", column = "HASH")
    public fun read(username: String): BasicAuthEntity?

    @Select(READ_BASIC_AUTH_ALL)
    @Result(property = "id", column = "ID")
    @Result(property = "username", column = "USERNAME")
    @Result(property = "write", column = "WRITE")
    @Result(property = "salt", column = "SALT")
    @Result(property = "hash", column = "HASH")
    public fun readAll(): List<BasicAuthEntity>

    @Update(UPDATE_BASIC_AUTH)
    public fun update(basicAuth: BasicAuthEntity): Int

    @Delete(DELETE_BASIC_AUTH)
    public fun delete(id: Long): Int

    @Delete(DELETE_BASIC_AUTH_BY_USERNAME)
    public fun deleteByUsername(username: String): Int
}
