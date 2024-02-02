package org.ivcode.mvn.controllers

import freemarker.template.Template
import jakarta.servlet.ServletContext
import org.ivcode.mvn.exceptions.InternalServerErrorException
import org.ivcode.mvn.services.fileserver.FileServerService
import org.ivcode.mvn.services.repositoryapi.RepositoryServiceSwitch
import org.ivcode.mvn.services.repositoryapi.models.RepositoryInfo
import org.ivcode.mvn.services.repositoryapi.models.RepositoryType
import org.ivcode.mvn.util.toFreemarkerDataModel
import org.ivcode.mvn.util.verifyAuthenticated
import org.springframework.http.MediaType
import org.springframework.http.RequestEntity
import org.springframework.http.ResponseEntity
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
    private val repoSwitch: RepositoryServiceSwitch,
    private val fsMap: Map<RepositoryType, FileServerService>,
    private val servletContext: ServletContext,
    private val directoryTemplate: Template
) {
    @RequestMapping(method = [RequestMethod.GET], path = ["/{repoId}/**"])
    public fun get(
        @PathVariable repoId: String,
        request: RequestEntity<Any>
    ): ResponseEntity<StreamingResponseBody> {
        val info = repoSwitch.getRepository(repoId).verifyReadAccess()
        val fs = fsMap[info.type] ?: throw InternalServerErrorException()


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
        val fs = fsMap[info.type] ?: throw InternalServerErrorException()

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
        val fs = fsMap[info.type] ?: throw InternalServerErrorException()

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
        val fs = fsMap[info.type] ?: throw InternalServerErrorException()

        fs.delete(info, getPath(info, request.url))
        return ResponseEntity.ok().build()
    }

    private fun getPath(info: RepositoryInfo, uri: URI): Path {
        // remove the servlet context, if there is one
        val path = Path(uri.path
            .removePrefix("/")
            .removePrefix(info.id)
            .removePrefix("/"))
        val context = Path(servletContext.contextPath.removePrefix("/"))

        return path.resolve(context)
    }

    /**
     * Verifies the given repo is public or the current user is authorized
     */
    private fun RepositoryInfo.verifyReadAccess() = apply {
        if(!this.public) {
            verifyAuthenticated()
        }
    }
}