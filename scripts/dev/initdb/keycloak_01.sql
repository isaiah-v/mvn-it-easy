-- Keycloak
CREATE DATABASE keycloak;
USE keycloak;

CREATE USER 'keycloak'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON keycloak.* TO 'keycloak'@'%';