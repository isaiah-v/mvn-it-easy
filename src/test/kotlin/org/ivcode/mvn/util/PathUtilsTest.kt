package org.ivcode.mvn.util

import org.junit.jupiter.api.Test
import java.io.File
import kotlin.io.path.Path
import kotlin.test.assertFalse
import kotlin.test.assertTrue

class PathUtilsTest {

    @Test
    fun testIsSubdirectoryOf_ChildReference() {
        val base = Path(".")

        // references a child file
        val child = base.resolve("file.txt")

        assertTrue(child.isSubdirectoryOf(base))
    }

    @Test
    fun testIsSubdirectoryOf_ParentReference() {
        val base = Path(".")

        // references the parent directory
        val child = base.resolve("..")

        assertFalse(child.isSubdirectoryOf(base))
    }

}