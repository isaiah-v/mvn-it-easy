package org.ivcode.mvn.controllers

import jakarta.servlet.ServletContext
import org.ivcode.mvn.exceptions.NotFoundException
import org.ivcode.mvn.services.MvnService
import org.springframework.http.RequestEntity
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.servlet.mvc.method.annotation.StreamingResponseBody
import java.io.InputStream
import java.net.URI
import java.nio.file.Path
import kotlin.io.path.Path
import kotlin.io.path.relativeTo

@Controller
@RequestMapping
public class MvnRepoController (
    private val repo: MvnService,
    private val servletContext: ServletContext
) {

    @RequestMapping(method = [RequestMethod.GET], path = ["/**"])
    public fun get(request: RequestEntity<Any>): ResponseEntity<StreamingResponseBody> {

        val pathInfo = repo.getPathInfo(getPath(request.url))

        if(pathInfo.isDirectory) {
            // TODO return a file directory page
            throw NotFoundException()
        }

        val stream = StreamingResponseBody { out ->
            repo.get(pathInfo, out)
        }

        return ResponseEntity.ok().run {
            if(pathInfo.mimeType!=null)
                contentType(pathInfo.mimeType)

            body(stream)
        }
    }

    @RequestMapping(method = [RequestMethod.POST], path = ["/**"])
    public fun post(request: RequestEntity<InputStream>): ResponseEntity<Any> {
        request.body.use {
            repo.post(getPath(request.url), it!!)
        }

        return ResponseEntity.ok().build()
    }

    @RequestMapping(method = [RequestMethod.PUT], path = ["/**"])
    public fun put(request: RequestEntity<InputStream>): ResponseEntity<Any> {
        request.body.use {
            repo.put(getPath(request.url), it!!)
        }

        return ResponseEntity.ok().build()
    }

    @RequestMapping(method = [RequestMethod.DELETE], path = ["/**"])
    public fun delete(request: RequestEntity<Any>): ResponseEntity<Any> {
        repo.delete(getPath(request.url))
        return ResponseEntity.ok().build()
    }

    private fun getPath(uri: URI): Path {
        // remove the servlet context, if there is one
        val path = Path(uri.path.removePrefix("/"))
        val context = Path(servletContext.contextPath.removePrefix("/"))

        return path.resolve(context)
    }
}