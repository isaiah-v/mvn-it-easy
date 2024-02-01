package org.ivcode.mvn.controllers

import org.ivcode.mvn.services.repositoryapi.models.RepositoryInfo
import org.springframework.http.RequestEntity
import org.springframework.http.ResponseEntity
import org.springframework.web.servlet.mvc.method.annotation.StreamingResponseBody
import java.io.InputStream

public interface MvnController {
    public fun get(info: RepositoryInfo, request: RequestEntity<Any>): ResponseEntity<StreamingResponseBody>
    public fun post(info: RepositoryInfo, request: RequestEntity<InputStream>): ResponseEntity<Any>
    public fun put(info: RepositoryInfo, request: RequestEntity<InputStream>): ResponseEntity<Any>
    public fun delete(info: RepositoryInfo, request: RequestEntity<Any>): ResponseEntity<Any>
}