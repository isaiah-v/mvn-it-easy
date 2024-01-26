package org.ivcode.mvn.util

import org.springframework.web.util.UriComponentsBuilder
import java.net.URI
import kotlin.io.path.Path

public fun URI.withParentPath(): URI = UriComponentsBuilder
    .fromUri(this)
    .replacePath(Path(this.path).parent?.toString() ?: this.path)
    .build()
    .toUri()