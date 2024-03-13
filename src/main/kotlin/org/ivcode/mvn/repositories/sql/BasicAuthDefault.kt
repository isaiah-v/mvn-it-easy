package org.ivcode.mvn.repositories.sql

internal const val BASIC_AUTH_CREATE = """
 INSERT INTO basic_auth (`username`, `write`, `salt`, `hash`)
 VALUES(#{username}, #{write}, #{salt}, #{hash})
"""

internal const val BASIC_AUTH_READ = """
 SELECT * FROM basic_auth WHERE `username`=#{username}
"""

internal const val BASIC_AUTH_READ_ALL = """
 SELECT * FROM basic_auth
"""

internal const val BASIC_AUTH_UPDATE = """
 UPDATE basic_auth
 SET `username`=#{username}, `write`=#{write}, `salt`=#{salt}, `hash`=#{hash}
 WHERE `id`=#{id}
"""

internal const val BASIC_AUTH_DELETE = """
 DELETE FROM basic_auth
 WHERE `id`=#{id}
"""

internal const val BASIC_AUTH_DELETE_BY_USERNAME = """
 DELETE FROM basic_auth
 WHERE `username`=#{username}
"""