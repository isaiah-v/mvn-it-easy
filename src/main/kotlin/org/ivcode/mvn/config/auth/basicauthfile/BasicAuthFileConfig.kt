package org.ivcode.mvn.config.auth.basicauthfile

import org.ivcode.mvn.services.auth.models.BasicAuthRole
import org.ivcode.mvn.services.auth.models.BasicAuthUserEntry
import org.ivcode.mvn.util.auth.basicauthfile.hash
import org.ivcode.mvn.util.auth.basicauthfile.read
import org.ivcode.mvn.util.auth.basicauthfile.write
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Value
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import java.nio.file.Path
import kotlin.io.path.exists

@Configuration
@ConditionalOnProperty(value = ["mvn.auth.type"], havingValue = "basic-auth-file", matchIfMissing = false)
public class BasicAuthFileConfig {

    private companion object {
        private val LOGGER = LoggerFactory.getLogger(BasicAuthFileConfig::class.java)
    }

    @Bean("basic-auth-user-entries")
    public fun createUserPassword(
        @Value("\${mvn.auth.basic-auth-file.password-file}") passwordsFile: Path,
        @Value("\${mvn.auth.admin.username:#{null}}") adminUsername: String?,
        @Value("\${mvn.auth.admin.password:#{null}}") adminPassword: String?,
    ): Set<BasicAuthUserEntry> {

        var entries = if(passwordsFile.exists()) BasicAuthUserEntry.read(passwordsFile) else emptySet()
        if(adminUsername!=null && adminPassword!=null) {
            val admin = BasicAuthUserEntry.hash(adminUsername, BasicAuthRole.ADMIN, adminPassword)
            val entriesAndAdmin = entries.toMutableSet().apply { add(admin) }

            if(entriesAndAdmin != entries) {
                BasicAuthUserEntry.write(passwordsFile, entriesAndAdmin)
                entries = entriesAndAdmin
            }

        }

        if(entries.isEmpty()) {
            LOGGER.warn(" --== WARNING - USERS NOT DEFINED: Access will be limited or non-existent")
        }
        return entries
    }
}