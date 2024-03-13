package org.ivcode.mvn.repositories

import org.apache.ibatis.annotations.*
import org.ivcode.mvn.repositories.model.RepositoryEntity
import org.ivcode.mvn.repositories.sql.*

@Mapper
public interface RepositoryDao {
    @Insert(REPOSITORY_CREATE)
    @Options(useGeneratedKeys = true, keyProperty = "id", keyColumn = "id")
    public fun createRepository(repository: RepositoryEntity)

    @Select(REPOSITORY_READ)
    public fun readRepository(name: String): RepositoryEntity?

    @Select(REPOSITORY_READ_ALL)
    public fun read(): List<RepositoryEntity>

    @Update(REPOSITORY_UPDATE)
    public fun updateRepository(repository: RepositoryEntity): Int

    @Delete(REPOSITORY_DELETE)
    public fun deleteRepository(name: String): Int
}
