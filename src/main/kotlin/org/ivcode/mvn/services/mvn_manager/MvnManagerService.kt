package org.ivcode.mvn.services.mvn_manager

import org.ivcode.mvn.exceptions.BadRequestException
import org.ivcode.mvn.exceptions.ConflictException
import org.ivcode.mvn.exceptions.NotFoundException
import org.ivcode.mvn.services.mvn_manager.models.RepositoryInfo
import org.ivcode.mvn.services.mvn_manager.models.RepositoryType
import org.springframework.stereotype.Service

@Service
public class MvnManagerService (
    managerTypeList: List<MvnManagerTypeService>,
    public val repositoryInfoManager: RepositoryInfoManager,
) {
    private val typeServiceMap: Map<RepositoryType, MvnManagerTypeService> = managerTypeList.associateBy { it.type }

    init {
        if(typeServiceMap.isEmpty()) {
            throw IllegalArgumentException("type manager map cannot be empty")
        }
    }

    public fun getRepository(id: String): RepositoryInfo =
        repositoryInfoManager.get(id) ?: throw NotFoundException()
    public fun getRepositories(): List<RepositoryInfo> =
        repositoryInfoManager.values().sortedBy { it.id }
    public fun deleteRepository(id: String) {
        // Get repo, or 404
        val info = repositoryInfoManager.get(id) ?: throw NotFoundException()

        // Run the delete logic
        typeServiceMap[info.type]!!.deleteRepository(info)

        // If all is well, drop the repo
        repositoryInfoManager.remove(id)
    }
    public fun createRepository (
        info: RepositoryInfo
    ) {
        if(repositoryInfoManager.containsId(info.id)) {
            // if the id already exists, no good
            throw ConflictException()
        }

        typeServiceMap[info.type]!!.createRepository(info)
        repositoryInfoManager.set(info.id, info)
    }
    public fun updateRepository(
        id: String,
        info: RepositoryInfo
    ) {
        // Pull the existing repo or 404
        val oldInfo = repositoryInfoManager.get(id) ?: throw NotFoundException()

        if(oldInfo.type!=info.type) {
            // the repo type cannot be updated
            throw BadRequestException()
        }

        typeServiceMap[info.type]!!.updateRepository(oldInfo, info)
    }
}