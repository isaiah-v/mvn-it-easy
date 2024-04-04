package org.ivcode.mvn.controllers

import org.ivcode.mvn.exceptions.InternalServerErrorException
import org.ivcode.mvn.repositories.HealthDao
import org.springframework.beans.factory.annotation.Value
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import java.net.URI
import java.net.http.HttpClient
import java.net.http.HttpRequest
import java.net.http.HttpResponse

@RestController
@RequestMapping(path = ["/health"])
public class HealthController (
    private val healthDao: HealthDao,
    @Value("\${security.oauth2.issuer-url}") private val issuerUrl: String,
) {
    @GetMapping
    public fun healthcheck() {
        // call the database and make sure no exceptions are thrown
        healthDao.healthCheck()

        // make sure the issuer is returning 200
        val statusCode = testUrl(issuerUrl)
        if(statusCode<200 || statusCode>=300) {
            throw InternalServerErrorException()
        }
    }

    private fun testUrl(url: String): Int {
        val client = HttpClient.newBuilder().build()
        val request = HttpRequest.newBuilder()
            .uri(URI.create(url))
            .build()
        val response = client.send(request, HttpResponse.BodyHandlers.ofString())
        return response.statusCode()
    }
}