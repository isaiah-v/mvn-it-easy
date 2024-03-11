package org.ivcode.mvn.security

import org.springframework.security.authentication.AuthenticationManager
import org.springframework.security.core.Authentication
import org.springframework.security.core.authority.SimpleGrantedAuthority
import org.springframework.security.oauth2.jwt.JwtDecoder
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationProvider
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken

/**
 * A jwt [AuthenticationManager]
 * This uses spring's jwt validation but adds logic for assigning additional authorities
 */
public class JwtAuthenticationManager (
    jwtDecoder: JwtDecoder,
    private val admins: List<String>
): AuthenticationManager {

    private val provider: JwtAuthenticationProvider = JwtAuthenticationProvider(jwtDecoder)

    override fun authenticate(authentication: Authentication?): Authentication {
        val auth = provider.authenticate(authentication) as JwtAuthenticationToken
        val authorities = auth.authorities.toMutableList()

        val email = auth.token.getClaim<String>("email")
        if(email!=null && admins.contains(email)) {
            authorities.add(SimpleGrantedAuthority(Role.ADMIN.roleName()))
        } else {
            authorities.add(SimpleGrantedAuthority(Role.USER.roleName()))
        }

        return JwtAuthenticationToken (
            auth.token,
            authorities,
            auth.name
        )
    }

}