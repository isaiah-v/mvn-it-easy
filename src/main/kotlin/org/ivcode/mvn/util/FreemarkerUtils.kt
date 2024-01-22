package org.ivcode.mvn.util

import org.ivcode.mvn.services.fileserver.models.ResourceInfo

public fun ResourceInfo.toFreemarkerDataModel(): Map<String, Any> = mapOf(
    "path" to this.path,
    "name" to this.name,
    "isRoot" to this.isRoot,
    "directories" to (
            this.children
                ?.filter { c -> c.isDirectory }
                ?.map { c -> c.name }
                ?.sorted()
                ?:emptyList()
    ),
    "files" to (
            this.children
                ?.filter { c -> !c.isDirectory }
                ?.map { c -> c.name }
                ?.sorted()
                ?:emptyList()
    )
)