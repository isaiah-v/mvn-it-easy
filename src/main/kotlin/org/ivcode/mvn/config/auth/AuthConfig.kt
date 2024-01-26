package org.ivcode.mvn.config.auth

import jakarta.servlet.http.HttpServletResponse
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
        @Value("\${mvn.auth.public.snapshot}") isSnapshotPublic: Boolean,
        @Value("\${mvn.auth.public.release}") isReleasePublic: Boolean,
    ): SecurityFilterChain {

        http.authenticationManager(authenticationManager)

        http {
            authorizeHttpRequests {
                // Snapshot
                authorize(HttpMethod.POST, "/snapshot/**", hasAuthority(BasicAuthRole.ADMIN.roleName()))
                authorize(HttpMethod.PUT, "/snapshot/**", hasAuthority(BasicAuthRole.ADMIN.roleName()))
                authorize(HttpMethod.PATCH, "/snapshot/**", hasAuthority(BasicAuthRole.ADMIN.roleName()))
                authorize(HttpMethod.DELETE, "/snapshot/**", hasAuthority(BasicAuthRole.ADMIN.roleName()))
                authorize("/snapshot/**", if(isSnapshotPublic) permitAll else authenticated)

                // Release
                authorize(HttpMethod.POST, "/release/**", hasAuthority(BasicAuthRole.ADMIN.roleName()))
                authorize(HttpMethod.PUT, "/release/**", hasAuthority(BasicAuthRole.ADMIN.roleName()))
                authorize(HttpMethod.PATCH, "/release/**", hasAuthority(BasicAuthRole.ADMIN.roleName()))
                authorize(HttpMethod.DELETE, "/release/**", hasAuthority(BasicAuthRole.ADMIN.roleName()))
                authorize("/release/**", if(isReleasePublic) permitAll else authenticated)

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