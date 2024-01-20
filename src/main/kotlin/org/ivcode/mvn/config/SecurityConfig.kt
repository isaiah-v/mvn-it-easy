package org.ivcode.mvn.config

import org.ivcode.mvn.services.BasicAuthService
import org.ivcode.mvn.services.models.BasicAuthRole
import org.ivcode.mvn.util.BasicAuthAuthenticationProvider
import org.springframework.beans.factory.annotation.Value
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.http.HttpMethod
import org.springframework.security.authentication.AuthenticationManager
import org.springframework.security.authentication.AuthenticationProvider
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity
import org.springframework.security.config.annotation.web.invoke
import org.springframework.security.core.Authentication
import org.springframework.security.web.SecurityFilterChain


@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public fun createAuthenticationManager(
        http: HttpSecurity,
        basicAuthService: BasicAuthService
    ): AuthenticationManager = http
        .getSharedObject(AuthenticationManagerBuilder::class.java)
        .authenticationProvider(BasicAuthAuthenticationProvider(basicAuthService))
        .build()


    @Bean
    public fun securityFilterChain(
        http: HttpSecurity,
        authenticationManager: AuthenticationManager,
        @Value("\${mvn.public}") isPublic: Boolean,
    ): SecurityFilterChain {

        http.authenticationManager(authenticationManager)

        http {
            authorizeHttpRequests {
                authorize(HttpMethod.POST, "*/**", hasAuthority(BasicAuthRole.ADMIN.roleName()))
                authorize(HttpMethod.PUT, "*/**", hasAuthority(BasicAuthRole.ADMIN.roleName()))
                authorize(HttpMethod.PATCH, "*/**", hasAuthority(BasicAuthRole.ADMIN.roleName()))
                authorize(HttpMethod.DELETE, "*/**", hasAuthority(BasicAuthRole.ADMIN.roleName()))
                authorize(anyRequest, if(isPublic) permitAll else authenticated)
            }
            httpBasic { }
            // mvn's upload process looks like a cross-site request forgery. It needs to be disabled.
            csrf { disable() }
        }

        return http.build()
    }
}