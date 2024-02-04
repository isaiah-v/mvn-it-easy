package org.ivcode.mvn.controllers

import org.ivcode.mvn.exceptions.BadRequestException
import org.ivcode.mvn.services.mvn_manager.MvnManagerService
import org.ivcode.mvn.services.mvn_manager.models.FileSystemRepositoryInfo
import org.ivcode.mvn.services.mvn_manager.models.RepositoryInfo
import org.ivcode.mvn.services.mvn_manager.models.RepositoryType
import org.springframework.web.bind.annotation.DeleteMapping
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping(path = ["/api/mvn"])
public class MvnRepositoryManagerController(
    private val manager: MvnManagerService
) {

    @PostMapping
    public fun createFileSystemRepo(repoInfo: FileSystemRepositoryInfo) {
        repoInfo.assertType(RepositoryType.FILE_SYSTEM)
        return manager.createRepository(repoInfo)
    }

    @GetMapping
    public fun getRepos(): List<RepositoryInfo> = manager.getRepositories()

    @DeleteMapping(path = ["/{id}"])
    public fun deleteRepo(
        @PathVariable id: String
    ) {
        manager.deleteRepository(id)
    }

    private fun RepositoryInfo.assertType(type: RepositoryType) {
        if(this.type!=type) {
            throw BadRequestException()
        }
    }
}