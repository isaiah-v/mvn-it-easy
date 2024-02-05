package org.ivcode.mvn.services.mvn_manager.models

import com.fasterxml.jackson.databind.annotation.JsonDeserialize

@JsonDeserialize(using = RepositoryInfoDeserializer::class)
public interface RepositoryInfo {
    public val type: RepositoryType
    public val id: String
    public val public: Boolean
}
