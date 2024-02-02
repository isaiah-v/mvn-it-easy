package org.ivcode.mvn.util

import org.ivcode.mvn.exceptions.ForbiddenException
import org.springframework.security.core.context.SecurityContextHolder

public fun isAuthenticated(): Boolean =
    SecurityContextHolder.getContext().authentication.isAuthenticated

public fun verifyAuthenticated() {
    if (!isAuthenticated()) {
        throw ForbiddenException()
    }
}