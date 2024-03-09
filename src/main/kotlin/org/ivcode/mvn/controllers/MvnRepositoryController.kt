package org.ivcode.mvn.controllers

import freemarker.template.Template
import jakarta.servlet.ServletContext
import org.ivcode.mvn.services.dbfilesystem.DatabaseFileSystemService
import org.ivcode.mvn.services.dbfilesystem.models.RepositoryInfo
import org.ivcode.mvn.util.hasMvnReadAccess
import org.ivcode.mvn.util.toFreemarkerDataModel
import org.springframework.http.*
import org.springframework.stereotype.Controller
import org.springframework.transaction.annotation.Transactional
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
    private val service: DatabaseFileSystemService,
    private val servletContext: ServletContext,
    private val directoryTemplate: Template,
) {

    @Transactional
    @RequestMapping(method = [RequestMethod.GET], path = ["/{repoId}/**"])
    public fun get(
        @PathVariable repoId: String,
        request: RequestEntity<Any>
    ): ResponseEntity<StreamingResponseBody> {
        val repoInfo = service.getRepositoryInfo(repoId)

        // if a repository is private, anonymous users can't read from it
        // This check is only required for GET because the other cases are already handled
        if(!repoInfo.public && !hasMvnReadAccess()) {
            return ResponseEntity
                .status(HttpStatus.UNAUTHORIZED)
                .header("WWW-Authenticate", "Basic realm=\"Realm\"")
                .build()
        }

        val pathInfo = service.getResourceInfo(repoInfo, getPath(repoInfo, request.url))
        if(pathInfo.isDirectory) {
            val dirInfo = service.getDirectoryInfo(pathInfo)
            return ResponseEntity
                .ok()
                .contentType(MediaType.TEXT_HTML)
                .body(StreamingResponseBody { out ->
                    directoryTemplate.process(dirInfo.toFreemarkerDataModel(), out.writer())
                })
        }

        val stream = StreamingResponseBody { out ->
            service.get(pathInfo, out)
        }

        return ResponseEntity.ok().run {
            if(pathInfo.mimeType!=null)
                contentType(MediaType.parseMediaType(pathInfo.mimeType))

            body(stream)
        }
    }

    @Transactional
    @RequestMapping(method = [RequestMethod.POST], path = ["/{repoId}/**"])
    public fun post(
        @PathVariable repoId: String,
        request: RequestEntity<InputStream>
    ): ResponseEntity<Any> {
        val info = service.getRepositoryInfo(repoId)

        request.body.use {
            service.post(info, getPath(info, request.url), it!!)
        }

        return ResponseEntity.ok().build()
    }

    @Transactional
    @RequestMapping(method = [RequestMethod.PUT], path = ["/{repoId}/**"])
    public fun put(
        @PathVariable repoId: String,
        request: RequestEntity<InputStream>
    ): ResponseEntity<Any> {
        val info = service.getRepositoryInfo(repoId)

        request.body.use {
            service.put(info, getPath(info, request.url), it!!)
        }

        return ResponseEntity.ok().build()
    }

    @Transactional
    @RequestMapping(method = [RequestMethod.DELETE], path = ["/{repoId}/**"])
    public fun delete(
        @PathVariable repoId: String,
        request: RequestEntity<Any>
    ): ResponseEntity<Any> {
        val info = service.getRepositoryInfo(repoId)
        val entryInfo = service.getResourceInfo(info, getPath(info, request.url))
        service.delete(entryInfo)
        return ResponseEntity.ok().build()
    }

    private fun getPath(info: RepositoryInfo, uri: URI): Path {
        // remove the servlet context, if there is one
        val path = Path(uri.path
            .removePrefix("/")
            .removePrefix("mvn/${info.name}")
            .removePrefix("/"))
        val context = Path(servletContext.contextPath.removePrefix("/"))

        return path.resolve(context)
    }
}