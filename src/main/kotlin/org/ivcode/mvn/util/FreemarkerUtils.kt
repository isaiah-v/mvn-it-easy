package org.ivcode.mvn.util

import org.ivcode.mvn.services.fileserver.models.ResourceInfo

public fun ResourceInfo.toFreemarkerDataModel(): Map<String, Any?> = mapOf(
    "uri" to this.uri,
    "isRoot" to this.isRoot,
    "parentUri" to if(!this.isRoot) { this.uri.withParentPath() } else { null },
    "name" to this.name,
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