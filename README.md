# iv-mvn
Maven Repository Server

Goals:
 - self-hosted locally
 - artifacts persisted in database rather than file-system
 - supports public and private repositories
 - OAuth2 authorization for api calls

### Build Image
<sub>Required: `linux` `java 21+` `docker`</sub>
```bash
./gradlew clean build && ./gradlew docker-build
```


### Basic Configuration

```bash
# Start the DEV environment
TODO

# Define the issuer
# Note that because we're docker, "localhost" does not work.
# Also, "host.docker.internal" doesn't work because the jwt issuer will be incorrect when making requests
export OAUTH2_ISSUER=http://$(hostname -I | awk '{print $1}')/auth/realms/master/protocol/openid-connect/token

# Set the admin to "admin@domain.com". It takes a list, comma seperated
export OAUTH2_ADMINS=admin@domain.com

docker run \
 --name iv-mvn \
 --publish 8080:8080 \
 --volume ${PWD}/data:/app/data \
 --env OAUTH2_ISSUER=${OAUTH2_ISSUER} \
 --env OAUTH2_ADMINS=${OAUTH2_ADMINS} \
 iv-mvn
```
This configuration doesn't specify a database, so it defaults to using h2.


### Open Api 
```
http://localhost:8080/swagger-ui/index.html
```