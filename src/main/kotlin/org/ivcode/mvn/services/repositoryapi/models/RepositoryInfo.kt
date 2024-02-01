package org.ivcode.mvn.services.repositoryapi.models

public interface RepositoryInfo {
    public val type: RepositoryType
    public val id: String
    public val public: Boolean
}
