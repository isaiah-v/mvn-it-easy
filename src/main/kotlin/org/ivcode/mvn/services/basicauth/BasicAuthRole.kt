package org.ivcode.mvn.services.basicauth

public enum class BasicAuthRole(
    public val mvnRead: Boolean = false,
    public val mvnWrite: Boolean = false,
    public val apiRead: Boolean = false,
    public val apiWrite: Boolean = false,
) {
    MVN_USER (
        mvnRead = true
    ),

    MVN_PUBLISHER (
        mvnRead = true,
        mvnWrite = true
    ),

    ADMIN (
        mvnRead = true,
        mvnWrite = true,
        apiRead = true,
        apiWrite = true
    );

    public companion object {
        public fun mvnReadRoles(): Set<BasicAuthRole> =
            values().filter { it.mvnRead }.toSet()

        public fun mvnWriteRoles(): Set<BasicAuthRole> =
            values().filter { it.mvnWrite }.toSet()

        public fun apiReadRoles(): Set<BasicAuthRole> =
            values().filter { it.apiRead }.toSet()

        public fun apiWriteRoles(): Set<BasicAuthRole> =
            values().filter { it.apiWrite }.toSet()
    }


    /**
     * Returns the valid role name. This is the value that should be used when performing operations against the role
     * name.
     */
    public fun roleName():String {
        return this.name.lowercase()
    }
}

public val MVN_READ_AUTHORITIES: Set<String> = BasicAuthRole.mvnReadRoles().map { it.roleName() }.toSet()
public val MVN_WRITE_AUTHORITIES: Set<String> = BasicAuthRole.mvnWriteRoles().map { it.roleName() }.toSet()
public val API_READ_AUTHORITIES: Set<String> = BasicAuthRole.apiReadRoles().map { it.roleName() }.toSet()
public val API_WRITE_AUTHORITIES: Set<String> = BasicAuthRole.apiWriteRoles().map { it.roleName() }.toSet()