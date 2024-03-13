package org.ivcode.mvn.repositories.sql.mysql

internal const val SELECT_HIERARCHY_MYSQL: String = """<script>
 WITH RECURSIVE link(`id`, `level`) AS (
  SELECT id, 0
  FROM file_system f
  WHERE
   f.`parent_id` IS NULL
   AND f.`repository_id`=#{repositoryId}
   AND f.`name`=JSON_EXTRACT(<foreach item="item" index="index" collection="path" open="JSON_ARRAY(" separator="," close=")">#{item}</foreach>, '${'$'}[0]')

  UNION ALL

  SELECT file_system.`id`, `level`+1
  FROM link INNER JOIN `file_system` ON link.`id` = file_system.`parent_id`
  WHERE
   `level` &lt; JSON_LENGTH(<foreach item="item" index="index" collection="path" open="JSON_ARRAY(" separator="," close=")">#{item}</foreach>)
   AND file_system.`name`=JSON_EXTRACT(<foreach item="item" index="index" collection="path" open="JSON_ARRAY(" separator="," close=")">#{item}</foreach>, CONCAT('${'$'}[', `level`+1, ']'))
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