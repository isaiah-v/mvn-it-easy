package org.ivcode.mvn.util

import org.springframework.security.core.context.SecurityContextHolder


public fun getAuthorities(): List<String> = SecurityContextHolder
    .getContext()
    .authentication
    .authorities
    .map { it.authority }

public fun isAnonymous(): Boolean {
    val auths = getAuthorities()
    return auths.contains("ROLE_ANONYMOUS")
}
