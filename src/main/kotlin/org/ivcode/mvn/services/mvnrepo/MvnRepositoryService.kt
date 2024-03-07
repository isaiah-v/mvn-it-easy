package org.ivcode.mvn.services.mvnrepo

import org.ivcode.mvn.repositories.RepositoryDao
import org.ivcode.mvn.repositories.model.RepositoryEntity
import org.springframework.stereotype.Service

@Service
public class MvnRepositoryService(
    private val repositoryDao: RepositoryDao
) {
    public fun createRepository(repo: MvnRepository) {
        repositoryDao.createRepository(RepositoryEntity(
            name = repo.name,
            public = repo.public
        ))
    }

    public fun readRepositories(): List<MvnRepository> =
        repositoryDao.read().map { it.toMvnRepository() }

    public fun deleteRepository(name: String) {
        repositoryDao.deleteRepository(name)
    }

    private fun RepositoryEntity.toMvnRepository() = MvnRepository(
        name = this.name!!,
        public = this.public!!
    )

}