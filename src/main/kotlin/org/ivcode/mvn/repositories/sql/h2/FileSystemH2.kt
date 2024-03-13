package org.ivcode.mvn.repositories.sql.h2

internal const val SELECT_HIERARCHY_H2: String = """
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