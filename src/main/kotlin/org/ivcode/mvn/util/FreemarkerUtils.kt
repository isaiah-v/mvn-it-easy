package org.ivcode.mvn.util

import org.ivcode.mvn.services.dbfilesystem.models.DirectoryInfo

public fun DirectoryInfo.toFreemarkerDataModel(): Map<String, Any?> = mapOf(
    "uri" to this.uri,
    "path" to this.path,
    "isRoot" to this.isRoot,
    "parentUri" to if(!this.isRoot) { this.uri.withParentPath() } else { null },
    "name" to this.name,
    "directories" to (
            this.children
                .filter { c -> c.isDirectory }
                .sortedBy { it.name }
    ),
    "files" to (
            this.children
                .filter { c -> !c.isDirectory }
                .sortedBy { it.name }
    )
)