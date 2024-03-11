package org.ivcode.mvn.security

import org.ivcode.mvn.services.basicauth.BasicAuthService
import org.springframework.security.authentication.AuthenticationProvider
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.Authentication
import org.springframework.security.core.authority.SimpleGrantedAuthority


public class BasicAuthAuthenticationProvider (
    private val basicAuthService: BasicAuthService
): AuthenticationProvider {
    override fun authenticate(authentication: Authentication): Authentication? {
        val username = authentication.name
        val password = authentication.credentials.toString()

        val user = basicAuthService.getUser(username, password) ?: return authentication
        val role = if (user.write) {
            Role.MVN_PUBLISHER.roleName()
        } else {
            Role.MVN_USER.roleName()
        }

        val authorities = listOf(SimpleGrantedAuthority(role))
        return UsernamePasswordAuthenticationToken(username, password, authorities)
    }

    override fun supports(authentication: Class<*>): Boolean {
        return authentication == UsernamePasswordAuthenticationToken::class.java
    }
}
