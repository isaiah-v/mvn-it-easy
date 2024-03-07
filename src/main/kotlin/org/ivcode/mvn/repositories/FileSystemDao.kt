package org.ivcode.mvn.repositories

import org.apache.ibatis.annotations.*
import org.ivcode.mvn.repositories.model.FileInfoEntity
import org.ivcode.mvn.repositories.model.FileSystemDirectoryEntity
import org.ivcode.mvn.repositories.model.FileSystemFileEntity
import java.io.InputStream


public const val SELECT_HIERARCHY_H2: String = """
 WITH LINK(ID, LEVEL) AS (
  SELECT ID, 1
  FROM FILE_SYSTEM f
  WHERE
   f.PARENT_ID IS NULL
   AND f.REPOSITORY_ID=#{repositoryId}
   AND f.NAME=CAST(#{path} AS VARCHAR ARRAY)[1]

  UNION ALL

  SELECT FILE_SYSTEM.ID, LEVEL+1
  FROM LINK INNER JOIN FILE_SYSTEM ON LINK.ID = FILE_SYSTEM.PARENT_ID
  WHERE
   LEVEL<CARDINALITY(CAST(#{path} AS VARCHAR ARRAY))
   AND FILE_SYSTEM.NAME=CAST(#{path} AS VARCHAR ARRAY)[LEVEL+1]
 )
 SELECT
  FILE_SYSTEM.ID,
  FILE_SYSTEM.REPOSITORY_ID,
  FILE_SYSTEM.PARENT_ID,
  FILE_SYSTEM.NAME,
  FILE_SYSTEM.DIRECTORY,
  FILE_SYSTEM.LAST_MODIFIED,
  FILE_SYSTEM.MIME,
  LENGTH(FILE_SYSTEM.DATA) AS SIZE
 FROM
  LINK
  INNER JOIN FILE_SYSTEM ON LINK.ID = FILE_SYSTEM.ID ORDER BY LEVEL
"""

public const val SELECT_PATH: String = """<script>
 SELECT
  f${"\${path.length-1}"}.ID,
  f${"\${path.length-1}"}.REPOSITORY_ID,
  f${"\${path.length-1}"}.PARENT_ID,
  f${"\${path.length-1}"}.NAME,
  f${"\${path.length-1}"}.DIRECTORY,
  f${"\${path.length-1}"}.LAST_MODIFIED,
  f${"\${path.length-1}"}.MIME,
  LENGTH(f${"\${path.length-1}"}.DATA) AS SIZE
 FROM
  <foreach item="entry" index="index" collection="path" separator=" INNER JOIN " nullable="true">
   FILE_SYSTEM f${"\${index}"} <if test="index>0">ON f${"\${index-1}"}.ID = f${"\${index}"}.PARENT_ID</if>
  </foreach>
 WHERE
  <foreach item="entry" index="index" collection="path" separator=" AND " nullable="true">
   f${"\${index}"}.NAME=#{entry}
  </foreach>
  AND f0.PARENT_ID IS NULL
  AND f0.REPOSITORY_ID=#{repositoryId}
</script>"""

public const val CREATE_FILE_SYSTEM_ENTRY: String = """
 INSERT INTO FILE_SYSTEM (REPOSITORY_ID, PARENT_ID, NAME, DIRECTORY)
 VALUES(#{repositoryId}, #{parentId}, #{name}, #{directory})
"""

public const val CREATE_FILE_SYSTEM_DIRECTORY_ENTRY: String = """
 INSERT INTO FILE_SYSTEM (REPOSITORY_ID, PARENT_ID, NAME, DIRECTORY)
 VALUES(#{repositoryId}, #{parentId}, #{name}, TRUE)
"""

public const val CREATE_FILE_SYSTEM_FILE_ENTRY: String = """
 INSERT INTO FILE_SYSTEM (REPOSITORY_ID, PARENT_ID, NAME, LAST_MODIFIED, MIME, DIRECTORY, DATA)
 VALUES(#{entry.repositoryId}, #{entry.parentId}, #{entry.name}, CURRENT_TIMESTAMP(), #{entry.mime}, FALSE, #{data})
"""

public const val READ_ENTRY: String = """
 SELECT ID, REPOSITORY_ID, PARENT_ID, NAME, DIRECTORY, LAST_MODIFIED, MIME, LENGTH(DATA) AS SIZE FROM FILE_SYSTEM WHERE id=#{id}
"""

public const val READ_DATA: String = """
 SELECT DATA FROM FILE_SYSTEM WHERE id=#{id}
"""

public const val READ_CHILDREN: String = """
 SELECT ID, REPOSITORY_ID, PARENT_ID, NAME, DIRECTORY, LAST_MODIFIED, MIME, LENGTH(DATA) AS SIZE FROM FILE_SYSTEM WHERE parent_id=#{parentId}
"""

public const val READ_ROOT_CHILDREN: String = """
 SELECT ID, REPOSITORY_ID, PARENT_ID, NAME, DIRECTORY, LAST_MODIFIED, MIME, LENGTH(DATA) AS SIZE FROM FILE_SYSTEM WHERE repository_id=#{repositoryId} AND parent_id IS NULL
"""

public const val IS_EMPTY_DIRECTORY: String = """
 SELECT COUNT(*)=0 AS EMPTY FROM FILE_SYSTEM WHERE parent_id=#{id}
"""

public const val UPDATE_FILE_SYSTEM_ENTRY: String = """
 UPDATE FILE_SYSTEM
 SET REPOSITORY_ID=#{repositoryId}, PARENT_ID=#{parentId}, NAME=#{name}, DIRECTORY=#{directory}
 WHERE ID=#{id}
"""

public const val UPDATE_FILE_ENTRY: String = """
 UPDATE
  FILE_SYSTEM
 SET
  REPOSITORY_ID=#{entry.repositoryId},
  PARENT_ID=#{entry.parentId},
  NAME=#{entry.name},
  LAST_MODIFIED=CURRENT_TIMESTAMP(),
  MIME=#{entry.mime},
  DATA=#{data}
 WHERE ID=#{entry.id}
"""

public const val DELETE_FILE_SYSTEM_ENTRY: String = """
 DELETE FROM FILE_HIERARCHY WHERE ID=#{id}
"""

public const val DELETE_ROOT: String = """
 DELETE FROM FILE_HIERARCHY REPOSITORY_ID=#{repositoryId} AND parent_id IS NULL
"""

@Mapper
public interface FileSystemDao {

    /**
     * Pulls the given path's hierarchy. For `org/ivcode/mvn`, the following will be returned assuming such paths
     * exist:
     *
     *  | `Name`    | `Parent` |
     *  |-----------|----------|
     *  | `org`     | `null`   |
     *  | `ivcode`  | `org`    |
     *  | `mvn`     | `ivocde` |
     *
     *
     * It will return as many of the elements that exist. If, for example, `org` exists, but `ivcode` and `mvn` do not,
     * only `org` will be returned.
     *
     * @param path The path to pull, Path Format: \["org", "ivcode", "mvn"] is equivalent to org/ivcode/mvn
     */
    @Select(SELECT_HIERARCHY_H2)
    @Result(property = "id", column = "ID")
    @Result(property = "repositoryId", column = "REPOSITORY_ID")
    @Result(property = "parentId", column = "PARENT_ID")
    @Result(property = "name", column = "NAME")
    @Result(property = "directory", column = "DIRECTORY")
    @Result(property = "lastModified", column = "LAST_MODIFIED")
    @Result(property = "mime", column = "MIME")
    public fun getHierarchy(
        repositoryId: Long,
        path: Array<String?>
    ): List<FileInfoEntity>

    @Select(SELECT_PATH)
    @Result(property = "id", column = "ID")
    @Result(property = "repositoryId", column = "REPOSITORY_ID")
    @Result(property = "parentId", column = "PARENT_ID")
    @Result(property = "name", column = "NAME")
    @Result(property = "directory", column = "DIRECTORY")
    @Result(property = "lastModified", column = "LAST_MODIFIED")
    @Result(property = "mime", column = "MIME")
    public fun getPath (
        repositoryId: Long,
        path: Array<String?>
    ): FileInfoEntity?

    @Insert(CREATE_FILE_SYSTEM_DIRECTORY_ENTRY)
    @Options(useGeneratedKeys = true, keyProperty = "id", keyColumn = "id")
    public fun createDirectoryEntry(entry: FileSystemDirectoryEntity)

    @Insert(CREATE_FILE_SYSTEM_FILE_ENTRY)
    @Options(useGeneratedKeys = true, keyProperty = "entry.id", keyColumn = "id")
    public fun createFileEntry(entry: FileSystemFileEntity, data: InputStream)

    @Select(READ_ENTRY)
    @Result(property = "id", column = "ID")
    @Result(property = "repositoryId", column = "REPOSITORY_ID")
    @Result(property = "parentId", column = "PARENT_ID")
    @Result(property = "name", column = "NAME")
    @Result(property = "directory", column = "DIRECTORY")
    @Result(property = "lastModified", column = "LAST_MODIFIED")
    @Result(property = "mime", column = "MIME")
    public fun readEntry(id: Long): FileInfoEntity?


    @Select(READ_DATA)
    public fun readData(id: Long): InputStream?

    /**
     * Returns all folders based of the given
     */
    @Select(READ_CHILDREN)
    @Result(property = "id", column = "ID")
    @Result(property = "repositoryId", column = "REPOSITORY_ID")
    @Result(property = "parentId", column = "PARENT_ID")
    @Result(property = "name", column = "NAME")
    @Result(property = "directory", column = "DIRECTORY")
    @Result(property = "lastModified", column = "LAST_MODIFIED")
    @Result(property = "mime", column = "MIME")
    public fun readChildren(parentId: Long): List<FileInfoEntity>

    /**
     * Returns all folders based of the given
     */
    @Select(READ_ROOT_CHILDREN)
    @Result(property = "id", column = "ID")
    @Result(property = "repositoryId", column = "REPOSITORY_ID")
    @Result(property = "parentId", column = "PARENT_ID")
    @Result(property = "name", column = "NAME")
    @Result(property = "directory", column = "DIRECTORY")
    @Result(property = "lastModified", column = "LAST_MODIFIED")
    @Result(property = "mime", column = "MIME")
    public fun readRoot(repositoryId: Long): List<FileInfoEntity>

    /**
     *
     */
    @Select(IS_EMPTY_DIRECTORY)
    public fun isEmpty(id: Long): Boolean

    /**
     * Updates a folder, assumes the ID to be the folder key
     * @param folder
     */
    @Select(UPDATE_FILE_SYSTEM_ENTRY)
    public fun updateFileSystemEntry(fileHierarchy: FileInfoEntity): Int

    @Select(UPDATE_FILE_ENTRY)
    public fun updateFileEntry(entry: FileSystemFileEntity, data: InputStream)

    /**
     * Deletes the given folder.
     * Warning: This is a cascading call. All children will be deleted too
     */
    @Delete(DELETE_FILE_SYSTEM_ENTRY)
    public fun deleteFileSystemEntry(id: Long): Int

    @Delete(DELETE_ROOT)
    public fun deleteRoot(repositoryId: Long): Int
}
