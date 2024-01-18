package org.ivcode.mvn.services.models

public data class BasicAuthUserEntry (
    val username: String,
    val role: String,
    val hashcode: String,
) {
    public companion object {}
    override fun toString(): String = "${username}:${role}:${hashcode}"
}