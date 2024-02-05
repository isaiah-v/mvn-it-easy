package org.ivcode.mvn.services.mvn_manager

import com.fasterxml.jackson.core.type.TypeReference
import com.fasterxml.jackson.databind.ObjectMapper
import org.ivcode.mvn.services.mvn_manager.models.RepositoryInfo
import org.springframework.beans.factory.annotation.Value
import org.springframework.stereotype.Component
import java.nio.file.Path
import kotlin.io.path.exists
import kotlin.io.path.inputStream
import kotlin.io.path.outputStream

@Component
public class RepositoryInfoManager(
    @Value("\${mvn.root}") public val root: Path,
    public val objectMapper: ObjectMapper
) {

    private final val path = root.resolve("repo.json");
    private final val repositoryInfoMap: MutableMap<String, RepositoryInfo> = run {
        if (path.exists()) {
            // file exists, read file
            val typeRef = object : TypeReference<HashMap<String, RepositoryInfo>>() {}
            path.inputStream().use {
                objectMapper.readValue(it, typeRef)
            }
        } else {
            hashMapOf()
        }
    }

    public fun get(id: String): RepositoryInfo? = repositoryInfoMap[id]

    public fun containsId(id: String): Boolean = repositoryInfoMap.containsKey(id)


    public fun values(): List<RepositoryInfo> = repositoryInfoMap.values.toList()

    @Synchronized
    public fun set(id: String, info: RepositoryInfo): RepositoryInfo? {
        val old = repositoryInfoMap.put(id, info)
        write()

        return old
    }

    @Synchronized
    public fun remove(id: String): RepositoryInfo? {
        val old = repositoryInfoMap.remove(id)
        write()

        return old
    }

    private fun write() = path.outputStream().use {
        objectMapper.writeValue(it, repositoryInfoMap)
    }
}