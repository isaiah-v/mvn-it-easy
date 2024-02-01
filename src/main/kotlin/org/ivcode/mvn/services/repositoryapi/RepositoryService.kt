package org.ivcode.mvn.services.repositoryapi

import org.ivcode.mvn.services.repositoryapi.models.RepositoryInfo

public interface RepositoryService {
    public fun deleteRepository(info: RepositoryInfo)
    public fun createRepository(info: RepositoryInfo)
    public fun updateRepository(old: RepositoryInfo, new: RepositoryInfo)
}