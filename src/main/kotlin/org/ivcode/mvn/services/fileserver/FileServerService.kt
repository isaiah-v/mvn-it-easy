package org.ivcode.mvn.services.fileserver

import org.ivcode.mvn.services.fileserver.models.ResourceInfo
import org.ivcode.mvn.services.repositoryapi.models.RepositoryInfo
import java.io.InputStream
import java.io.OutputStream
import java.nio.file.Path

public interface FileServerService {

    /**
     * Get resource / directory information
     *
     * @param path path to resource
     *
     * @throws org.ivcode.mvn.exceptions.NotFoundException if the resource or directory doesn't exist
     * @throws org.ivcode.mvn.exceptions.ForbiddenException if the path isn't allowed
     */
    public fun getPathInfo(repo: RepositoryInfo, path: Path): ResourceInfo

    /**
     * Write the contents of the resource to the given output stream
     *
     * @param resourceInfo file/directory info
     * @param out the stream to write to
     *
     * @throws org.ivcode.mvn.exceptions.NotFoundException if the resource doesn't exist or if it's a directory
     * @throws org.ivcode.mvn.exceptions.ForbiddenException if the path isn't allowed
     */
    public fun get(repo: RepositoryInfo, resourceInfo: ResourceInfo, out: OutputStream)

    /**
     * Writes the given resource to the input stream
     *
     * @param path path to resource
     * @param input stream to write resource data to
     *
     * @throws org.ivcode.mvn.exceptions.ConflictException if the resource already exists
     * @throws org.ivcode.mvn.exceptions.ForbiddenException if the path isn't allowed
     */
    public fun post(repo: RepositoryInfo, path: Path, input: InputStream)

    /**
     * Writes the given resource to the input stream, overwriting the current resource if
     * necessary
     *
     * @param path path to resource
     * @param input stream to write resource data to
     *
     * @throws org.ivcode.mvn.exceptions.ForbiddenException if the path isn't allowed
     */
    public fun put(repoInfo: RepositoryInfo, path: Path, input: InputStream)

    /**
     * Deletes a given resource
     *
     * @param path path to resource
     * @throws org.ivcode.mvn.exceptions.ForbiddenException if the path isn't allowed
     */
    public fun delete(repoInfo: RepositoryInfo, path: Path)
}