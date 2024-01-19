package org.ivcode.mvn.impl.filesystem.services

import org.ivcode.mvn.services.BasicAuthService
import org.ivcode.mvn.services.models.BasicAuthRole
import org.ivcode.mvn.services.models.BasicAuthorization
import org.ivcode.mvn.services.models.BasicAuthUserEntry
import org.ivcode.mvn.services.models.UsernamePassword
import org.ivcode.mvn.util.decodeBase64
import org.ivcode.mvn.util.hash
import org.springframework.beans.factory.annotation.Qualifier
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty
import org.springframework.stereotype.Service

@Service
@ConditionalOnProperty(value = ["mvn.type"], havingValue = "file-system", matchIfMissing = false)
public class BasicAuthServiceFileSystemImpl(
    @Qualifier("basic-auth-user-entries") private val basicAuthUserEntries: Set<BasicAuthUserEntry>
): BasicAuthService {

    override fun decode(authorization: String): UsernamePassword {
        val auth = authorization.removePrefix("Basic").trim()

        // Note: username cannot include ':'
        val usernamePassword = auth.decodeBase64().split(":", limit = 2)

        if(usernamePassword.size!=2) {
            throw IllegalArgumentException("incorrect format")
        }

        return UsernamePassword(
            username = usernamePassword[0],
            password = usernamePassword[1]
        )
    }

    override fun authorize(username: String, password: String): BasicAuthorization {

        val roles = mutableListOf<BasicAuthRole>()

        for(role in BasicAuthRole.entries) {
            val entry = BasicAuthUserEntry.hash(username, role, password)
            if(basicAuthUserEntries.contains(entry)) {
                roles.add(entry.role)
            }
        }

        return BasicAuthorization(
            isAuthorized = roles.isNotEmpty(),
            username = username,
            roles = roles
        )
    }
}


