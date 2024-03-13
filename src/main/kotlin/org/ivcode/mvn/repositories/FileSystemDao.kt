package org.ivcode.mvn.repositories

import org.apache.ibatis.annotations.*
import org.ivcode.mvn.repositories.model.FileInfoEntity
import org.ivcode.mvn.repositories.model.FileSystemDirectoryEntity
import org.ivcode.mvn.repositories.model.FileSystemFileEntity
import org.ivcode.mvn.repositories.sql.*
import org.ivcode.mvn.repositories.sql.h2.SELECT_HIERARCHY_H2
import org.ivcode.mvn.repositories.sql.mysql.SELECT_HIERARCHY_MYSQL
import java.io.InputStream


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

    @Select(FILE_SYSTEM_SELECT_PATH)
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

    @Insert(FILE_SYSTEM_CREATE_DIRECTORY_ENTRY)
    @Options(useGeneratedKeys = true, keyProperty = "id", keyColumn = "id")
    public fun createDirectoryEntry(entry: FileSystemDirectoryEntity)

    @Insert(FILE_SYSTEM_CREATE_FILE_ENTRY)
    @Options(useGeneratedKeys = true, keyProperty = "entry.id", keyColumn = "id")
    public fun createFileEntry(entry: FileSystemFileEntity, data: InputStream)

    @Select(FILE_SYSTEM_READ_ENTRY)
    @Result(property = "id", column = "ID")
    @Result(property = "repositoryId", column = "REPOSITORY_ID")
    @Result(property = "parentId", column = "PARENT_ID")
    @Result(property = "name", column = "NAME")
    @Result(property = "directory", column = "DIRECTORY")
    @Result(property = "lastModified", column = "LAST_MODIFIED")
    @Result(property = "mime", column = "MIME")
    public fun readEntry(id: Long): FileInfoEntity?


    @Select(FILE_SYSTEM_READ_DATA)
    public fun readData(id: Long): InputStream?

    /**
     * Returns all folders based of the given
     */
    @Select(FILE_SYSTEM_READ_CHILDREN)
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
    @Select(FILE_SYSTEM_READ_ROOT)
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
    @Select(FILE_SYSTEM_IS_EMPTY_DIRECTORY)
    public fun isEmpty(id: Long): Boolean

    @Update(FILE_SYSTEM_UPDATE_FILE_ENTRY)
    public fun updateFileEntry(entry: FileSystemFileEntity, data: InputStream): Int

    /**
     * Deletes the given folder.
     * Warning: This is a cascading call. All children will be deleted too
     */
    @Delete(FILE_SYSTEM_DELETE)
    public fun deleteFileSystemEntry(id: Long): Int

    @Delete(FILE_SYSTEM_DELETE_ROOT)
    public fun deleteRoot(repositoryId: Long): Int
}
