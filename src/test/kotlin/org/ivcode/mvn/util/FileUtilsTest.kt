package org.ivcode.mvn.util

import org.junit.jupiter.api.Test
import java.io.File
import kotlin.test.assertFalse
import kotlin.test.assertTrue

class FileUtilsTest {

    @Test
    fun testIsSubdirectoryOf_ChildReference() {
        val base = File(".")

        // references a child file
        val child = File(base, "file.txt")

        assertTrue(child.isSubdirectoryOf(base))
    }

    @Test
    fun testIsSubdirectoryOf_ParentReference() {
        val base = File(".")

        // references the parent directory
        val child = File(base, "..")

        assertFalse(child.isSubdirectoryOf(base))
    }
}