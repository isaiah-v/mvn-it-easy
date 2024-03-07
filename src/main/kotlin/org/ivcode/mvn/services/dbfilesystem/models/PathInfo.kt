package org.ivcode.mvn.services.dbfilesystem.models

import java.net.URI
import java.nio.file.Path
import java.util.*

public data class RepositoryInfo (
    val id: Long,
    val name: String,
    val public: Boolean
)
public data class PathInfo (
    val repositoryInfo: RepositoryInfo,
    val entryId: Long? = null,
    val parentEntryId: Long? = null,
    val path: Path,
    val name: String,
    val isRoot: Boolean = false,
    val isDirectory: Boolean,
    val mimeType: String? = null,
    val lastModified: Date? = null,
    val size: Long? = null,
)

public data class DirectoryInfo (
    val uri: URI,
    val path: Path,
    val name: String,
    val isRoot: Boolean,
    val children: List<DirectoryChildInfo>,
)

public data class DirectoryChildInfo (
    val uri: URI,
    val path: Path,
    val name: String,
    val isDirectory: Boolean,
    val lastModified: Date?,
    val size: Long?
)