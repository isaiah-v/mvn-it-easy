#!/bin/sh

# Default Values
set -- \
  "-Dserver.forward-headers-strategy=FRAMEWORK" \
  "-Dspring.liquibase.enabled=true" \
  "-Dspring.liquibase.change-log=classpath:/database/db.changelog-root.yml" \

# MAX_FILE_SIZE
# spring.servlet.multipart.max-file-size
if [ -n "$MAX_FILE_SIZE" ]; then
  set -- "$@" "-Dspring.servlet.multipart.max-file-size=$MAX_FILE_SIZE"
else
  set -- "$@" "-Dspring.servlet.multipart.max-file-size=100MB"
fi

# MAX_REQUEST_SIZE
# spring.servlet.multipart.max-request-size
if [ -n "$MAX_REQUEST_SIZE" ]; then
  set -- "$@" "-Dspring.servlet.multipart.max-request-size=$MAX_REQUEST_SIZE"
else
  set -- "$@" "-Dspring.servlet.multipart.max-request-size=100MB"
fi

# DATASOURCE_URL
# spring.datasource.url
if [ -n "$DATASOURCE_URL" ]; then
  set -- "$@" "-Dspring.datasource.url=$DATASOURCE_URL"
else
  set -- "$@" "-Dspring.datasource.url=jdbc:h2:file:./data/mvn"
fi

# DATASOURCE_USERNAME
# spring.datasource.username
if [ -n "$DATASOURCE_USERNAME" ]; then
  set -- "$@" "-Dspring.datasource.username=$DATASOURCE_USERNAME"
else
  set -- "$@" "-Dspring.datasource.username=mvn"
fi

# DATASOURCE_PASSWORD
# spring.datasource.username
if [ -n "$DATASOURCE_PASSWORD" ]; then
  set -- "$@" "-Dspring.datasource.password=$DATASOURCE_PASSWORD"
else
  set -- "$@" "-Dspring.datasource.password=password"
fi

# OAUTH2_ISSUER
# security.oauth2.issuer-url
if [ -n "$OAUTH2_ISSUER" ]; then
  set -- "$@" "-Dsecurity.oauth2.issuer-url=$OAUTH2_ISSUER"
else
  echo "OAUTH2_ISSUER required" >&2
  exit 1
fi

# OAUTH2_ADMINS
# security.oauth2.admin
if [ -n "$OAUTH2_ADMINS" ]; then
  set -- "$@" "-Dsecurity.oauth2.admin=$OAUTH2_ADMINS"
fi

java "$@" -jar app.jar