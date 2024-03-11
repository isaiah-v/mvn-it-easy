package org.ivcode.mvn.config.auth

import org.ivcode.mvn.security.*
import org.ivcode.mvn.services.basicauth.BasicAuthService
import org.springframework.beans.factory.annotation.Value
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.http.HttpMethod
import org.springframework.security.authentication.AuthenticationManager
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity
import org.springframework.security.web.SecurityFilterChain
import org.springframework.security.config.annotation.web.invoke
import org.springframework.security.oauth2.jwt.JwtDecoder
import org.springframework.security.oauth2.jwt.JwtDecoders



@Configuration
@EnableWebSecurity
public class AuthConfig {

    @Bean
    public fun createAuthAuthenticationManager(
        http: HttpSecurity,
        basicAuthService: BasicAuthService,
    ): AuthenticationManager = http
        .getSharedObject(AuthenticationManagerBuilder::class.java)
        .authenticationProvider(BasicAuthAuthenticationProvider(basicAuthService))
        .build()


    @Bean
    public fun createJwtDecoder(
        @Value("\${security.oauth2.issuer-url}") issuer: String,
    ): JwtDecoder {
        return JwtDecoders.fromIssuerLocation(issuer)
    }

    @Bean
    public fun securityFilterChain(
        http: HttpSecurity,
        basicAuthMan: AuthenticationManager,
        jwtDecoder: JwtDecoder,
        @Value("\${security.oauth2.admin}") admins: String,
    ): SecurityFilterChain {
        val jwtAuthMan = JwtAuthenticationManager(jwtDecoder, admins.split(","))
        http.authenticationManager(basicAuthMan)

        http {
            authorizeHttpRequests {
                // Maven
                // Note: The responsibility of determining of someone has read access to given repo is determined by the
                // controller because repositories can be public or private
                val mvnWriteAuthorities = MVN_WRITE_ROLE_AUTHORITIES.toTypedArray()
                authorize(HttpMethod.POST, "/mvn/**", hasAnyAuthority(*mvnWriteAuthorities))
                authorize(HttpMethod.PUT, "/mvn/**", hasAnyAuthority(*mvnWriteAuthorities))
                authorize(HttpMethod.PATCH, "/mvn/**", hasAnyAuthority(*mvnWriteAuthorities))
                authorize(HttpMethod.DELETE, "/mvn/**", hasAnyAuthority(*mvnWriteAuthorities))
                authorize("/mvn/**", permitAll)

                // API
                val apiReadAuthorities = API_READ_ROLE_AUTHORITIES.toTypedArray()
                val apiWriteAuthorities = API_WRITE_ROLE_AUTHORITIES.toTypedArray()
                authorize(HttpMethod.POST, "/api/**", hasAnyAuthority(*apiWriteAuthorities))
                authorize(HttpMethod.PUT, "/api/**", hasAnyAuthority(*apiWriteAuthorities))
                authorize(HttpMethod.PATCH, "/api/**", hasAnyAuthority(*apiWriteAuthorities))
                authorize(HttpMethod.DELETE, "/api/**", hasAnyAuthority(*apiWriteAuthorities))
                authorize(HttpMethod.GET, "/api/**", hasAnyAuthority(*apiReadAuthorities))
                authorize("/api/**", permitAll)

                // Other
                authorize("**", permitAll)
            }
            httpBasic {
                authenticationEntryPoint = NoPopupBasicAuthenticationEntryPoint()
            }
            oauth2ResourceServer {
                jwt { authenticationManager = jwtAuthMan }
            }

            // maven's upload process looks like a cross-site request forgery. It needs to be disabled.
            csrf { disable() }
        }

        return http.build()
    }
}