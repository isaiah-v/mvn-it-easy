#!/bin/sh

# Set Default Parameters
set -- \
  "-Dserver.forward-headers-strategy=FRAMEWORK" \
  "-Dmvn.auth.type=basic-auth-file" \
  "-Dmvn.auth.basic-auth-file.password-file=/data/mvn.password" \
  "-Dmvn.snapshot.type=file-system" \
  "-Dmvn.snapshot.file-system.repository=/data/www/snapshot" \
  "-Dmvn.release.type=file-system" \
  "-Dmvn.release.file-system.repository=/data/www/release" \

# Set if the snapshot repo is public
if [ -n "$MVN_AUTH_PUBLIC_SNAPSHOT" ]; then
  set -- "$@" "-Dmvn.auth.public.snapshot=$MVN_AUTH_PUBLIC_SNAPSHOT"
else
  set -- "$@" "-Dmvn.auth.public.snapshot=false"
fi

# Set if the release repo is public
if [ -n "$MVN_AUTH_PUBLIC_RELEASE" ]; then
  set -- "$@" "-Dmvn.auth.public.release=$MVN_AUTH_PUBLIC_RELEASE"
else
  set -- "$@" "-Dmvn.auth.public.release=false"
fi

# Set default admin
[ -n "$MVN_AUTH_ADMIN_USERNAME" ] && set -- "$@" "-Dmvn.auth.admin.username=$MVN_AUTH_ADMIN_USERNAME"
[ -n "$MVN_AUTH_ADMIN_PASSWORD" ] && set -- "$@" "-Dmvn.auth.admin.password=$MVN_AUTH_ADMIN_PASSWORD"

java "$@" -jar app.jar