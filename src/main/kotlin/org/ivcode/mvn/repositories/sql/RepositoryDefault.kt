package org.ivcode.mvn.repositories.sql

internal const val REPOSITORY_CREATE = """
 INSERT INTO repository (`name`, `public`)
 VALUES(#{name}, #{public})
"""

internal const val REPOSITORY_READ = """
 SELECT `id`, `name`, `public`
 FROM repository
 WHERE `name`=#{name}
"""

internal const val REPOSITORY_READ_ALL = """
 SELECT `id`, `name`, `public`
 FROM repository
"""

internal const val REPOSITORY_UPDATE = """
 UPDATE `repository`
 SET `name`=#{name}, `public`=#{public}
 WHERE id=#{id}
"""

internal const val REPOSITORY_DELETE = """
 DELETE FROM repository WHERE `name`=#{name} 
"""