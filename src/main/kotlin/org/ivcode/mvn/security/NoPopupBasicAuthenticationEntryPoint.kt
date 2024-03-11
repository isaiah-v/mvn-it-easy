package org.ivcode.mvn.security

import jakarta.servlet.ServletException
import jakarta.servlet.http.HttpServletRequest
import jakarta.servlet.http.HttpServletResponse
import org.springframework.security.core.AuthenticationException
import org.springframework.security.web.authentication.www.BasicAuthenticationEntryPoint
import java.io.IOException


/**
 * A [BasicAuthenticationEntryPoint] that doesn't error with the `Www-Authenticate` header.
 */
public class NoPopupBasicAuthenticationEntryPoint: BasicAuthenticationEntryPoint() {

    init {
        realmName = "Realm"
    }

    @Throws(IOException::class, ServletException::class)
    override fun commence(
        request: HttpServletRequest?, response: HttpServletResponse,
        authException: AuthenticationException
    ) {
        response.sendError(HttpServletResponse.SC_UNAUTHORIZED, authException.message)
    }
}