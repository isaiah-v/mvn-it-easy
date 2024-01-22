package org.ivcode.mvn.services.auth.models

public enum class BasicAuthRole {
    USER,       // Read Access
    ADMIN,      // Read/Write Access
    ;

    /**
     * Returns the valid role name. This is the value that should be used when performing operations against the role
     * name.
     */
    public fun roleName():String {
        return this.name.lowercase()
    }
}