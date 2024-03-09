package org.ivcode.mvn.security

/**
 * Roles
 *
 * A role represents what a user's responsibilities are. It provides a broader (less granular) set of permissions
 */
public enum class Role (
    public val mvnRead: Boolean = false,
    public val mvnWrite: Boolean = false,
    public val apiRead: Boolean = false,
    public val apiWrite: Boolean = false,
) {

    /**
     * A user who that read from the private maven repos but nothing else.
     *
     * This user is created by the admin and is typically used by the build automation framework (maven/gradle)
     */
    MVN_USER (
        mvnRead = true
    ),

    /**
     * A maven publisher publishes artifacts to the maven repos
     *
     * This user is created by the admin and is typically used by the build system to publish artifacts
     */
    MVN_PUBLISHER (
        mvnRead = true,
        mvnWrite = true
    ),

    /**
     * A user with general read access
     *
     * This is a generic user who logged in through the main authorization mechanism without special privileges
     */
    USER (
        mvnRead = true,
        apiWrite = true
    ),

    /**
     * The administrator is responsible for maintaining the system
     *
     * To be an admin, you must log in through the main authorization mechanism and the security layer must recognize you
     * as an admin.
     */
    ADMIN (
        mvnRead = true,
        mvnWrite = true,
        apiRead = true,
        apiWrite = true
    );

    public companion object {
        public fun mvnReadRoles(): Set<Role> =
            values().filter { it.mvnRead }.toSet()

        public fun mvnWriteRoles(): Set<Role> =
            values().filter { it.mvnWrite }.toSet()

        public fun apiReadRoles(): Set<Role> =
            values().filter { it.apiRead }.toSet()

        public fun apiWriteRoles(): Set<Role> =
            values().filter { it.apiWrite }.toSet()
    }


    /**
     * Returns the valid role name. This is the value that should be used when performing operations against the role
     * name.
     */
    public fun roleName():String {
        return "ROLE_${this.name.uppercase()}"
    }
}

public val MVN_READ_ROLE_AUTHORITIES: Set<String> = Role.mvnReadRoles().map { it.roleName() }.toSet()
public val MVN_WRITE_ROLE_AUTHORITIES: Set<String> = Role.mvnWriteRoles().map { it.roleName() }.toSet()
public val API_READ_ROLE_AUTHORITIES: Set<String> = Role.apiReadRoles().map { it.roleName() }.toSet()
public val API_WRITE_ROLE_AUTHORITIES: Set<String> = Role.apiWriteRoles().map { it.roleName() }.toSet()