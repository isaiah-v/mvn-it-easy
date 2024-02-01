package org.ivcode.mvn.exceptions

import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.ResponseStatus

/** 400 */
@ResponseStatus(HttpStatus.BAD_REQUEST)
public class BadRequestException: RuntimeException()

/** 403 */
@ResponseStatus(HttpStatus.FORBIDDEN)
public class ForbiddenException: RuntimeException()

/** 404 */
@ResponseStatus(HttpStatus.NOT_FOUND)
public class NotFoundException: RuntimeException()

/** 409 */
@ResponseStatus(HttpStatus.CONFLICT)
public class ConflictException: RuntimeException()

/** 500 */
@ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
public class InternalServerErrorException: RuntimeException()