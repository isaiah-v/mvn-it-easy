package org.ivcode.mvn.config

import org.ivcode.mvn.services.models.BasicAuthRole
import org.ivcode.mvn.services.models.BasicAuthUserEntry
import org.ivcode.mvn.util.hash
import org.ivcode.mvn.util.read
import org.ivcode.mvn.util.write
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Value
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import java.nio.file.Path
import kotlin.io.path.exists

private val LOGGER = LoggerFactory.getLogger(BasicAuthConfig::class.java)

@Configuration
public class BasicAuthConfig {

    @Bean("basic-auth-user-entries")
    @ConditionalOnProperty(value = ["mvn.type"], havingValue = "file-system", matchIfMissing = false)
    public fun createUserPassword(
        @Value("\${mvn.file-system.password-file}") passwordsFile: Path,
        @Value("\${mvn.admin.username:#{null}}") adminUsername: String?,
        @Value("\${mvn.admin.password:#{null}}") adminPassword: String?,
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