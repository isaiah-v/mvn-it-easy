package org.ivcode.mvn.config.auth

import org.ivcode.mvn.services.auth.BasicAuthService
import org.ivcode.mvn.services.auth.models.BasicAuthRole
import org.ivcode.mvn.security.BasicAuthAuthenticationProvider
import org.springframework.beans.factory.annotation.Value
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.http.HttpMethod
import org.springframework.security.authentication.AuthenticationManager
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity
import org.springframework.security.config.annotation.web.invoke
import org.springframework.security.web.SecurityFilterChain


@Configuration
@EnableWebSecurity
public class AuthConfig {

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
        @Value("\${mvn.auth.public}") isPublic: Boolean,
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

            // maven's upload process looks like a cross-site request forgery. It needs to be disabled.
            csrf { disable() }
        }

        return http.build()
    }
}