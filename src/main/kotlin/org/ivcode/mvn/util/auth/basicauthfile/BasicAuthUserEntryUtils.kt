package org.ivcode.mvn.util.auth.basicauthfile

import org.ivcode.mvn.services.auth.models.BasicAuthRole
import org.ivcode.mvn.services.auth.models.BasicAuthUserEntry
import org.ivcode.mvn.util.md5
import java.io.InputStreamReader
import java.io.OutputStreamWriter
import java.nio.file.Path
import kotlin.io.path.inputStream
import kotlin.io.path.outputStream

public fun BasicAuthUserEntry.Companion.read(file: Path): Set<BasicAuthUserEntry> = mutableSetOf<BasicAuthUserEntry>().apply {
    InputStreamReader(file.inputStream()).use { reader ->
        reader.forEachLine {
            val line = it.trim()

            if(line.isNotEmpty()) {
                val validRoles = org.ivcode.mvn.services.auth.models.BasicAuthRole.entries.map { role -> role }

                val userEntry = try {
                    BasicAuthUserEntry.createFromString(it)
                } catch (e: Exception) {
                    throw IllegalArgumentException("Invalid User Entry: Please fix or remote user entry \"${it}\"", e)
                }


                if(!validRoles.contains(userEntry.role)) {
                    throw IllegalStateException("Invalid Role: Please fix or remote user entry \"${it}\". Valid roles: $validRoles")
                }

                add(userEntry)
            }
        }
    }
}

public fun BasicAuthUserEntry.Companion.write(file: Path, userEntries: Set<BasicAuthUserEntry>): Unit = OutputStreamWriter(file.outputStream()).use {
    for(userEntry in userEntries) {
        it.write(userEntry.toString()+System.lineSeparator())
    }
    it.flush()
}

public fun BasicAuthUserEntry.Companion.createFromString(string: String): BasicAuthUserEntry {

    val pairs = mapOf(*org.ivcode.mvn.services.auth.models.BasicAuthRole.entries.stream().map { role -> role.roleName() to role }.toList().toTypedArray())

    val parts = string.split(":")
    if(parts.size!=3) {
        throw IllegalArgumentException("Invalid user-role-hash string")
    }

    return BasicAuthUserEntry (
        username = parts[0],
        role = pairs[parts[1]] ?: throw IllegalArgumentException("invalid role: ${parts[1]}"),
        hashcode = parts[2]
    )
}

public fun BasicAuthUserEntry.Companion.hash(username: String, role: BasicAuthRole, password: String): BasicAuthUserEntry {
    return BasicAuthUserEntry (
        username = username,
        role = role,
        hashcode = "${username}:${role.roleName()}:${password}".md5()
    )
}
