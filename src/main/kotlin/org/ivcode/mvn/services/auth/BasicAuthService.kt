package org.ivcode.mvn.services.auth

import org.ivcode.mvn.services.auth.models.BasicAuthorization
import org.ivcode.mvn.services.auth.models.UsernamePassword

public interface BasicAuthService {

    /**
     * Decodes a base64 encoded username and password
     *
     * @return clear text username and passwords
     */
    public fun decode(authorization: String): UsernamePassword

    /**
     * Checks if the given username and password are authorized. A user is only authorized if
     * BasicAuthorization.isAuthorized==true`
     *
     * @param username the user's name
     * @param password the user's password
     *
     * @return the basic auth info and status
     */
    public fun authorize(username: String, password: String): BasicAuthorization
}