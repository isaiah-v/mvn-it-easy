FROM amazoncorretto:21-alpine

ARG PROJECT_NAME
ARG PROJECT_VERSION

RUN apk --no-cache add curl

COPY build/libs/${PROJECT_NAME}-${PROJECT_VERSION}.jar app.jar
COPY scripts/docker/entrypoint.sh entrypoint.sh

HEALTHCHECK --timeout=5s --start-period=30s \
  CMD curl -f http://localhost:8080 || exit 1

CMD ["sh", "./entrypoint.sh"]