package org.ivcode.mvn.services.models

public data class BasicAuthorization (
    val isAuthorized: Boolean,
    val username: String,
    val roles: List<BasicAuthRole>
)
