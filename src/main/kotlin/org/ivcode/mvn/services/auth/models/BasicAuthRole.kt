package org.ivcode.mvn.services.auth.models

public enum class BasicAuthRole(
    public val repositoryRead: Boolean,
    public val repositoryWrite: Boolean,
    public val repositoryManagerRead: Boolean,
    public val repositoryManagerWrite: Boolean,
) {
    USER (
        repositoryRead = true,
        repositoryWrite = false,
        repositoryManagerRead = false,
        repositoryManagerWrite = false
    ),
    ADMIN (
        repositoryRead = true,
        repositoryWrite = true,
        repositoryManagerRead = true,
        repositoryManagerWrite = true
    );

    public companion object {
        public fun repositoryReadRoles(): Set<BasicAuthRole> =
            values().filter { it.repositoryRead }.toSet()

        public fun repositoryWriteRoles(): Set<BasicAuthRole> =
            values().filter { it.repositoryWrite }.toSet()

        public fun repositoryManagerRead(): Set<BasicAuthRole> =
            values().filter { it.repositoryManagerRead }.toSet()

        public fun repositoryManagerWrite(): Set<BasicAuthRole> =
            values().filter { it.repositoryManagerRead }.toSet()
    }


    /**
     * Returns the valid role name. This is the value that should be used when performing operations against the role
     * name.
     */
    public fun roleName():String {
        return this.name.lowercase()
    }
}

public val REPOSITORY_READ_AUTHORITIES: Set<String> = BasicAuthRole.repositoryReadRoles().map { it.roleName() }.toSet()
public val REPOSITORY_WRITE_AUTHORITIES: Set<String> = BasicAuthRole.repositoryWriteRoles().map { it.roleName() }.toSet()
public val REPOSITORY_MANAGER_READ_AUTHORITIES: Set<String> = BasicAuthRole.repositoryReadRoles().map { it.roleName() }.toSet()
public val REPOSITORY_MANAGER_WRITE_AUTHORITIES: Set<String> = BasicAuthRole.repositoryWriteRoles().map { it.roleName() }.toSet()