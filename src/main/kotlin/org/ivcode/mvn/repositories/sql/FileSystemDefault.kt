package org.ivcode.mvn.repositories.sql

internal const val FILE_SYSTEM_SELECT_PATH: String = """<script>
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

internal const val FILE_SYSTEM_CREATE_DIRECTORY_ENTRY: String = """
 INSERT INTO file_system (`repository_id`, `parent_id`, `path_id`, `name`, `directory`)
 VALUES(#{repositoryId}, #{parentId}, IFNULL(#{parentId},0), #{name}, TRUE)
 ON DUPLICATE KEY UPDATE
   `repository_id`=#{repositoryId},
   `parent_id`=#{parentId},
   `path_id`=IFNULL(#{parentId},0),
   `name`=#{name},
   `directory`=TRUE
"""

internal const val FILE_SYSTEM_CREATE_FILE_ENTRY: String = """
 INSERT INTO file_system (`repository_id`, `parent_id`, `path_id`, `name`, `last_modified`, `mime`, `directory`, `data`)
 VALUES(#{entry.repositoryId}, #{entry.parentId}, IFNULL(#{entry.parentId},0), #{entry.name}, CURRENT_TIMESTAMP(), #{entry.mime}, FALSE, #{data})
 ON DUPLICATE KEY UPDATE
    `repository_id`=#{entry.repositoryId},
    `parent_id`=#{entry.parentId},
    `path_id`=IFNULL(#{entry.parentId},0),
    `name`=#{entry.name},
    `last_modified`=CURRENT_TIMESTAMP(),
    `mime`=#{entry.mime},
    `directory`=FALSE,
    `data`=#{data}
"""

internal const val FILE_SYSTEM_READ_ENTRY: String = """
 SELECT `id`, `repository_id`, `parent_id`, `name`, `directory`, `last_modified`, `mime`, LENGTH(`data`) AS `size` FROM file_system WHERE `id`=#{id}
"""

internal const val FILE_SYSTEM_READ_DATA: String = """
 SELECT `DATA` FROM file_system WHERE `id`=#{id}
"""

internal const val FILE_SYSTEM_READ_CHILDREN: String = """
 SELECT `id`, `repository_id`, `parent_id`, `name`, `directory`, `last_modified`, `mime`, LENGTH(`data`) AS `size` FROM file_system WHERE `parent_id`=#{parentId}
"""

internal const val FILE_SYSTEM_READ_ROOT: String = """
 SELECT `id`, `repository_id`, `parent_id`, `name`, `directory`, `last_modified`, `mime`, LENGTH(`data`) AS `size` FROM file_system WHERE `repository_id`=#{repositoryId} AND `parent_id` IS NULL
"""

internal const val FILE_SYSTEM_IS_EMPTY_DIRECTORY: String = """
 SELECT COUNT(*)=0 AS `empty` FROM file_system WHERE `parent_id`=#{id}
"""

internal const val FILE_SYSTEM_UPDATE_FILE_ENTRY: String = """
 UPDATE
  file_system
 SET
  `repository_id`=#{entry.repositoryId},
  `parent_id`=#{entry.parentId},
  `path_id`=IFNULL(#{entry.parentId},0),
  `name`=#{entry.name},
  `last_modified`=CURRENT_TIMESTAMP(),
  `mime`=#{entry.mime},
  `data`=#{data}
 WHERE `id`=#{entry.id}
"""

internal const val FILE_SYSTEM_DELETE: String = """
 DELETE FROM file_system WHERE `id`=#{id}
"""

internal const val FILE_SYSTEM_DELETE_ROOT: String = """
 DELETE FROM file_system WHERE `repository_id`=#{repositoryId} AND `parent_id` IS NULL
"""
