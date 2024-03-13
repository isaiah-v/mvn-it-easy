package org.ivcode.mvn.repositories

import org.apache.ibatis.annotations.Delete
import org.apache.ibatis.annotations.Insert
import org.apache.ibatis.annotations.Mapper
import org.apache.ibatis.annotations.Options
import org.apache.ibatis.annotations.Result
import org.apache.ibatis.annotations.Select
import org.apache.ibatis.annotations.Update
import org.ivcode.mvn.repositories.model.BasicAuthEntity
import org.ivcode.mvn.repositories.sql.*


@Mapper
public interface BasicAuthDao {

    @Insert(BASIC_AUTH_CREATE)
    @Options(useGeneratedKeys = true, keyProperty = "id", keyColumn = "ID")
    public fun create(basicAuth: BasicAuthEntity)

    @Select(BASIC_AUTH_READ)
    @Result(property = "id", column = "ID")
    @Result(property = "username", column = "USERNAME")
    @Result(property = "write", column = "WRITE")
    @Result(property = "salt", column = "SALT")
    @Result(property = "hash", column = "HASH")
    public fun read(username: String): BasicAuthEntity?

    @Select(BASIC_AUTH_READ_ALL)
    @Result(property = "id", column = "ID")
    @Result(property = "username", column = "USERNAME")
    @Result(property = "write", column = "WRITE")
    @Result(property = "salt", column = "SALT")
    @Result(property = "hash", column = "HASH")
    public fun readAll(): List<BasicAuthEntity>

    @Update(BASIC_AUTH_UPDATE)
    public fun update(basicAuth: BasicAuthEntity): Int

    @Delete(BASIC_AUTH_DELETE)
    public fun delete(id: Long): Int

    @Delete(BASIC_AUTH_DELETE_BY_USERNAME)
    public fun deleteByUsername(username: String): Int
}
