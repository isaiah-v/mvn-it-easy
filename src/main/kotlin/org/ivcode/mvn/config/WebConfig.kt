package org.ivcode.mvn.config

import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.http.HttpInputMessage
import org.springframework.http.HttpOutputMessage
import org.springframework.http.MediaType
import org.springframework.http.converter.AbstractHttpMessageConverter
import org.springframework.http.converter.HttpMessageConverter
import org.springframework.http.converter.HttpMessageNotReadableException
import org.springframework.http.converter.HttpMessageNotWritableException
import java.io.IOException
import java.io.InputStream

@Configuration
public class WebConfig {

    @Bean
    public fun addOctetStreamConverter(): HttpMessageConverter<*> {
        return object : AbstractHttpMessageConverter<InputStream>(MediaType.APPLICATION_OCTET_STREAM) {
            override fun supports(clazz: Class<*>): Boolean {
                return InputStream::class.java.isAssignableFrom(clazz)
            }

            @Throws(IOException::class, HttpMessageNotReadableException::class)
            override fun readInternal(clazz: Class<out InputStream>, inputMessage: HttpInputMessage): InputStream {
                return inputMessage.body
            }

            @Throws(IOException::class, HttpMessageNotWritableException::class)
            override fun writeInternal(inputStream: InputStream, outputMessage: HttpOutputMessage) {
                inputStream.transferTo(outputMessage.body)
            }
        }
    }
}