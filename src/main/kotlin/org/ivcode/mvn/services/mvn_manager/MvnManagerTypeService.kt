package org.ivcode.mvn.services.mvn_manager

import org.ivcode.mvn.services.mvn_manager.models.RepositoryInfo
import org.ivcode.mvn.services.mvn_manager.models.RepositoryType

public interface MvnManagerTypeService {
    public val type: RepositoryType
    public fun deleteRepository(info: RepositoryInfo)
    public fun createRepository(info: RepositoryInfo)
    public fun updateRepository(old: RepositoryInfo, new: RepositoryInfo)
}