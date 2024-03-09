package org.ivcode.mvn.controllers

import org.ivcode.mvn.services.basicauth.BasicAuthService
import org.ivcode.mvn.services.basicauth.BasicAuthUser
import org.ivcode.mvn.services.basicauth.CreateBasicAuthUser
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping(path = ["/api/basic-auth"])
public class BasicAuthController(
    private val basicAuthService: BasicAuthService
) {

    @GetMapping
    public fun listUsers(): List<BasicAuthUser> =
        basicAuthService.listUsers()

    @PostMapping
    public fun createUser(createBasicAuthUser: CreateBasicAuthUser) {
        basicAuthService.createUser(
            createBasicAuthUser.username,
            createBasicAuthUser.password,
            createBasicAuthUser.write
        )
    }
}