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
) {
    private val typeServiceMap: Map<RepositoryType, MvnManagerTypeService> = managerTypeList.associateBy { it.type }

    init {
        if(typeServiceMap.isEmpty()) {
            throw IllegalArgumentException("type manager map cannot be empty")
        }
    }

    private val repositories = mutableMapOf<String, RepositoryInfo>()

    public fun getRepository(id: String): RepositoryInfo =
        repositories[id] ?: throw NotFoundException()
    public fun getRepositories(): List<RepositoryInfo> =
        repositories.values.sortedBy { it.id }
    public fun deleteRepository(id: String) {
        // Get repo, or 404
        val info = repositories[id] ?: throw NotFoundException()

        // Run the delete logic
        typeServiceMap[info.type]!!.deleteRepository(info)

        // If all is well, drop the repo
        repositories.remove(id)
    }
    public fun createRepository(
        info: RepositoryInfo
    ) {
        if(repositories.containsKey(info.id)) {
            // if the id already exists, no good
            throw ConflictException()
        }

        typeServiceMap[info.type]!!.createRepository(info)
        repositories[info.id] = info
    }
    public fun updateRepository(
        id: String,
        info: RepositoryInfo
    ) {
        // Pull the existing repo or 404
        val oldInfo = repositories[id] ?: throw NotFoundException()

        if(oldInfo.type!=info.type) {
            // the repo type cannot be updated
            throw BadRequestException()
        }

        typeServiceMap[info.type]!!.updateRepository(oldInfo, info)
    }
}