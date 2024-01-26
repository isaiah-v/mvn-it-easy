package org.ivcode.mvn.util

import org.junit.jupiter.api.Test
import java.net.URI
import kotlin.test.assertEquals

class UriUtilsTest {

    @Test
    fun testWithParentPath() {
        val uri = URI.create("https://domain.com/parent/child")
        assertEquals(URI.create("https://domain.com/parent"), uri.withParentPath())
    }

    @Test
    fun testWithParentPathWithoutAParent() {
        val uri = URI.create("https://domain.com/")
        assertEquals(URI.create("https://domain.com/"), uri.withParentPath())
    }
}