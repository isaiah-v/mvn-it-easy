package org.ivcode.mvn.services.fileserver.models

import org.springframework.http.MediaType
import java.net.URI
import java.nio.file.Path

public data class ResourceInfo (
    val uri: URI,
    val path: Path,
    val name: String,
    val mimeType: MediaType? = null,
    val isDirectory: Boolean,
    val isRoot: Boolean,
    val children: List<ResourceChildInfo>? = null
)

public data class ResourceChildInfo (
    val uri: URI,
    val path: Path,
    val name: String,
    val isDirectory: Boolean
)