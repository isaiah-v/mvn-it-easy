package org.ivcode.mvn.util

import org.ivcode.mvn.services.auth.models.MVN_READ_AUTHORITIES
import org.springframework.security.core.context.SecurityContextHolder

public fun getAuthorities(): List<String> = SecurityContextHolder
    .getContext()
    .authentication
    .authorities
    .map { it.authority }
public fun hasMvnReadAccess(): Boolean =
    getAuthorities().any { MVN_READ_AUTHORITIES.contains(it) }
