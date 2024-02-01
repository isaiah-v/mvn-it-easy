package org.ivcode.mvn.controllers

import org.ivcode.mvn.exceptions.NotFoundException
import org.ivcode.mvn.services.repositoryapi.RepositoryServiceSwitch
import org.ivcode.mvn.services.repositoryapi.models.RepositoryType
import org.springframework.http.RequestEntity
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.servlet.mvc.method.annotation.StreamingResponseBody
import java.io.InputStream

@Controller
@RequestMapping(path = ["/mvn"])
public class MvnControllerSwitch (
    private val repoSwitch: RepositoryServiceSwitch,
    private val mvnCtrlMap: Map<RepositoryType, MvnController>
) {
    @RequestMapping(method = [RequestMethod.GET], path = ["/{repoId}/**"])
    public fun get (
        @PathVariable repoId: String,
        request: RequestEntity<Any>
    ): ResponseEntity<StreamingResponseBody> {
        val info = repoSwitch.getRepository(repoId)
        val mvn = mvnCtrlMap[info.type] ?: throw NotFoundException()

        return mvn.get(info, request)
    }

    @RequestMapping(method = [RequestMethod.POST], path = ["/{repoId}/**"])
    public fun post(
        @PathVariable repoId: String,
        request: RequestEntity<InputStream>
    ): ResponseEntity<Any> {
        val info = repoSwitch.getRepository(repoId)
        val mvn = mvnCtrlMap[info.type] ?: throw NotFoundException()

        return mvn.post(info, request)
    }

    @RequestMapping(method = [RequestMethod.PUT], path = ["/{repoId}/**"])
    public fun put(
        @PathVariable repoId: String,
        request: RequestEntity<InputStream>
    ): ResponseEntity<Any> {
        val info = repoSwitch.getRepository(repoId)
        val mvn = mvnCtrlMap[info.type] ?: throw NotFoundException()

        return mvn.put(info, request)
    }

    @RequestMapping(method = [RequestMethod.DELETE], path = ["/repoId/**"])
    public fun delete(
        @PathVariable repoId: String,
        request: RequestEntity<Any>
    ): ResponseEntity<Any> {
        val info = repoSwitch.getRepository(repoId)
        val mvn = mvnCtrlMap[info.type] ?: throw NotFoundException()

        return mvn.delete(info, request)
    }
}