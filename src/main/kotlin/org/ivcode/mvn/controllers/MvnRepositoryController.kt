package org.ivcode.mvn.controllers

import freemarker.template.Template
import jakarta.servlet.ServletContext
import org.ivcode.mvn.exceptions.InternalServerErrorException
import org.ivcode.mvn.services.fileserver.FileServerService
import org.ivcode.mvn.services.mvn_manager.MvnManagerService
import org.ivcode.mvn.services.mvn_manager.models.RepositoryInfo
import org.ivcode.mvn.services.mvn_manager.models.RepositoryType
import org.ivcode.mvn.util.isAnonymous
import org.ivcode.mvn.util.toFreemarkerDataModel
import org.springframework.http.*
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.servlet.mvc.method.annotation.StreamingResponseBody
import java.io.InputStream
import java.net.URI
import java.nio.file.Path
import kotlin.io.path.Path

@Controller
@RequestMapping(path = ["/mvn"])
public class MvnRepositoryController (
    fssList: List<FileServerService>,
    private val repoSwitch: MvnManagerService,
    private val servletContext: ServletContext,
    private val directoryTemplate: Template
) {
    private val fssMap: Map<RepositoryType, FileServerService> = fssList.associateBy { it.type }

    init {
        if(fssMap.isEmpty()) {
            throw IllegalArgumentException("file service map cannot be empty")
        }
    }

    @RequestMapping(method = [RequestMethod.GET], path = ["/{repoId}/**"])
    public fun get(
        @PathVariable repoId: String,
        request: RequestEntity<Any>
    ): ResponseEntity<StreamingResponseBody> {
        val info = repoSwitch.getRepository(repoId);

        // if a repository is private, anonymous users can't read from it
        if(!info.public && isAnonymous()) {
            return ResponseEntity
                .status(HttpStatus.UNAUTHORIZED)
                .header("WWW-Authenticate", "Basic realm=\"Realm\"")
                .build()
        }

        val fs = fssMap[info.type] ?: throw InternalServerErrorException()

        val pathInfo = fs.getPathInfo(info, getPath(info, request.url))

        if(pathInfo.isDirectory) {
            return ResponseEntity.ok().contentType(MediaType.TEXT_HTML).body(StreamingResponseBody { out ->
                directoryTemplate.process(pathInfo.toFreemarkerDataModel(), out.writer())
            })
        }

        val stream = StreamingResponseBody { out ->
            fs.get(info, pathInfo, out)
        }

        return ResponseEntity.ok().run {
            if(pathInfo.mimeType!=null)
                contentType(pathInfo.mimeType)

            body(stream)
        }
    }

    @RequestMapping(method = [RequestMethod.POST], path = ["/{repoId}/**"])
    public fun post(
        @PathVariable repoId: String,
        request: RequestEntity<InputStream>
    ): ResponseEntity<Any> {
        val info = repoSwitch.getRepository(repoId)
        val fs = fssMap[info.type] ?: throw InternalServerErrorException()

        request.body.use {
            fs.post(info, getPath(info, request.url), it!!)
        }

        return ResponseEntity.ok().build()
    }

    @RequestMapping(method = [RequestMethod.PUT], path = ["/{repoId}/**"])
    public fun put(
        @PathVariable repoId: String,
        request: RequestEntity<InputStream>
    ): ResponseEntity<Any> {
        val info = repoSwitch.getRepository(repoId)
        val fs = fssMap[info.type] ?: throw InternalServerErrorException()

        request.body.use {
            fs.put(info, getPath(info, request.url), it!!)
        }

        return ResponseEntity.ok().build()
    }

    @RequestMapping(method = [RequestMethod.DELETE], path = ["/{repoId}/**"])
    public fun delete(
        @PathVariable repoId: String,
        request: RequestEntity<Any>
    ): ResponseEntity<Any> {
        val info = repoSwitch.getRepository(repoId)
        val fs = fssMap[info.type] ?: throw InternalServerErrorException()

        fs.delete(info, getPath(info, request.url))
        return ResponseEntity.ok().build()
    }

    private fun getPath(info: RepositoryInfo, uri: URI): Path {
        // remove the servlet context, if there is one
        val path = Path(uri.path
            .removePrefix("/")
            .removePrefix("mvn/${info.id}")
            .removePrefix("/"))
        val context = Path(servletContext.contextPath.removePrefix("/"))

        return path.resolve(context)
    }
}