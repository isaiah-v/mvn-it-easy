package org.ivcode.mvn.repositories.model

public data class BasicAuthEntity (
    public val id: Long? = null,
    public val username: String? = null,
    public val write: Boolean? = null,
    public val salt: String? = null,
    public val hash: String? = null,
)
