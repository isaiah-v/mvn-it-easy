package org.ivcode.mvn.services.repositoryapi

import org.ivcode.mvn.exceptions.BadRequestException
import org.ivcode.mvn.exceptions.InternalServerErrorException
import org.ivcode.mvn.services.repositoryapi.models.RepositoryInfo
import org.ivcode.mvn.services.repositoryapi.models.RepositoryType
import org.ivcode.mvn.util.deleteRecursively
import org.ivcode.mvn.util.full
import java.nio.file.Files
import java.nio.file.Path
import kotlin.io.path.createDirectories
import kotlin.io.path.exists
import kotlin.io.path.isDirectory

public class RepositoryServiceFileSystem(
    private val mvnRoot: Path
): RepositoryService {
    override fun deleteRepository(info: RepositoryInfo) {
        val path = info.getAbsolutePath()
        if(!path.isDirectory()) {
            throw InternalServerErrorException()
        }

        path.deleteRecursively()
    }

    override fun createRepository(info: RepositoryInfo) {
        val path = info.getAbsolutePath()
        if(path.exists()) {
            // The given path cannot already exist
            throw BadRequestException()
        }

        path.createDirectories()
    }

    override fun updateRepository(old: RepositoryInfo, new: RepositoryInfo) {
        if(old == new) {
            return
        }
        if(old.type!=RepositoryType.FILE_SYSTEM || new.type!=RepositoryType.FILE_SYSTEM) {
            throw InternalServerErrorException()
        }
        if(old.id != new.id) {
            updateRepositoryPath(old.getAbsolutePath(), new.getAbsolutePath())
        }
    }

    private fun updateRepositoryPath(oldPath: Path, newPath: Path) {
        if(!oldPath.isDirectory()) {
            // The existing directory must be a directory
            throw BadRequestException()
        }
        if(newPath.exists()) {
            // The new path cannot already exist
            throw BadRequestException()
        }

        Files.move(oldPath, newPath)
    }

    private fun RepositoryInfo.getAbsolutePath(): Path =
        mvnRoot.resolve(this.id).full()
}