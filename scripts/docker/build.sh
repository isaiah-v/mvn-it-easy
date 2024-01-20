#!/bin/sh

[ -z "$PROJECT_NAME" ] && echo "PROJECT_NAME is required" && exit 1
[ -z "$PROJECT_VERSION" ] && echo "PROJECT_VERSION is required" && exit 1

cd $(dirname "$(realpath "$0")")

docker build \
  --tag "$PROJECT_NAME:latest" \
  --build-arg="PROJECT_NAME=$PROJECT_NAME" \
  --build-arg="PROJECT_VERSION=$PROJECT_VERSION" \
  --file Dockerfile ../../ \
  || exit 1

docker image rm "$PROJECT_NAME:$PROJECT_VERSION"
docker tag "$PROJECT_NAME:latest" "$PROJECT_NAME:$PROJECT_VERSION"