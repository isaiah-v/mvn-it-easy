package org.ivcode.mvn.services.fileserver.filesystem

import org.ivcode.mvn.exceptions.ConflictException
import org.ivcode.mvn.exceptions.ForbiddenException
import org.ivcode.mvn.exceptions.NotFoundException
import org.ivcode.mvn.services.fileserver.FileServerService
import org.ivcode.mvn.services.fileserver.models.ResourceChildInfo
import org.ivcode.mvn.services.fileserver.models.ResourceInfo
import org.ivcode.mvn.util.*
import org.ivcode.mvn.util.deleteRecursively
import org.springframework.beans.factory.annotation.Value
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty
import org.springframework.http.MediaType
import org.springframework.stereotype.Service
import java.io.InputStream
import java.io.OutputStream
import java.nio.file.*
import kotlin.io.path.*

/**
 * File-System based maven repository
 */
@Service
@ConditionalOnProperty(value = ["mvn.file-server.type"], havingValue = "file-system", matchIfMissing = false)
public class FileServerServiceFileSystemImpl (
    @Value("\${mvn.file-server.file-system.repository}") mvnRoot: Path
) : FileServerService {
    private final val root: Path = mvnRoot.full()

    init {
        if(!root.exists()) {
            root.createDirectories()
        }
    }

    override fun getPathInfo(path: Path): ResourceInfo {
        val resolvedPath = root.resolve(path).full()
        checkFile(resolvedPath)

        if(!resolvedPath.exists()) {
            throw NotFoundException()
        }

        return ResourceInfo(
            path = root.relativize(resolvedPath),
            name = resolvedPath.name,
            mimeType = getMime(resolvedPath),
            isDirectory = resolvedPath.isDirectory(),
            isRoot = resolvedPath.isSameFileAs(root),
            children = getChildInfo(resolvedPath)
        )
    }

    override fun get(resourceInfo: ResourceInfo, out: OutputStream) {
        val path = root.resolve(resourceInfo.path).full()
        checkFile(path)

        path.inputStream().use {
            it.transferTo(out)
            out.flush()
        }
    }

    override fun post(path: Path, input: InputStream) {
        val resolvedPath = root.resolve(path).full()
        checkFile(resolvedPath)

        if(resolvedPath.exists()) {
            throw ConflictException()
        }

        resolvedPath.createParentDirectories()

        resolvedPath.outputStream().use { out ->
            input.transferTo(out)
            out.flush()
        }
    }

    override fun put(path: Path, input: InputStream) {
        val resolvedPath = root.resolve(path).full()
        checkFile(resolvedPath)

        resolvedPath.createParentDirectories()
        resolvedPath.outputStream().use { out ->
            input.transferTo(out)
            out.flush()
        }
    }

    override fun delete(path: Path) {
        val resolvedPath = root.resolve(path).full()
        checkFile(resolvedPath)

        if(!resolvedPath.exists()) {
            throw NotFoundException()
        }

        if(resolvedPath.isSameFileAs(root)) {
            throw ForbiddenException()
        }


        if(resolvedPath.isRegularFile()) {
            // delete file

            if(!resolvedPath.parent.isSameFileAs(root)) {
                // if the parent directory is empty and not the root directory
                // delete the directory, otherwise delete the file

                val peers = resolvedPath.parent.listChildren().filter {
                    !resolvedPath.isSameFileAs(it)
                }

                if(peers.isEmpty()) {
                    resolvedPath.parent.deleteRecursively()
                } else {
                    resolvedPath.deleteIfExists()
                }
            } else {
                // if the parent is the root directory, only delete the file
                resolvedPath.deleteIfExists()
            }
        } else if(resolvedPath.isDirectory()) {
            // delete directory
            resolvedPath.deleteRecursively()
        } else {
            // TODO error

        }
    }

    private fun getChildInfo(path: Path): List<ResourceChildInfo>? {
        if(!path.isDirectory()) {
            return null
        }

        val children = mutableListOf<ResourceChildInfo>()

        path.listChildren().forEach { child ->
            children.add(
                ResourceChildInfo(
                name = child.name,
                isDirectory = child.isDirectory()
            )
            )
        }

        return children.toList()
    }

    /**
     * Returns the Mime for the given file. If the file is a directory, `null` is returned
     */
    private fun getMime(file: Path): MediaType? {
        return if(file.isDirectory()) {
            null
        } else {
            MediaType.APPLICATION_OCTET_STREAM
        }
    }

    /**
     * Runs verification against the file to make sure the user isn't trying
     * access anything outside the mvn folder
     */
    private fun checkFile(path: Path) {
        if(!path.isSubdirectoryOf(root)) {
            // users cannot access information outside the maven directory
            throw ForbiddenException()
        }
        if(path.isSymbolicLink()) {
            // supporting symbolic links poses some security concerns
            throw ForbiddenException()
        }
    }
}