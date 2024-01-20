# mvn-it-simple
just a simple maven repository

Where are all the small-scale mvn repos that are ready out of the box?... Here's one...

### Build Image
<sub>Required: `linux` `java 21+` `docker`</sub>
```bash
./gradlew clean build && ./gradlew docker-build
```


### Basic Configuration

```bash
docker run \
 --name mvn-it-simple \
 --publish 8080:8080 \
 --volume ${PWD}/data:/data \
 --env ADMIN_USERNAME=admin \
 --env ADMIN_PASSWORD=password \
 --env MVN_PUBLIC=true \
 mvn-it-simple
```