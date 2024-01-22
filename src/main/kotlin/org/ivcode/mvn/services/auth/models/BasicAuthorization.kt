package org.ivcode.mvn.services.auth.models

public data class BasicAuthorization (
    val isAuthorized: Boolean,
    val username: String,
    val roles: List<BasicAuthRole>
)
