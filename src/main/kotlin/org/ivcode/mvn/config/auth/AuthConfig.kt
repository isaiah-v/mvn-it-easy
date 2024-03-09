package org.ivcode.mvn.config.auth

import org.ivcode.mvn.security.BasicAuthAuthenticationProvider
import org.ivcode.mvn.security.API_READ_ROLE_AUTHORITIES
import org.ivcode.mvn.security.API_WRITE_ROLE_AUTHORITIES
import org.ivcode.mvn.services.basicauth.BasicAuthService
import org.ivcode.mvn.security.MVN_WRITE_ROLE_AUTHORITIES
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
    ): SecurityFilterChain {
        http.authenticationManager(authenticationManager)

        http {
            authorizeHttpRequests {
                // Maven
                // Note: The responsibility of determining of someone has read access to given repo is determined by the controller
                val mvnWriteAuthorities = MVN_WRITE_ROLE_AUTHORITIES.toTypedArray()
                authorize(HttpMethod.POST, "/mvn/**", hasAnyAuthority(*mvnWriteAuthorities))
                authorize(HttpMethod.PUT, "/mvn/**", hasAnyAuthority(*mvnWriteAuthorities))
                authorize(HttpMethod.PATCH, "/mvn/**", hasAnyAuthority(*mvnWriteAuthorities))
                authorize(HttpMethod.DELETE, "/mvn/**", hasAnyAuthority(*mvnWriteAuthorities))
                authorize("/mvn/**", permitAll)

                // API
                val apiReadAuthorities = API_READ_ROLE_AUTHORITIES.toTypedArray()
                val apiWriteAuthorities = API_WRITE_ROLE_AUTHORITIES.toTypedArray()
                authorize(HttpMethod.POST, "/mvn/**", hasAnyAuthority(*apiWriteAuthorities))
                authorize(HttpMethod.PUT, "/mvn/**", hasAnyAuthority(*apiWriteAuthorities))
                authorize(HttpMethod.PATCH, "/mvn/**", hasAnyAuthority(*apiWriteAuthorities))
                authorize(HttpMethod.DELETE, "/mvn/**", hasAnyAuthority(*apiWriteAuthorities))
                authorize(HttpMethod.GET, "/mvn/**", hasAnyAuthority(*apiReadAuthorities))
                authorize("/mvn/**", permitAll)

                // Other
                authorize("**", permitAll)
            }
            httpBasic { }

            // maven's upload process looks like a cross-site request forgery. It needs to be disabled.
            csrf { disable() }
        }

        return http.build()
    }
}