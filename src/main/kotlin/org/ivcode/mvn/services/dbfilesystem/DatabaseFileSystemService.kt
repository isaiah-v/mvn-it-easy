package org.ivcode.mvn.services.dbfilesystem

import org.ivcode.mvn.exceptions.ConflictException
import org.ivcode.mvn.exceptions.InternalServerErrorException
import org.ivcode.mvn.exceptions.NotFoundException
import org.ivcode.mvn.repositories.FileSystemDao
import org.ivcode.mvn.repositories.RepositoryDao
import org.ivcode.mvn.repositories.model.FileInfoEntity
import org.ivcode.mvn.repositories.model.FileSystemDirectoryEntity
import org.ivcode.mvn.repositories.model.FileSystemFileEntity
import org.ivcode.mvn.services.dbfilesystem.models.DirectoryChildInfo
import org.ivcode.mvn.services.dbfilesystem.models.DirectoryInfo
import org.ivcode.mvn.services.dbfilesystem.models.RepositoryInfo
import org.ivcode.mvn.services.dbfilesystem.models.PathInfo
import org.springframework.http.MediaType
import org.springframework.stereotype.Component
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Propagation
import org.springframework.transaction.annotation.Transactional
import java.io.InputStream
import java.io.OutputStream
import java.net.URI
import java.nio.file.*
import kotlin.io.path.*

/**
 * File-System based maven repository
 */
@Service
public class DatabaseFileSystemService (
    private val repositoryDto: RepositoryDao,
    private val fileSystemDto: FileSystemDao
) {
    private val root: Path = Path("")

    @Transactional(propagation = Propagation.SUPPORTS)
    public fun getRepositoryInfo(name: String): RepositoryInfo {
        val entity = repositoryDto.readRepository(name) ?: throw NotFoundException()
        return RepositoryInfo(
            id = entity.id!!,
            name = entity.name!!,
            public = entity.public!!,
        )
    }

    @Transactional(propagation = Propagation.SUPPORTS)
    public fun getResourceInfo(repoInfo: RepositoryInfo, path: Path): PathInfo {
        if(path.isRoot()) {
            return PathInfo (
                repositoryInfo = repoInfo,
                path = path,
                name = "",
                isDirectory = true,
                isRoot = true,
            )
        }

        val pathArray: Array<String?> = path.toList().toTypedArray()
        val fsEntity = fileSystemDto.getPath(repoInfo.id, pathArray) ?: throw NotFoundException()
        return PathInfo (
            repositoryInfo = repoInfo,
            entryId = fsEntity.id,
            parentEntryId = fsEntity.parentId,
            path = path,
            name = fsEntity.name!!,
            mimeType = fsEntity.mime,
            isDirectory = fsEntity.directory!!,
            lastModified = fsEntity.lastModified,
            size = fsEntity.size
        )
    }

    @Transactional(propagation = Propagation.SUPPORTS)
    public fun getDirectoryInfo(pathInfo: PathInfo): DirectoryInfo {
        val childEntities = if(pathInfo.isRoot) {
            fileSystemDto.readRoot(pathInfo.repositoryInfo.id)
        } else {
            fileSystemDto.readChildren(pathInfo.entryId!!)
        }

        return DirectoryInfo (
            uri = createURI(pathInfo),
            path = pathInfo.path,
            name = pathInfo.name,
            isRoot = pathInfo.isRoot,
            children = childEntities.toChildInfo(pathInfo),
        )
    }

    @Transactional(propagation = Propagation.SUPPORTS)
    public fun get(pathInfo: PathInfo, out: OutputStream) {
        if(pathInfo.entryId==null) {
            throw NotFoundException()
        }
        val data = fileSystemDto.readData(pathInfo.entryId) ?: throw InternalServerErrorException()

        data.use {
            it.transferTo(out)
        }
    }

    @Transactional(propagation = Propagation.MANDATORY)
    public fun post(repo: RepositoryInfo, path: Path, data: InputStream) {
        if(path.isRoot()) {
            throw ConflictException()
        }

        val pathArray: Array<String?> = path.toList().toTypedArray()
        val entries = fileSystemDto.getHierarchy(repo.id, pathArray)


        if(pathArray.size == entries.size) {
            // If the size is the same, then the file already exists.
            throw ConflictException()
        }

        var parentId:Long? = null
        // make sure the path exists
        for(i in 0..<pathArray.size-1) {
            val name = pathArray[i]
            val entry = if (entries.size>i) entries[i] else null

            if(entry!=null) {
                // set parent id for next iteration
                parentId = entry.id
            } else {
                val e = FileSystemDirectoryEntity(
                    repositoryId = repo.id,
                    parentId = parentId,
                    name = name
                )
                fileSystemDto.createDirectoryEntry(e)

                // set parent id for next iteration
                parentId = e.id!!
            }
        }

        fileSystemDto.createFileEntry(FileSystemFileEntity(
            repositoryId = repo.id,
            parentId = parentId,
            name = path.name,
            mime = getMime(path)
        ), data)
    }

    @Transactional(propagation = Propagation.MANDATORY)
    public fun put(repo: RepositoryInfo, path: Path, data: InputStream) {
        if(path.isRoot()) {
            throw ConflictException()
        }

        val pathArray: Array<String?> = path.toList().toTypedArray()
        val entries = fileSystemDto.getHierarchy(repo.id, pathArray)


        if(pathArray.size == entries.size) {
            // If the size is the same, then the file already exists.

            val entity = entries[pathArray.size-1]
            if(entity.directory == true) {
                // The user is trying to overwrite a directory with a file
                throw ConflictException()
            }

            fileSystemDto.updateFileEntry(FileSystemFileEntity(
                repositoryId = entity.id,
                parentId = entity.parentId,
                name = entity.name,
                mime = entity.mime
            ), data)

            return
        }

        var parentId:Long? = null
        // make sure the path exists
        for(i in 0..<pathArray.size-1) {
            val name = pathArray[i]
            val entry = if (entries.size>i) entries[i] else null

            if(entry!=null) {
                // set parent id for next iteration
                parentId = entry.id
            } else {
                val e = FileSystemDirectoryEntity(
                    repositoryId = repo.id,
                    parentId = parentId,
                    name = name
                )
                fileSystemDto.createDirectoryEntry(e)

                // set parent id for next iteration
                parentId = e.id!!
            }
        }

        fileSystemDto.createFileEntry(FileSystemFileEntity(
            repositoryId = repo.id,
            parentId = parentId,
            name = path.name,
            mime = getMime(path)
        ), data)
    }

    @Transactional(propagation = Propagation.MANDATORY)
    public fun delete(pathInfo: PathInfo) {
        if(pathInfo.isRoot) {
            fileSystemDto.deleteRoot(pathInfo.repositoryInfo.id)
        } else {
            fileSystemDto.deleteFileSystemEntry(pathInfo.entryId!!)
            deleteIfEmpty(pathInfo.parentEntryId)
        }
    }

    /**
     * Iterates the up the path, deleting directories if empty.
     */
    private fun deleteIfEmpty(entryId: Long?) {
        if(entryId==null) {
            return
        }

        val entry = fileSystemDto.readEntry(entryId) ?: return
        if(entry.directory == true && fileSystemDto.isEmpty(entryId)) {
            fileSystemDto.deleteFileSystemEntry(entryId)
            deleteIfEmpty(entry.parentId)
        }
    }

    private fun List<FileInfoEntity>.toChildInfo(pathInfo: PathInfo): List<DirectoryChildInfo> =
        map { it.toChildInfo(pathInfo) }

    private fun FileInfoEntity.toChildInfo(pathInfo: PathInfo): DirectoryChildInfo = DirectoryChildInfo(
        isDirectory = directory!!,
        name = name!!,
        path = pathInfo.path.resolve(this.name!!),
        uri = createURI(pathInfo, this.name),
        lastModified = lastModified,
        size = size
    )

    private fun createURI(pathInfo: PathInfo, childName: String? = null): URI {
        val p = if (childName==null) {
            pathInfo.path
        } else {
            pathInfo.path.resolve(childName)
        }

        return URI.create("/mvn/${pathInfo.repositoryInfo.name}/${p}")
    }

    private fun Path.isRoot(): Boolean =
        equals(this@DatabaseFileSystemService.root)

    private fun Path.toList() =
        map { p -> p.name }

    /**
     * Returns the Mime for the given file. If the file is a directory, `null` is returned
     */
    private fun getMime(file: Path): String? {
        if(file.isDirectory()) {
            return null
        }

        return when(file.extension.lowercase()) {
            "xml", "pom" ->
                MediaType.TEXT_XML_VALUE
            "md5", "sha1", "sha256", "sha512" ->
                MediaType.TEXT_PLAIN_VALUE
            else ->
                MediaType.APPLICATION_OCTET_STREAM_VALUE
        }
    }
}