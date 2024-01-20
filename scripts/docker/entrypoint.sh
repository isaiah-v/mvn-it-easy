#!/bin/sh

set -- \
  "-Dserver.forward-headers-strategy=FRAMEWORK" \
  "-Dmvn.type=file-system" \
  "-Dmvn.file-system.password-file=/data/mvn.password" \
  "-Dmvn.file-system.repository=/data/www" \


if [ -n "$MVN_PUBLIC" ]; then
  set -- "$@" "-Dmvn.public=$MVN_PUBLIC"
else
  set -- "$@" "-Dmvn.public=false"
fi

[ -n "$ADMIN_USERNAME" ] && set -- "$@" "-Dmvn.admin.username=$ADMIN_USERNAME"
[ -n "$ADMIN_PASSWORD" ] && set -- "$@" "-Dmvn.admin.password=$ADMIN_PASSWORD"

java "$@" -jar app.jar