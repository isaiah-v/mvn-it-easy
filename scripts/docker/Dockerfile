# base image to build a JRE
FROM amazoncorretto:21-alpine as corretto-jdk

# required for strip-debug to work
RUN apk add --no-cache binutils

# Build small JRE image
RUN $JAVA_HOME/bin/jlink \
         --verbose \
         --add-modules ALL-MODULE-PATH \
         --strip-debug \
         --no-man-pages \
         --no-header-files \
         --compress=zip-9 \
         --output /customjre

FROM alpine:latest
ENV JAVA_HOME=/jre
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# copy JRE from the base image
COPY --from=corretto-jdk /customjre $JAVA_HOME

ARG PROJECT_NAME
ARG PROJECT_VERSION

RUN apk --no-cache add curl

COPY build/libs/${PROJECT_NAME}-${PROJECT_VERSION}.jar app.jar
COPY scripts/docker/entrypoint.sh entrypoint.sh

HEALTHCHECK --timeout=5s --start-period=30s \
  CMD curl -f http://localhost:8080 || exit 1

CMD ["sh", "./entrypoint.sh"]