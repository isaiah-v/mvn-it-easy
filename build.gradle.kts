import org.gradle.nativeplatform.platform.internal.DefaultNativePlatform

plugins {
    kotlin("jvm") version "1.9.22"
    kotlin("plugin.spring") version "1.9.22"
    id("org.springframework.boot") version "3.2.1"
    id("io.spring.dependency-management") version "1.1.0"
    application
}

group = "org.ivcode"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

dependencies {
    // Kotlin
    implementation(kotlin("stdlib"))
    implementation(kotlin("reflect"))

    // Spring Boot
    implementation("org.springframework.boot:spring-boot-starter-web")
    implementation("com.fasterxml.jackson.module:jackson-module-kotlin")
    implementation("org.springframework.boot:spring-boot-starter-security")

    // MyBatis
    implementation("org.mybatis:mybatis:3.5.14")
    implementation("org.mybatis.spring.boot:mybatis-spring-boot-starter:3.0.3")

    // SpringDoc
    implementation("org.springdoc:springdoc-openapi-starter-webmvc-ui:2.3.0")

    // Liquibase
    implementation("org.liquibase:liquibase-core:4.25.1")

    // Freemarker
    implementation("org.freemarker:freemarker")

    // DB Drivers
    implementation("com.h2database:h2:2.2.224")


    testImplementation("org.jetbrains.kotlin:kotlin-test")
}

fun String.runCommand(workingDirectory: File = layout.projectDirectory.asFile, env: List<Pair<String, Any>> = emptyList()): Int {
    println("> $this")
    return project.exec {
        environment(*env.toTypedArray())
        workingDir = workingDirectory
        commandLine = this@runCommand.split("\\s".toRegex())
    }.exitValue
}

tasks.register("docker-build") {
    val scripts = File(layout.projectDirectory.asFile, "scripts${File.separator}docker")

    doLast {
        val os = DefaultNativePlatform.getCurrentOperatingSystem()

        if(os.isLinux) {
            "./build.sh".runCommand(scripts, listOf(
                "PROJECT_NAME" to rootProject.name,
                "PROJECT_VERSION" to rootProject.version
            ))
        } else {
            throw IllegalStateException("Unsupported Operating System: ${os.name}")
        }
    }
}


tasks.test {
    useJUnitPlatform()
}
kotlin {
    explicitApi()
    jvmToolchain(21)
}

application {
    mainClass.set("org.ivcode.mvn.MainKt")
}