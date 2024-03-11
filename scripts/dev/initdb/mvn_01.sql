-- Mvn
CREATE DATABASE mvn;
USE mvn;

CREATE USER 'mvn'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON mvn.* TO 'mvn'@'%';