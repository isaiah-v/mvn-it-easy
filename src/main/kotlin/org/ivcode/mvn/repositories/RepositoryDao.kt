package org.ivcode.mvn.repositories

import org.apache.ibatis.annotations.*
import org.ivcode.mvn.repositories.model.RepositoryEntity

private const val CREATE_REPO = """
 INSERT INTO repository (`name`, `public`)
 VALUES(#{name}, #{public})
"""

private const val READ_REPO = """
 SELECT `id`, `name`, `public`
 FROM repository
 WHERE `name`=#{name}
"""

private const val READ_ALL_REPOS = """
 SELECT `id`, `name`, `public`
 FROM repository
"""


private const val UPDATE_REPO = """
 UPDATE `repository`
 SET `name`=#{name}, `public`=#{public}
 WHERE id=#{id}
"""

private const val DELETE_REPO = """
 DELETE FROM repository WHERE `name`=#{name} 
"""

@Mapper
public interface RepositoryDao {
    @Insert(CREATE_REPO)
    @Options(useGeneratedKeys = true, keyProperty = "id", keyColumn = "id")
    public fun createRepository(repository: RepositoryEntity)

    @Select(READ_REPO)
    public fun readRepository(name: String): RepositoryEntity?

    @Select(READ_ALL_REPOS)
    public fun read(): List<RepositoryEntity>

    @Update(UPDATE_REPO)
    public fun updateRepository(repository: RepositoryEntity): Int

    @Delete(DELETE_REPO)
    public fun deleteRepository(name: String): Int
}
