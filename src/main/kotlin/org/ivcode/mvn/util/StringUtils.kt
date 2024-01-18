package org.ivcode.mvn.util

import org.springframework.util.DigestUtils
import java.util.*

public fun String.decodeBase64(): String {
    val data = Base64.getDecoder().decode(this)
    return String(data, Charsets.UTF_8)
}

public fun String.md5(): String {
    return DigestUtils.md5DigestAsHex(this.toByteArray(Charsets.UTF_8)).lowercase()
}
