package org.ivcode.mvn.repositories.model

import java.util.*

public data class FileInfoEntity (
    public var id: Long? = null,
    public var repositoryId: Long? = null,
    public var parentId: Long? = null,
    public var name: String? = null,
    public var directory: Boolean? = null,
    public var lastModified: Date? = null,
    public var mime: String? = null,
    public var size: Long? = null,
)

public data class FileSystemDirectoryEntity (
    public var id: Long? = null,
    public var repositoryId: Long? = null,
    public var parentId: Long? = null,
    public var name: String? = null,
)

public data class FileSystemFileEntity (
    public var id: Long? = null,
    public var repositoryId: Long? = null,
    public var parentId: Long? = null,
    public var name: String? = null,
    public var mime: String? = null,
)
