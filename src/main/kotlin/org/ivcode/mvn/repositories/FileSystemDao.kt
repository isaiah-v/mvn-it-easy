package org.ivcode.mvn.repositories

import org.apache.ibatis.annotations.*
import org.ivcode.mvn.repositories.model.FileInfoEntity
import org.ivcode.mvn.repositories.model.FileSystemDirectoryEntity
import org.ivcode.mvn.repositories.model.FileSystemFileEntity
import java.io.InputStream


public const val SELECT_HIERARCHY_MYSQL: String = """<script>
 <foreach item="item" index="index" collection="path" open="SET @path=JSON_ARRAY(" separator="," close=");">#{item}</foreach>
 WITH RECURSIVE link(`id`, `level`) AS (
  SELECT id, 0
  FROM file_system f
  WHERE
   f.`parent_id` IS NULL
   AND f.`repository_id`=#{repositoryId}
   AND f.`name`=JSON_EXTRACT(@path, '${'$'}[0]')

  UNION ALL

  SELECT file_system.`id`, `level`+1
  FROM link INNER JOIN `file_system` ON link.`id` = file_system.`parent_id`
  WHERE
   `level` &lt; JSON_LENGTH(@path)
   AND file_system.`name`=JSON_EXTRACT(@path, CONCAT('${'$'}[', `level`+1, ']'))
 )
 SELECT
  file_system.`id`,
  file_system.`repository_id`,
  file_system.`parent_id`,
  file_system.`name`,
  file_system.`directory`,
  file_system.`last_modified`,
  file_system.`mime`,
  LENGTH(file_system.DATA) AS `size`
 FROM
  link
  INNER JOIN file_system ON link.`id` = file_system.`id` ORDER BY `level`
</script>"""

public const val SELECT_HIERARCHY_H2: String = """
 WITH link(`id`, `level`) AS (
  SELECT id, 1
  FROM file_system f
  WHERE
   f.`parent_id` IS NULL
   AND f.`repository_id`=#{repositoryId}
   AND f.`name`=CAST(#{path} AS VARCHAR ARRAY)[1]

  UNION ALL

  SELECT file_system.`id`, `level`+1
  FROM LINK INNER JOIN `file_system` ON link.`id` = file_system.`parent_id`
  WHERE
   `level`<CARDINALITY(CAST(#{path} AS VARCHAR ARRAY))
   AND file_system.`name`=CAST(#{path} AS VARCHAR ARRAY)[LEVEL+1]
 )
 SELECT
  file_system.`id`,
  file_system.`repository_id`,
  file_system.`parent_id`,
  file_system.`name`,
  file_system.`directory`,
  file_system.`last_modified`,
  file_system.`mime`,
  LENGTH(file_system.DATA) AS `size`
 FROM
  link
  INNER JOIN file_system ON link.`id` = file_system.`id` ORDER BY `level`
"""

public const val SELECT_PATH: String = """<script>
 SELECT
  f${"\${path.length-1}"}.`id`,
  f${"\${path.length-1}"}.`repository_id`,
  f${"\${path.length-1}"}.`parent_id`,
  f${"\${path.length-1}"}.`name`,
  f${"\${path.length-1}"}.`directory`,
  f${"\${path.length-1}"}.`last_modified`,
  f${"\${path.length-1}"}.`mime`,
  LENGTH(f${"\${path.length-1}"}.`data`) AS `size`
 FROM
  <foreach item="entry" index="index" collection="path" separator=" INNER JOIN " nullable="true">
   file_system f${"\${index}"} <if test="index>0">ON f${"\${index-1}"}.ID = f${"\${index}"}.PARENT_ID</if>
  </foreach>
 WHERE
  <foreach item="entry" index="index" collection="path" separator=" AND " nullable="true">
   f${"\${index}"}.`name`=#{entry}
  </foreach>
  AND f0.`parent_id` IS NULL
  AND f0.`repository_id`=#{repositoryId}
</script>"""

public const val CREATE_FILE_SYSTEM_ENTRY: String = """
 INSERT INTO file_system (`repository_id`, `parent_id`, `name`, `directory`)
 VALUES(#{repositoryId}, #{parentId}, #{name}, #{directory})
"""

public const val CREATE_FILE_SYSTEM_DIRECTORY_ENTRY: String = """
 INSERT INTO file_system (`repository_id`, `parent_id`, `name`, `directory`)
 VALUES(#{repositoryId}, #{parentId}, #{name}, TRUE)
"""

public const val CREATE_FILE_SYSTEM_FILE_ENTRY: String = """
 INSERT INTO file_system (`repository_id`, `parent_id`, `name`, `last_modified`, `mime`, `directory`, `data`)
 VALUES(#{entry.repositoryId}, #{entry.parentId}, #{entry.name}, CURRENT_TIMESTAMP(), #{entry.mime}, FALSE, #{data})
"""

public const val READ_ENTRY: String = """
 SELECT `id`, `repository_id`, `parent_id`, `name`, `directory`, `last_modified`, `mime`, LENGTH(`data`) AS `size` FROM file_system WHERE `id`=#{id}
"""

public const val READ_DATA: String = """
 SELECT `DATA` FROM file_system WHERE `id`=#{id}
"""

public const val READ_CHILDREN: String = """
 SELECT `id`, `repository_id`, `parent_id`, `name`, `directory`, `last_modified`, `mime`, LENGTH(`data`) AS `size` FROM file_system WHERE `parent_id`=#{parentId}
"""

public const val READ_ROOT_CHILDREN: String = """
 SELECT `id`, `repository_id`, `parent_id`, `name`, `directory`, `last_modified`, `mime`, LENGTH(`data`) AS `size` FROM file_system WHERE `repository_id`=#{repositoryId} AND `parent_id` IS NULL
"""

public const val IS_EMPTY_DIRECTORY: String = """
 SELECT COUNT(*)=0 AS `empty` FROM file_system WHERE `parent_id`=#{id}
"""

public const val UPDATE_FILE_SYSTEM_ENTRY: String = """
 UPDATE file_system
 SET `repository_id`=#{repositoryId}, `parent_id`=#{parentId}, `name`=#{name}, `directory`=#{directory}
 WHERE `ID`=#{id}
"""

public const val UPDATE_FILE_ENTRY: String = """
 UPDATE
  file_system
 SET
  `repository_id`=#{entry.repositoryId},
  `parent_id`=#{entry.parentId},
  `name`=#{entry.name},
  `last_modified`=CURRENT_TIMESTAMP(),
  `mime`=#{entry.mime},
  `data`=#{data}
 WHERE `id`=#{entry.id}
"""

public const val DELETE_FILE_SYSTEM_ENTRY: String = """
 DELETE FROM file_system WHERE `id`=#{id}
"""

public const val DELETE_ROOT: String = """
 DELETE FROM file_system WHERE `repository_id`=#{repositoryId} AND `parent_id` IS NULL
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
    @Select(SELECT_HIERARCHY_H2, databaseId = "h2")
    @Select(SELECT_HIERARCHY_MYSQL, databaseId = "mysql")
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
