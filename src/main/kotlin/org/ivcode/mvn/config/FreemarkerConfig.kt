package org.ivcode.mvn.config

import freemarker.template.Configuration
import freemarker.template.Template
import freemarker.template.Version
import org.springframework.context.annotation.Bean

@org.springframework.context.annotation.Configuration
public class FreemarkerConfig {

    @Bean
    public fun createConfig():Configuration {
        val config = Configuration(Version("2.3.32"))

        config.setClassForTemplateLoading(FreemarkerConfig::class.java, "/freemarker")
        config.defaultEncoding = "UTF-8"

        return config
    }

    @Bean("ftl.template.directory")
    public fun createDirectoryTemplate(config: Configuration): Template {
        return config.getTemplate("directory.ftl")
    }


}