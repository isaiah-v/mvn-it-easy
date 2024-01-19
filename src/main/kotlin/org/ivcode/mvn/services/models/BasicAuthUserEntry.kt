package org.ivcode.mvn.services.models

public data class BasicAuthUserEntry (
    val username: String,
    val role: BasicAuthRole,
    val hashcode: String,
) {
    public companion object {}
    override fun toString(): String = "${username}:${role.roleName()}:${hashcode}"
}