package org.ivcode.mvn.controllers

import freemarker.template.Template
import jakarta.servlet.ServletContext
import org.ivcode.mvn.services.fileserver.FileServerService
import org.springframework.beans.factory.annotation.Qualifier
import org.springframework.http.RequestEntity
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.servlet.mvc.method.annotation.StreamingResponseBody
import java.io.InputStream

public const val REPO_RELEASE: String = "release"

@Controller
@RequestMapping(path = ["/${REPO_RELEASE}"])
public class ReleaseFileServerController (
    @Qualifier("release.file-service") fileServerService: FileServerService,
    servletContext: ServletContext,
    @Qualifier("ftl.template.directory") directoryTemplate: Template
): AbstractFileServerController(
    REPO_RELEASE,
    fileServerService,
    servletContext,
    directoryTemplate
) {

    @RequestMapping(method = [RequestMethod.GET], path = ["/**"])
    public override fun get(request: RequestEntity<Any>): ResponseEntity<StreamingResponseBody> = super.get(request)

    @RequestMapping(method = [RequestMethod.POST], path = ["/**"])
    public override fun post(request: RequestEntity<InputStream>): ResponseEntity<Any> = super.post(request)

    @RequestMapping(method = [RequestMethod.PUT], path = ["/**"])
    public override fun put(request: RequestEntity<InputStream>): ResponseEntity<Any> = super.put(request)

    @RequestMapping(method = [RequestMethod.DELETE], path = ["/**"])
    public override fun delete(request: RequestEntity<Any>): ResponseEntity<Any> = super.delete(request)
}