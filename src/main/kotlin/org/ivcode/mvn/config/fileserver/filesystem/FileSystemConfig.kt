package org.ivcode.mvn.config.fileserver.filesystem

import org.ivcode.mvn.controllers.REPO_RELEASE
import org.ivcode.mvn.controllers.REPO_SNAPSHOT
import org.ivcode.mvn.services.fileserver.FileServerService
import org.ivcode.mvn.services.fileserver.filesystem.FileServerServiceFileSystemImpl
import org.springframework.beans.factory.annotation.Value
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import java.nio.file.Path

@Configuration
public class FileSystemConfig {

    @Bean("snapshot.file-service")
    @ConditionalOnProperty(value = ["mvn.snapshot.type"], havingValue = "file-system", matchIfMissing = false)
    public fun createSnapshotFileServerService (
        @Value("\${mvn.snapshot.file-system.repository}") mvnRoot: Path
    ): FileServerService = FileServerServiceFileSystemImpl(
        REPO_SNAPSHOT,
        mvnRoot
    )

    @Bean("release.file-service")
    @ConditionalOnProperty(value = ["mvn.release.type"], havingValue = "file-system", matchIfMissing = false)
    public fun createReleaseFileServerService (
        @Value("\${mvn.release.file-system.repository}") mvnRoot: Path
    ): FileServerService = FileServerServiceFileSystemImpl(
        REPO_RELEASE,
        mvnRoot
    )
}