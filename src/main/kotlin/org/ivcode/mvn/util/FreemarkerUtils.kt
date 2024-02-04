package org.ivcode.mvn.util

import org.ivcode.mvn.services.fileserver.models.ResourceInfo

public fun ResourceInfo.toFreemarkerDataModel(): Map<String, Any?> = mapOf(
    "uri" to this.uri,
    "path" to this.path,
    "isRoot" to this.isRoot,
    "parentUri" to if(!this.isRoot) { this.uri.withParentPath() } else { null },
    "name" to this.name,
    "directories" to (
            this.children
                ?.filter { c -> c.isDirectory }
                ?.sortedBy { it.name }
                ?:emptyList()
    ),
    "files" to (
            this.children
                ?.filter { c -> !c.isDirectory }
                ?.sortedBy { it.name }
                ?:emptyList()
    )
)