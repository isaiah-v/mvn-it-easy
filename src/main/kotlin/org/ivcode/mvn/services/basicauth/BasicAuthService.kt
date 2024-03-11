package org.ivcode.mvn.services.basicauth

import org.ivcode.mvn.exceptions.NotFoundException
import org.ivcode.mvn.repositories.BasicAuthDao
import org.ivcode.mvn.repositories.model.BasicAuthEntity
import org.ivcode.mvn.services.basicauth.model.BasicAuthUser
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.security.MessageDigest
import java.security.SecureRandom
import java.util.Base64

@Service
public class BasicAuthService (
    private val basicAuthDao: BasicAuthDao
) {

    public companion object {
        public fun verify(password: String, salt: String, hash: String): Boolean {
            val genHash = generateHash(password, salt)
            return genHash == hash
        }

        public fun generateSalt(seed: ByteArray? = null): String {
            val bytes = ByteArray(64)
            val random = if(seed!=null) {
                SecureRandom(seed)
            } else {
                SecureRandom()
            }

            random.nextBytes(bytes)
            return Base64.getEncoder().encodeToString(bytes)
        }
        public fun generateHash(password: String, salt: String): String {
            val md: MessageDigest = MessageDigest.getInstance("SHA-512")
            md.update(salt.toByteArray(Charsets.UTF_8))

            val bytes = md.digest(password.toByteArray(Charsets.UTF_8))
            return Base64.getEncoder().encodeToString(bytes)
        }
    }

    public fun listUsers(): List<BasicAuthUser> =
        basicAuthDao.readAll().map { it.toUser() }

    public fun getUser(username: String, password: String): BasicAuthUser? {
        val entity = basicAuthDao.read(username) ?: return null

        if(!verify(password, entity.salt!!, entity.hash!!)) {
            return null
        }

        return BasicAuthUser(
            username = username,
            write = entity.write == true
        )
    }

    @Transactional
    public fun createUser(username: String, password: String, writable: Boolean) {
        val salt = generateSalt()
        val hash = generateHash(password, salt)

        basicAuthDao.create(BasicAuthEntity(
            username = username,
            write = writable,
            salt = salt,
            hash = hash
        ))
    }

    @Transactional
    public fun updateUser(username: String, password: String, writable: Boolean) {
        val entity = basicAuthDao.read(username) ?: throw NotFoundException()
        val salt = generateSalt()
        val hash = generateHash(password, salt)

        basicAuthDao.update(entity.copy(
            username = username,
            salt = salt,
            hash = hash,
            write = writable
        ))
    }

    @Transactional
    public fun deleteUser(username: String) {
        val count = basicAuthDao.deleteByUsername(username)
        if(count==0) {
            throw NotFoundException()
        }
    }

    private fun BasicAuthEntity.toUser() = BasicAuthUser(
        username = username!!,
        write = write!!
    )
}
