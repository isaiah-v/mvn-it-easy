package org.ivcode.mvn.util

import java.io.File
import kotlin.io.path.relativeTo

public fun File.isSubdirectoryOf(file: File): Boolean =
    this.canonicalPath.startsWith(file.canonicalPath)

public fun File.pathRelativeTo(file: File): String =
    this.toPath().relativeTo(file.toPath()).toString()

public fun File.isEqual(file: File): Boolean =
    this.canonicalPath == file.canonicalPath