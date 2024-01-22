#!/bin/sh

set -- \
  "-Dserver.forward-headers-strategy=FRAMEWORK" \
  "-Dmvn.file-server.type=file-system" \
  "-Dmvn.file-server.file-system.repository=/data/www" \
  "-Dmvn.auth.type=basic-auth-file" \
  "-Dmvn.auth.basic-auth-file.password-file=/data/mvn.password"

if [ -n "$MVN_PUBLIC" ]; then
  set -- "$@" "-Dmvn.auth.public=$MVN_PUBLIC"
else
  set -- "$@" "-Dmvn.auth.public=false"
fi

[ -n "$ADMIN_USERNAME" ] && set -- "$@" "-Dmvn.auth.admin.username=$ADMIN_USERNAME"
[ -n "$ADMIN_PASSWORD" ] && set -- "$@" "-Dmvn.auth.admin.password=$ADMIN_PASSWORD"

java "$@" -jar app.jar