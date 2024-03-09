package org.ivcode.mvn.services.basicauth

public data class BasicAuthUser (
    val username: String,
    val write: Boolean
)

public data class CreateBasicAuthUser (
    val username: String,
    val password: String,
    val write: Boolean
)
