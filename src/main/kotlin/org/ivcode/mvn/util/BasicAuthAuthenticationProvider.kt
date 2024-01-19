package org.ivcode.mvn.util

import org.ivcode.mvn.services.BasicAuthService
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

        val basicAuth = basicAuthService.authorize(username, password)
        return if(basicAuth.isAuthorized) {
            val authorities = basicAuth.roles.map { role -> SimpleGrantedAuthority(role.roleName()) }
            UsernamePasswordAuthenticationToken(username, password, authorities)
        } else {
            null
        }
    }

    override fun supports(authentication: Class<*>): Boolean {
        return authentication == UsernamePasswordAuthenticationToken::class.java
    }
}