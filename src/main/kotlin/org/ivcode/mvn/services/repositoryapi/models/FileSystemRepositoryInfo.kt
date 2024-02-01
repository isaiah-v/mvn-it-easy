package org.ivcode.mvn.services.repositoryapi.models

public data class FileSystemRepositoryInfo(
    override val id: String,
    override val public: Boolean,
): RepositoryInfo {
    override val type: RepositoryType = RepositoryType.FILE_SYSTEM
}