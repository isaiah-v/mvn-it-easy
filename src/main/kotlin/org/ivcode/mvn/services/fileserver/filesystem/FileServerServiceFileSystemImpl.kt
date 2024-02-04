package org.ivcode.mvn.services.fileserver.filesystem

import org.ivcode.mvn.exceptions.ConflictException
import org.ivcode.mvn.exceptions.ForbiddenException
import org.ivcode.mvn.exceptions.NotFoundException
import org.ivcode.mvn.services.fileserver.FileServerService
import org.ivcode.mvn.services.fileserver.models.ResourceChildInfo
import org.ivcode.mvn.services.fileserver.models.ResourceInfo
import org.ivcode.mvn.services.mvn_manager.models.RepositoryInfo
import org.ivcode.mvn.services.mvn_manager.models.RepositoryType
import org.ivcode.mvn.util.*
import org.ivcode.mvn.util.deleteRecursively
import org.springframework.beans.factory.annotation.Value
import org.springframework.http.MediaType
import org.springframework.stereotype.Component
import java.io.InputStream
import java.io.OutputStream
import java.net.URI
import java.nio.file.*
import kotlin.io.path.*

/**
 * File-System based maven repository
 */
@Component
public class FileServerServiceFileSystemImpl (
    @Value("\${mvn.repositories.file-system.path}") mvnRoot: Path
) : FileServerService {

    public override val type: RepositoryType = RepositoryType.FILE_SYSTEM

    private val root: Path = mvnRoot.full()

    init {
        if(!root.exists()) {
            root.createDirectories()
        }
    }

    override fun getPathInfo(repo: RepositoryInfo, path: Path): ResourceInfo {
        val repoRoot = root.resolve(repo.id)
        val resolvedPath = repoRoot.resolve(path).full()
        checkFile(repo, resolvedPath)

        if(!resolvedPath.exists()) {
            throw NotFoundException()
        }

        return ResourceInfo(
            uri = createUri(resolvedPath),
            path = path,
            name = resolvedPath.name,
            mimeType = getMime(resolvedPath),
            isDirectory = resolvedPath.isDirectory(),
            isRoot = resolvedPath.isSameFileAs(repoRoot),
            children = getChildInfo(resolvedPath)
        )
    }

    override fun get(repo: RepositoryInfo, resourceInfo: ResourceInfo, out: OutputStream) {
        val repoRoot = root.resolve(repo.id)
        val resolvedPath = repoRoot.resolve(resourceInfo.path).full()
        checkFile(repo, resolvedPath)

        resolvedPath.inputStream().use {
            it.transferTo(out)
            out.flush()
        }
    }

    override fun post(repo: RepositoryInfo, path: Path, input: InputStream) {
        val repoRoot = root.resolve(repo.id)
        val resolvedPath = repoRoot.resolve(path).full()
        checkFile(repo, resolvedPath)

        if(resolvedPath.exists()) {
            throw ConflictException()
        }

        resolvedPath.createParentDirectories()

        resolvedPath.outputStream().use { out ->
            input.transferTo(out)
            out.flush()
        }
    }

    override fun put(repo: RepositoryInfo, path: Path, input: InputStream) {
        val repoRoot = root.resolve(repo.id)
        val resolvedPath = repoRoot.resolve(path).full()
        checkFile(repo, resolvedPath)

        resolvedPath.createParentDirectories()
        resolvedPath.outputStream().use { out ->
            input.transferTo(out)
            out.flush()
        }
    }

    override fun delete(repo: RepositoryInfo, path: Path) {
        val repoRoot = root.resolve(repo.id)
        val resolvedPath = repoRoot.resolve(path).full()
        checkFile(repo, resolvedPath)

        if(!resolvedPath.exists()) {
            throw NotFoundException()
        }

        if(resolvedPath.isSameFileAs(repoRoot)) {
            throw ForbiddenException()
        }


        if(resolvedPath.isRegularFile()) {
            // delete file

            if(!resolvedPath.parent.isSameFileAs(repoRoot)) {
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

    /**
     * @param repo repository info
     * @param path the path with the repo
     * @param resolvePath the file-system's absolute path
     */
    private fun getChildInfo(resolvePath: Path): List<ResourceChildInfo>? {
        if(!resolvePath.isDirectory()) {
            return null
        }

        val children = mutableListOf<ResourceChildInfo>()

        resolvePath.listChildren().forEach { child ->
            children.add(
                ResourceChildInfo(
                    uri = createUri(resolvePath, child.name),
                    path = resolvePath.resolve(child.name),
                    name = child.name,
                    isDirectory = child.isDirectory()
                )
            )
        }

        return children.toList()
    }

    /**
     * @param resolvePath the absolut file-path
     */
    private fun createUri(resolvePath: Path, childName: String?=null): URI {
        val p = if (childName==null) {
            resolvePath.relativeTo(root)
        } else {
            resolvePath.resolve(childName).relativeTo(root)
        }

        return URI.create("/mvn/${p}")
    }

    /**
     * Returns the Mime for the given file. If the file is a directory, `null` is returned
     */
    private fun getMime(file: Path): MediaType? {
        if(file.isDirectory()) {
            return null
        }

        return when(file.extension.lowercase()) {
            "xml", "pom" ->
                MediaType.TEXT_XML
            "md5", "sha1", "sha256", "sha512" ->
                MediaType.TEXT_PLAIN
            else ->
                MediaType.APPLICATION_OCTET_STREAM
        }

    }

    /**
     * Runs verification against the file to make sure the user isn't trying
     * access anything outside the mvn folder
     */
    private fun checkFile(repoInfo: RepositoryInfo, path: Path) {
        val repoDir = root.resolve(repoInfo.id)
        if(!path.isSubdirectoryOf(repoDir)) {
            // users cannot access information outside the maven directory
            throw ForbiddenException()
        }
        if(path.isSymbolicLink()) {
            // supporting symbolic links poses some security concerns
            throw ForbiddenException()
        }
    }
}