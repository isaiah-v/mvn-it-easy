package org.ivcode.mvn.services

import org.ivcode.mvn.services.models.BasicAuthorization
import org.ivcode.mvn.services.models.UsernamePassword

public interface BasicAuthService {

    public fun decode(authorization: String): UsernamePassword
    public fun authorize(username: String, password: String): BasicAuthorization?
}