package org.ivcode.mvn.services.mvn_manager.models

import com.fasterxml.jackson.core.JsonParser
import com.fasterxml.jackson.databind.DeserializationContext
import com.fasterxml.jackson.databind.JsonNode
import com.fasterxml.jackson.databind.deser.std.StdDeserializer

public class RepositoryInfoDeserializer(
    vc: Class<Any>? = null
): StdDeserializer<RepositoryInfo>(vc) {
    override fun deserialize(jp: JsonParser, ctxt: DeserializationContext): RepositoryInfo {
        val node = jp.codec.readTree<JsonNode>(jp)
        return when (val type = RepositoryType.valueOf(node.get("type").textValue())) {
            RepositoryType.FILE_SYSTEM ->
                deserializeFileSystemRepositoryInfo(node)
            else ->
                throw IllegalArgumentException("unknown repo type: $type")
        }
    }

    private fun deserializeFileSystemRepositoryInfo(node: JsonNode) = FileSystemRepositoryInfo(
        id = node.get("id").textValue(),
        public = node.get("public").booleanValue()
    )
}