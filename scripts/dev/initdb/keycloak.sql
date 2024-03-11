-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: localhost    Database: keycloak
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ADMIN_EVENT_ENTITY`
--

DROP TABLE IF EXISTS `ADMIN_EVENT_ENTITY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ADMIN_EVENT_ENTITY` (
  `ID` varchar(36) NOT NULL,
  `ADMIN_EVENT_TIME` bigint DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `OPERATION_TYPE` varchar(255) DEFAULT NULL,
  `AUTH_REALM_ID` varchar(255) DEFAULT NULL,
  `AUTH_CLIENT_ID` varchar(255) DEFAULT NULL,
  `AUTH_USER_ID` varchar(255) DEFAULT NULL,
  `IP_ADDRESS` varchar(255) DEFAULT NULL,
  `RESOURCE_PATH` text,
  `REPRESENTATION` text,
  `ERROR` varchar(255) DEFAULT NULL,
  `RESOURCE_TYPE` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_ADMIN_EVENT_TIME` (`REALM_ID`,`ADMIN_EVENT_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ADMIN_EVENT_ENTITY`
--

LOCK TABLES `ADMIN_EVENT_ENTITY` WRITE;
/*!40000 ALTER TABLE `ADMIN_EVENT_ENTITY` DISABLE KEYS */;
/*!40000 ALTER TABLE `ADMIN_EVENT_ENTITY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ASSOCIATED_POLICY`
--

DROP TABLE IF EXISTS `ASSOCIATED_POLICY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ASSOCIATED_POLICY` (
  `POLICY_ID` varchar(36) NOT NULL,
  `ASSOCIATED_POLICY_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`POLICY_ID`,`ASSOCIATED_POLICY_ID`),
  KEY `IDX_ASSOC_POL_ASSOC_POL_ID` (`ASSOCIATED_POLICY_ID`),
  CONSTRAINT `FK_FRSR5S213XCX4WNKOG82SSRFY` FOREIGN KEY (`ASSOCIATED_POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`),
  CONSTRAINT `FK_FRSRPAS14XCX4WNKOG82SSRFY` FOREIGN KEY (`POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ASSOCIATED_POLICY`
--

LOCK TABLES `ASSOCIATED_POLICY` WRITE;
/*!40000 ALTER TABLE `ASSOCIATED_POLICY` DISABLE KEYS */;
INSERT INTO `ASSOCIATED_POLICY` VALUES ('75e10802-5f6d-4802-8020-5a494dc10f2b','7654d293-2101-4fda-ab02-5ecffc35434e');
/*!40000 ALTER TABLE `ASSOCIATED_POLICY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AUTHENTICATION_EXECUTION`
--

DROP TABLE IF EXISTS `AUTHENTICATION_EXECUTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AUTHENTICATION_EXECUTION` (
  `ID` varchar(36) NOT NULL,
  `ALIAS` varchar(255) DEFAULT NULL,
  `AUTHENTICATOR` varchar(36) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `FLOW_ID` varchar(36) DEFAULT NULL,
  `REQUIREMENT` int DEFAULT NULL,
  `PRIORITY` int DEFAULT NULL,
  `AUTHENTICATOR_FLOW` bit(1) NOT NULL DEFAULT b'0',
  `AUTH_FLOW_ID` varchar(36) DEFAULT NULL,
  `AUTH_CONFIG` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_AUTH_EXEC_REALM_FLOW` (`REALM_ID`,`FLOW_ID`),
  KEY `IDX_AUTH_EXEC_FLOW` (`FLOW_ID`),
  CONSTRAINT `FK_AUTH_EXEC_FLOW` FOREIGN KEY (`FLOW_ID`) REFERENCES `AUTHENTICATION_FLOW` (`ID`),
  CONSTRAINT `FK_AUTH_EXEC_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AUTHENTICATION_EXECUTION`
--

LOCK TABLES `AUTHENTICATION_EXECUTION` WRITE;
/*!40000 ALTER TABLE `AUTHENTICATION_EXECUTION` DISABLE KEYS */;
INSERT INTO `AUTHENTICATION_EXECUTION` VALUES ('041d3436-2725-4f4e-bb1f-a085e6228fdd',NULL,'client-secret','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','858a2ecc-22ef-4d3d-9512-0858a1ca0286',2,10,_binary '\0',NULL,NULL),('17955731-c915-41ba-82e7-84ca2f045ff0',NULL,NULL,'7f59a3db-3ce6-4735-8d4e-b391c4609bcb','6ac5ae26-105d-409c-9f62-e69224a4705e',2,20,_binary '','92c9a961-7c6c-42ab-85c7-baa141f6c5ce',NULL),('1b607427-fdde-4d95-8193-945ada62a574',NULL,'conditional-user-configured','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','3a865def-8d0c-4a91-b81e-e22a037c77e1',0,10,_binary '\0',NULL,NULL),('1c36fd97-9bf7-4532-ac33-d0ee43287a52',NULL,'registration-terms-and-conditions','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','e398ea66-010a-4597-ab17-479b9048ec83',3,70,_binary '\0',NULL,NULL),('28c49b4b-6c40-41ec-a884-b5968d438efd',NULL,NULL,'7f59a3db-3ce6-4735-8d4e-b391c4609bcb','159187e0-9eea-423e-94b5-2fc337a5ff99',1,20,_binary '','cef77b3f-eb45-420d-842a-f55a2631aa3f',NULL),('2ca83d2d-b38c-4c58-80e2-750305a78a0b',NULL,'direct-grant-validate-password','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','5e1b6c13-7fc8-423a-91df-a9d33b8021a4',0,20,_binary '\0',NULL,NULL),('2f56cde1-4331-4bf1-82b8-5fd8ddd47cc7',NULL,'client-x509','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','858a2ecc-22ef-4d3d-9512-0858a1ca0286',2,40,_binary '\0',NULL,NULL),('40c54ac8-9c05-4f4d-aa43-ed77fdf64cc7',NULL,NULL,'7f59a3db-3ce6-4735-8d4e-b391c4609bcb','9fd57deb-b9fc-429b-b5bb-a5f6e4ac0a86',2,20,_binary '','159187e0-9eea-423e-94b5-2fc337a5ff99',NULL),('47bebe38-1ffb-48b0-8116-7aeb95cbe7d0',NULL,'docker-http-basic-authenticator','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','845fe7dc-15b8-4ba3-99c7-67f600622813',0,10,_binary '\0',NULL,NULL),('4d59dd51-dbcf-448a-855e-7fb786ad29a4',NULL,'reset-otp','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','338ba83d-aacd-4f6b-9c54-a5e694e967c6',0,20,_binary '\0',NULL,NULL),('54981069-651a-455d-bfe5-896d14e575c6',NULL,'registration-password-action','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','e398ea66-010a-4597-ab17-479b9048ec83',0,50,_binary '\0',NULL,NULL),('56568545-2dcd-4d57-9414-da04223d30b0',NULL,NULL,'7f59a3db-3ce6-4735-8d4e-b391c4609bcb','64f2e709-d32f-46e4-b1cf-d7e4b5fd670d',2,30,_binary '','12424ecd-3e5a-4c16-b1d2-e45f49baf9a7',NULL),('5a08fa24-443c-44eb-bccf-7644c7491930',NULL,'direct-grant-validate-username','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','5e1b6c13-7fc8-423a-91df-a9d33b8021a4',0,10,_binary '\0',NULL,NULL),('5a7928f6-4b50-4f1d-ae46-575f0e458433',NULL,'idp-create-user-if-unique','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','6ac5ae26-105d-409c-9f62-e69224a4705e',2,10,_binary '\0',NULL,'573873f4-f565-44cf-a5d8-059c6e41a156'),('6867fcb6-19a7-4d08-bdc1-c8e2519ad032',NULL,'auth-username-password-form','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','12424ecd-3e5a-4c16-b1d2-e45f49baf9a7',0,10,_binary '\0',NULL,NULL),('6cf54d91-cb60-48f0-a8a6-844e902abd29',NULL,'idp-confirm-link','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','92c9a961-7c6c-42ab-85c7-baa141f6c5ce',0,10,_binary '\0',NULL,NULL),('73381f43-89e4-461e-a25e-b52fe3b78a3f',NULL,'auth-spnego','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','64f2e709-d32f-46e4-b1cf-d7e4b5fd670d',3,20,_binary '\0',NULL,NULL),('740abcbe-a10a-484f-8969-7f35e9c9b675',NULL,'idp-review-profile','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','c0aac3a0-2173-4333-996c-4aae337fd5af',0,10,_binary '\0',NULL,'e1aff667-d743-4354-9ffc-091881bbf10f'),('7b8e387e-9fb5-4ecc-b049-932a0f9ed5b0',NULL,'auth-otp-form','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','cef77b3f-eb45-420d-842a-f55a2631aa3f',0,20,_binary '\0',NULL,NULL),('7da49829-c072-4604-90b2-3f78857acd67',NULL,NULL,'7f59a3db-3ce6-4735-8d4e-b391c4609bcb','12424ecd-3e5a-4c16-b1d2-e45f49baf9a7',1,20,_binary '','3a865def-8d0c-4a91-b81e-e22a037c77e1',NULL),('7e04f4ab-ded7-40a4-9b92-4717e8da5bf5',NULL,'reset-credential-email','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','7f22d11d-1f1c-4687-9cc3-c44b1fb39002',0,20,_binary '\0',NULL,NULL),('9c1d27d1-72cc-4b19-9dce-554fb52b770d',NULL,'idp-email-verification','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','9fd57deb-b9fc-429b-b5bb-a5f6e4ac0a86',2,10,_binary '\0',NULL,NULL),('a2636b42-e238-4c6a-814f-3e34bc2dbb2a',NULL,'client-jwt','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','858a2ecc-22ef-4d3d-9512-0858a1ca0286',2,20,_binary '\0',NULL,NULL),('ae269e64-a0ba-4bf0-ae25-77c3fbd94887',NULL,NULL,'7f59a3db-3ce6-4735-8d4e-b391c4609bcb','92c9a961-7c6c-42ab-85c7-baa141f6c5ce',0,20,_binary '','9fd57deb-b9fc-429b-b5bb-a5f6e4ac0a86',NULL),('afb2dbe0-88e7-4f54-a97c-74725e91279a',NULL,'auth-otp-form','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','3a865def-8d0c-4a91-b81e-e22a037c77e1',0,20,_binary '\0',NULL,NULL),('b5d9d235-a4c7-4310-a0eb-384f5585eb29',NULL,'registration-page-form','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','eefd9a0d-8ece-4c9b-9bba-164397f5bab0',0,10,_binary '','e398ea66-010a-4597-ab17-479b9048ec83',NULL),('b8549913-a3bb-4d78-94c4-29829fa9f4e4',NULL,'registration-user-creation','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','e398ea66-010a-4597-ab17-479b9048ec83',0,20,_binary '\0',NULL,NULL),('c487c4b2-6742-4f68-899f-5edf4ea09961',NULL,'idp-username-password-form','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','159187e0-9eea-423e-94b5-2fc337a5ff99',0,10,_binary '\0',NULL,NULL),('cea58f33-7c9e-4a4a-b63b-2438ec491895',NULL,NULL,'7f59a3db-3ce6-4735-8d4e-b391c4609bcb','5e1b6c13-7fc8-423a-91df-a9d33b8021a4',1,30,_binary '','ef116e61-0b26-4ddf-b39e-a135322fb264',NULL),('dd000ea3-e57b-4ad1-bf92-e9a9a4a7f3cd',NULL,'identity-provider-redirector','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','64f2e709-d32f-46e4-b1cf-d7e4b5fd670d',2,25,_binary '\0',NULL,NULL),('deac4827-68b0-48c8-b1e1-ac81b15c78b0',NULL,'reset-credentials-choose-user','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','7f22d11d-1f1c-4687-9cc3-c44b1fb39002',0,10,_binary '\0',NULL,NULL),('df13005d-0042-42c0-bcb6-4aa15a01bef1',NULL,'http-basic-authenticator','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','b84d91e2-470d-476e-ac23-d2c4e3984f32',0,10,_binary '\0',NULL,NULL),('e9e65864-a7b4-4746-ac64-26c46b0a970f',NULL,'reset-password','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','7f22d11d-1f1c-4687-9cc3-c44b1fb39002',0,30,_binary '\0',NULL,NULL),('f135d7e1-c8d1-458a-8ae5-c4ac0ba2ac29',NULL,NULL,'7f59a3db-3ce6-4735-8d4e-b391c4609bcb','c0aac3a0-2173-4333-996c-4aae337fd5af',0,20,_binary '','6ac5ae26-105d-409c-9f62-e69224a4705e',NULL),('f1d5e80b-c02d-413b-943b-3ca0ea561b46',NULL,NULL,'7f59a3db-3ce6-4735-8d4e-b391c4609bcb','7f22d11d-1f1c-4687-9cc3-c44b1fb39002',1,40,_binary '','338ba83d-aacd-4f6b-9c54-a5e694e967c6',NULL),('f4e25ca4-896a-4c30-b1c2-e67d009bfc98',NULL,'conditional-user-configured','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','ef116e61-0b26-4ddf-b39e-a135322fb264',0,10,_binary '\0',NULL,NULL),('f548f919-2a54-4447-bc70-dbaf01ac7d4e',NULL,'client-secret-jwt','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','858a2ecc-22ef-4d3d-9512-0858a1ca0286',2,30,_binary '\0',NULL,NULL),('f7f9a583-b517-4266-af06-61e39e7bb6b9',NULL,'direct-grant-validate-otp','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','ef116e61-0b26-4ddf-b39e-a135322fb264',0,20,_binary '\0',NULL,NULL),('f987f1a7-7d9a-46a3-b0dc-d11b8004510b',NULL,'auth-cookie','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','64f2e709-d32f-46e4-b1cf-d7e4b5fd670d',2,10,_binary '\0',NULL,NULL),('fb29c5b9-b8ba-4476-9f3b-13fbe56bfa7e',NULL,'registration-recaptcha-action','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','e398ea66-010a-4597-ab17-479b9048ec83',3,60,_binary '\0',NULL,NULL),('fba6a6ea-048e-4453-bbe7-563bbf52c5c0',NULL,'conditional-user-configured','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','338ba83d-aacd-4f6b-9c54-a5e694e967c6',0,10,_binary '\0',NULL,NULL),('febf2855-aaba-44b0-868e-60b7f83e4205',NULL,'conditional-user-configured','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','cef77b3f-eb45-420d-842a-f55a2631aa3f',0,10,_binary '\0',NULL,NULL);
/*!40000 ALTER TABLE `AUTHENTICATION_EXECUTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AUTHENTICATION_FLOW`
--

DROP TABLE IF EXISTS `AUTHENTICATION_FLOW`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AUTHENTICATION_FLOW` (
  `ID` varchar(36) NOT NULL,
  `ALIAS` varchar(255) DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `PROVIDER_ID` varchar(36) NOT NULL DEFAULT 'basic-flow',
  `TOP_LEVEL` bit(1) NOT NULL DEFAULT b'0',
  `BUILT_IN` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`ID`),
  KEY `IDX_AUTH_FLOW_REALM` (`REALM_ID`),
  CONSTRAINT `FK_AUTH_FLOW_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AUTHENTICATION_FLOW`
--

LOCK TABLES `AUTHENTICATION_FLOW` WRITE;
/*!40000 ALTER TABLE `AUTHENTICATION_FLOW` DISABLE KEYS */;
INSERT INTO `AUTHENTICATION_FLOW` VALUES ('12424ecd-3e5a-4c16-b1d2-e45f49baf9a7','forms','Username, password, otp and other auth forms.','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','basic-flow',_binary '\0',_binary ''),('159187e0-9eea-423e-94b5-2fc337a5ff99','Verify Existing Account by Re-authentication','Reauthentication of existing account','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','basic-flow',_binary '\0',_binary ''),('338ba83d-aacd-4f6b-9c54-a5e694e967c6','Reset - Conditional OTP','Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','basic-flow',_binary '\0',_binary ''),('3a865def-8d0c-4a91-b81e-e22a037c77e1','Browser - Conditional OTP','Flow to determine if the OTP is required for the authentication','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','basic-flow',_binary '\0',_binary ''),('5e1b6c13-7fc8-423a-91df-a9d33b8021a4','direct grant','OpenID Connect Resource Owner Grant','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','basic-flow',_binary '',_binary ''),('64f2e709-d32f-46e4-b1cf-d7e4b5fd670d','browser','browser based authentication','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','basic-flow',_binary '',_binary ''),('6ac5ae26-105d-409c-9f62-e69224a4705e','User creation or linking','Flow for the existing/non-existing user alternatives','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','basic-flow',_binary '\0',_binary ''),('7f22d11d-1f1c-4687-9cc3-c44b1fb39002','reset credentials','Reset credentials for a user if they forgot their password or something','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','basic-flow',_binary '',_binary ''),('845fe7dc-15b8-4ba3-99c7-67f600622813','docker auth','Used by Docker clients to authenticate against the IDP','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','basic-flow',_binary '',_binary ''),('858a2ecc-22ef-4d3d-9512-0858a1ca0286','clients','Base authentication for clients','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','client-flow',_binary '',_binary ''),('92c9a961-7c6c-42ab-85c7-baa141f6c5ce','Handle Existing Account','Handle what to do if there is existing account with same email/username like authenticated identity provider','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','basic-flow',_binary '\0',_binary ''),('9fd57deb-b9fc-429b-b5bb-a5f6e4ac0a86','Account verification options','Method with which to verity the existing account','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','basic-flow',_binary '\0',_binary ''),('b84d91e2-470d-476e-ac23-d2c4e3984f32','saml ecp','SAML ECP Profile Authentication Flow','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','basic-flow',_binary '',_binary ''),('c0aac3a0-2173-4333-996c-4aae337fd5af','first broker login','Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','basic-flow',_binary '',_binary ''),('cef77b3f-eb45-420d-842a-f55a2631aa3f','First broker login - Conditional OTP','Flow to determine if the OTP is required for the authentication','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','basic-flow',_binary '\0',_binary ''),('e398ea66-010a-4597-ab17-479b9048ec83','registration form','registration form','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','form-flow',_binary '\0',_binary ''),('eefd9a0d-8ece-4c9b-9bba-164397f5bab0','registration','registration flow','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','basic-flow',_binary '',_binary ''),('ef116e61-0b26-4ddf-b39e-a135322fb264','Direct Grant - Conditional OTP','Flow to determine if the OTP is required for the authentication','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','basic-flow',_binary '\0',_binary '');
/*!40000 ALTER TABLE `AUTHENTICATION_FLOW` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AUTHENTICATOR_CONFIG`
--

DROP TABLE IF EXISTS `AUTHENTICATOR_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AUTHENTICATOR_CONFIG` (
  `ID` varchar(36) NOT NULL,
  `ALIAS` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_AUTH_CONFIG_REALM` (`REALM_ID`),
  CONSTRAINT `FK_AUTH_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AUTHENTICATOR_CONFIG`
--

LOCK TABLES `AUTHENTICATOR_CONFIG` WRITE;
/*!40000 ALTER TABLE `AUTHENTICATOR_CONFIG` DISABLE KEYS */;
INSERT INTO `AUTHENTICATOR_CONFIG` VALUES ('573873f4-f565-44cf-a5d8-059c6e41a156','create unique user config','7f59a3db-3ce6-4735-8d4e-b391c4609bcb'),('e1aff667-d743-4354-9ffc-091881bbf10f','review profile config','7f59a3db-3ce6-4735-8d4e-b391c4609bcb');
/*!40000 ALTER TABLE `AUTHENTICATOR_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AUTHENTICATOR_CONFIG_ENTRY`
--

DROP TABLE IF EXISTS `AUTHENTICATOR_CONFIG_ENTRY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AUTHENTICATOR_CONFIG_ENTRY` (
  `AUTHENTICATOR_ID` varchar(36) NOT NULL,
  `VALUE` longtext,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`AUTHENTICATOR_ID`,`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AUTHENTICATOR_CONFIG_ENTRY`
--

LOCK TABLES `AUTHENTICATOR_CONFIG_ENTRY` WRITE;
/*!40000 ALTER TABLE `AUTHENTICATOR_CONFIG_ENTRY` DISABLE KEYS */;
INSERT INTO `AUTHENTICATOR_CONFIG_ENTRY` VALUES ('573873f4-f565-44cf-a5d8-059c6e41a156','false','require.password.update.after.registration'),('e1aff667-d743-4354-9ffc-091881bbf10f','missing','update.profile.on.first.login');
/*!40000 ALTER TABLE `AUTHENTICATOR_CONFIG_ENTRY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BROKER_LINK`
--

DROP TABLE IF EXISTS `BROKER_LINK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BROKER_LINK` (
  `IDENTITY_PROVIDER` varchar(255) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `BROKER_USER_ID` varchar(255) DEFAULT NULL,
  `BROKER_USERNAME` varchar(255) DEFAULT NULL,
  `TOKEN` text,
  `USER_ID` varchar(255) NOT NULL,
  PRIMARY KEY (`IDENTITY_PROVIDER`,`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BROKER_LINK`
--

LOCK TABLES `BROKER_LINK` WRITE;
/*!40000 ALTER TABLE `BROKER_LINK` DISABLE KEYS */;
/*!40000 ALTER TABLE `BROKER_LINK` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT`
--

DROP TABLE IF EXISTS `CLIENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT` (
  `ID` varchar(36) NOT NULL,
  `ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `FULL_SCOPE_ALLOWED` bit(1) NOT NULL DEFAULT b'0',
  `CLIENT_ID` varchar(255) DEFAULT NULL,
  `NOT_BEFORE` int DEFAULT NULL,
  `PUBLIC_CLIENT` bit(1) NOT NULL DEFAULT b'0',
  `SECRET` varchar(255) DEFAULT NULL,
  `BASE_URL` varchar(255) DEFAULT NULL,
  `BEARER_ONLY` bit(1) NOT NULL DEFAULT b'0',
  `MANAGEMENT_URL` varchar(255) DEFAULT NULL,
  `SURROGATE_AUTH_REQUIRED` bit(1) NOT NULL DEFAULT b'0',
  `REALM_ID` varchar(36) DEFAULT NULL,
  `PROTOCOL` varchar(255) DEFAULT NULL,
  `NODE_REREG_TIMEOUT` int DEFAULT '0',
  `FRONTCHANNEL_LOGOUT` bit(1) NOT NULL DEFAULT b'0',
  `CONSENT_REQUIRED` bit(1) NOT NULL DEFAULT b'0',
  `NAME` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `SERVICE_ACCOUNTS_ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `CLIENT_AUTHENTICATOR_TYPE` varchar(255) DEFAULT NULL,
  `ROOT_URL` varchar(255) DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `REGISTRATION_TOKEN` varchar(255) DEFAULT NULL,
  `STANDARD_FLOW_ENABLED` bit(1) NOT NULL DEFAULT b'1',
  `IMPLICIT_FLOW_ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `DIRECT_ACCESS_GRANTS_ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `ALWAYS_DISPLAY_IN_CONSOLE` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_B71CJLBENV945RB6GCON438AT` (`REALM_ID`,`CLIENT_ID`),
  KEY `IDX_CLIENT_ID` (`CLIENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT`
--

LOCK TABLES `CLIENT` WRITE;
/*!40000 ALTER TABLE `CLIENT` DISABLE KEYS */;
INSERT INTO `CLIENT` VALUES ('3cae072d-233a-4922-b913-1966d129113a',_binary '',_binary '\0','account',0,_binary '',NULL,'/realms/master/account/',_binary '\0',NULL,_binary '\0','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','openid-connect',0,_binary '\0',_binary '\0','${client_account}',_binary '\0','client-secret','${authBaseUrl}',NULL,NULL,_binary '',_binary '\0',_binary '\0',_binary '\0'),('6a200eb6-3191-496c-8e4c-dbf67658fd2e',_binary '',_binary '\0','master-realm',0,_binary '\0',NULL,NULL,_binary '',NULL,_binary '\0','7f59a3db-3ce6-4735-8d4e-b391c4609bcb',NULL,0,_binary '\0',_binary '\0','master Realm',_binary '\0','client-secret',NULL,NULL,NULL,_binary '',_binary '\0',_binary '\0',_binary '\0'),('77bec48a-5470-45a3-bfd6-8fe16883bbf4',_binary '',_binary '\0','account-console',0,_binary '',NULL,'/realms/master/account/',_binary '\0',NULL,_binary '\0','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','openid-connect',0,_binary '\0',_binary '\0','${client_account-console}',_binary '\0','client-secret','${authBaseUrl}',NULL,NULL,_binary '',_binary '\0',_binary '\0',_binary '\0'),('91fbe4fb-e4b5-4a4b-b6d5-bf80c4f4fe6a',_binary '',_binary '\0','broker',0,_binary '\0',NULL,NULL,_binary '',NULL,_binary '\0','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','openid-connect',0,_binary '\0',_binary '\0','${client_broker}',_binary '\0','client-secret',NULL,NULL,NULL,_binary '',_binary '\0',_binary '\0',_binary '\0'),('a1724120-09b9-4727-b44b-69735af49212',_binary '',_binary '','iv-mvn',0,_binary '\0','XKNTocHpUfEhTC01Ve1jyDec6DDtDOVD','http://localhost',_binary '\0','http://localhost',_binary '\0','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','openid-connect',-1,_binary '',_binary '\0','iv-mvn',_binary '','client-secret','http://localhost','',NULL,_binary '',_binary '\0',_binary '\0',_binary '\0'),('cbfd0f73-0e6f-43a4-b34d-43b091f30ee7',_binary '',_binary '\0','admin-cli',0,_binary '',NULL,NULL,_binary '\0',NULL,_binary '\0','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','openid-connect',0,_binary '\0',_binary '\0','${client_admin-cli}',_binary '\0','client-secret',NULL,NULL,NULL,_binary '\0',_binary '\0',_binary '',_binary '\0'),('ef4d1c45-b293-4ce2-b700-2ef194731ba1',_binary '',_binary '\0','security-admin-console',0,_binary '',NULL,'/admin/master/console/',_binary '\0',NULL,_binary '\0','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','openid-connect',0,_binary '\0',_binary '\0','${client_security-admin-console}',_binary '\0','client-secret','${authAdminUrl}',NULL,NULL,_binary '',_binary '\0',_binary '\0',_binary '\0');
/*!40000 ALTER TABLE `CLIENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_ATTRIBUTES`
--

DROP TABLE IF EXISTS `CLIENT_ATTRIBUTES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_ATTRIBUTES` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VALUE` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  PRIMARY KEY (`CLIENT_ID`,`NAME`),
  KEY `IDX_CLIENT_ATT_BY_NAME_VALUE` (`NAME`),
  CONSTRAINT `FK3C47C64BEACCA966` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_ATTRIBUTES`
--

LOCK TABLES `CLIENT_ATTRIBUTES` WRITE;
/*!40000 ALTER TABLE `CLIENT_ATTRIBUTES` DISABLE KEYS */;
INSERT INTO `CLIENT_ATTRIBUTES` VALUES ('3cae072d-233a-4922-b913-1966d129113a','post.logout.redirect.uris','+'),('77bec48a-5470-45a3-bfd6-8fe16883bbf4','pkce.code.challenge.method','S256'),('77bec48a-5470-45a3-bfd6-8fe16883bbf4','post.logout.redirect.uris','+'),('a1724120-09b9-4727-b44b-69735af49212','backchannel.logout.revoke.offline.tokens','false'),('a1724120-09b9-4727-b44b-69735af49212','backchannel.logout.session.required','true'),('a1724120-09b9-4727-b44b-69735af49212','client.secret.creation.time','1710097756'),('a1724120-09b9-4727-b44b-69735af49212','display.on.consent.screen','false'),('a1724120-09b9-4727-b44b-69735af49212','oauth2.device.authorization.grant.enabled','false'),('a1724120-09b9-4727-b44b-69735af49212','oidc.ciba.grant.enabled','false'),('ef4d1c45-b293-4ce2-b700-2ef194731ba1','pkce.code.challenge.method','S256'),('ef4d1c45-b293-4ce2-b700-2ef194731ba1','post.logout.redirect.uris','+');
/*!40000 ALTER TABLE `CLIENT_ATTRIBUTES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_AUTH_FLOW_BINDINGS`
--

DROP TABLE IF EXISTS `CLIENT_AUTH_FLOW_BINDINGS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_AUTH_FLOW_BINDINGS` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `FLOW_ID` varchar(36) DEFAULT NULL,
  `BINDING_NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`CLIENT_ID`,`BINDING_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_AUTH_FLOW_BINDINGS`
--

LOCK TABLES `CLIENT_AUTH_FLOW_BINDINGS` WRITE;
/*!40000 ALTER TABLE `CLIENT_AUTH_FLOW_BINDINGS` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_AUTH_FLOW_BINDINGS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_INITIAL_ACCESS`
--

DROP TABLE IF EXISTS `CLIENT_INITIAL_ACCESS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_INITIAL_ACCESS` (
  `ID` varchar(36) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `TIMESTAMP` int DEFAULT NULL,
  `EXPIRATION` int DEFAULT NULL,
  `COUNT` int DEFAULT NULL,
  `REMAINING_COUNT` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_CLIENT_INIT_ACC_REALM` (`REALM_ID`),
  CONSTRAINT `FK_CLIENT_INIT_ACC_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_INITIAL_ACCESS`
--

LOCK TABLES `CLIENT_INITIAL_ACCESS` WRITE;
/*!40000 ALTER TABLE `CLIENT_INITIAL_ACCESS` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_INITIAL_ACCESS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_NODE_REGISTRATIONS`
--

DROP TABLE IF EXISTS `CLIENT_NODE_REGISTRATIONS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_NODE_REGISTRATIONS` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `VALUE` int DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`CLIENT_ID`,`NAME`),
  CONSTRAINT `FK4129723BA992F594` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_NODE_REGISTRATIONS`
--

LOCK TABLES `CLIENT_NODE_REGISTRATIONS` WRITE;
/*!40000 ALTER TABLE `CLIENT_NODE_REGISTRATIONS` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_NODE_REGISTRATIONS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SCOPE`
--

DROP TABLE IF EXISTS `CLIENT_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_SCOPE` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `PROTOCOL` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_CLI_SCOPE` (`REALM_ID`,`NAME`),
  KEY `IDX_REALM_CLSCOPE` (`REALM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SCOPE`
--

LOCK TABLES `CLIENT_SCOPE` WRITE;
/*!40000 ALTER TABLE `CLIENT_SCOPE` DISABLE KEYS */;
INSERT INTO `CLIENT_SCOPE` VALUES ('13e567cb-710f-4e81-b6dd-022d00453330','email','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','OpenID Connect built-in scope: email','openid-connect'),('5758a2d8-b31c-47a7-822a-03089b8b6e2d','profile','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','OpenID Connect built-in scope: profile','openid-connect'),('651c9698-aaaf-437b-be5f-e1fc8a2a9538','acr','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','OpenID Connect scope for add acr (authentication context class reference) to the token','openid-connect'),('705952de-5767-4911-9def-668a8e40647e','web-origins','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','OpenID Connect scope for add allowed web origins to the access token','openid-connect'),('7df8d38e-89af-4a79-93df-073190a8d983','roles','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','OpenID Connect scope for add user roles to the access token','openid-connect'),('8470c070-3cc4-4967-b4e3-502459d8d5cd','address','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','OpenID Connect built-in scope: address','openid-connect'),('9028e6ec-23ba-474f-b0ae-2b7e75257d33','role_list','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','SAML role list','saml'),('c52269a0-72c8-48f0-b43a-bce7c1afc81a','microprofile-jwt','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','Microprofile - JWT built-in scope','openid-connect'),('de8cf540-cc3c-48ae-a8f8-b9c698bcf422','phone','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','OpenID Connect built-in scope: phone','openid-connect'),('e25c4206-b8b5-4cc7-b224-906210e66aed','offline_access','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','OpenID Connect built-in scope: offline_access','openid-connect');
/*!40000 ALTER TABLE `CLIENT_SCOPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SCOPE_ATTRIBUTES`
--

DROP TABLE IF EXISTS `CLIENT_SCOPE_ATTRIBUTES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_SCOPE_ATTRIBUTES` (
  `SCOPE_ID` varchar(36) NOT NULL,
  `VALUE` text,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`SCOPE_ID`,`NAME`),
  KEY `IDX_CLSCOPE_ATTRS` (`SCOPE_ID`),
  CONSTRAINT `FK_CL_SCOPE_ATTR_SCOPE` FOREIGN KEY (`SCOPE_ID`) REFERENCES `CLIENT_SCOPE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SCOPE_ATTRIBUTES`
--

LOCK TABLES `CLIENT_SCOPE_ATTRIBUTES` WRITE;
/*!40000 ALTER TABLE `CLIENT_SCOPE_ATTRIBUTES` DISABLE KEYS */;
INSERT INTO `CLIENT_SCOPE_ATTRIBUTES` VALUES ('13e567cb-710f-4e81-b6dd-022d00453330','${emailScopeConsentText}','consent.screen.text'),('13e567cb-710f-4e81-b6dd-022d00453330','true','display.on.consent.screen'),('13e567cb-710f-4e81-b6dd-022d00453330','true','include.in.token.scope'),('5758a2d8-b31c-47a7-822a-03089b8b6e2d','${profileScopeConsentText}','consent.screen.text'),('5758a2d8-b31c-47a7-822a-03089b8b6e2d','true','display.on.consent.screen'),('5758a2d8-b31c-47a7-822a-03089b8b6e2d','true','include.in.token.scope'),('651c9698-aaaf-437b-be5f-e1fc8a2a9538','false','display.on.consent.screen'),('651c9698-aaaf-437b-be5f-e1fc8a2a9538','false','include.in.token.scope'),('705952de-5767-4911-9def-668a8e40647e','','consent.screen.text'),('705952de-5767-4911-9def-668a8e40647e','false','display.on.consent.screen'),('705952de-5767-4911-9def-668a8e40647e','false','include.in.token.scope'),('7df8d38e-89af-4a79-93df-073190a8d983','${rolesScopeConsentText}','consent.screen.text'),('7df8d38e-89af-4a79-93df-073190a8d983','true','display.on.consent.screen'),('7df8d38e-89af-4a79-93df-073190a8d983','false','include.in.token.scope'),('8470c070-3cc4-4967-b4e3-502459d8d5cd','${addressScopeConsentText}','consent.screen.text'),('8470c070-3cc4-4967-b4e3-502459d8d5cd','true','display.on.consent.screen'),('8470c070-3cc4-4967-b4e3-502459d8d5cd','true','include.in.token.scope'),('9028e6ec-23ba-474f-b0ae-2b7e75257d33','${samlRoleListScopeConsentText}','consent.screen.text'),('9028e6ec-23ba-474f-b0ae-2b7e75257d33','true','display.on.consent.screen'),('c52269a0-72c8-48f0-b43a-bce7c1afc81a','false','display.on.consent.screen'),('c52269a0-72c8-48f0-b43a-bce7c1afc81a','true','include.in.token.scope'),('de8cf540-cc3c-48ae-a8f8-b9c698bcf422','${phoneScopeConsentText}','consent.screen.text'),('de8cf540-cc3c-48ae-a8f8-b9c698bcf422','true','display.on.consent.screen'),('de8cf540-cc3c-48ae-a8f8-b9c698bcf422','true','include.in.token.scope'),('e25c4206-b8b5-4cc7-b224-906210e66aed','${offlineAccessScopeConsentText}','consent.screen.text'),('e25c4206-b8b5-4cc7-b224-906210e66aed','true','display.on.consent.screen');
/*!40000 ALTER TABLE `CLIENT_SCOPE_ATTRIBUTES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SCOPE_CLIENT`
--

DROP TABLE IF EXISTS `CLIENT_SCOPE_CLIENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_SCOPE_CLIENT` (
  `CLIENT_ID` varchar(255) NOT NULL,
  `SCOPE_ID` varchar(255) NOT NULL,
  `DEFAULT_SCOPE` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`CLIENT_ID`,`SCOPE_ID`),
  KEY `IDX_CLSCOPE_CL` (`CLIENT_ID`),
  KEY `IDX_CL_CLSCOPE` (`SCOPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SCOPE_CLIENT`
--

LOCK TABLES `CLIENT_SCOPE_CLIENT` WRITE;
/*!40000 ALTER TABLE `CLIENT_SCOPE_CLIENT` DISABLE KEYS */;
INSERT INTO `CLIENT_SCOPE_CLIENT` VALUES ('3cae072d-233a-4922-b913-1966d129113a','13e567cb-710f-4e81-b6dd-022d00453330',_binary ''),('3cae072d-233a-4922-b913-1966d129113a','5758a2d8-b31c-47a7-822a-03089b8b6e2d',_binary ''),('3cae072d-233a-4922-b913-1966d129113a','651c9698-aaaf-437b-be5f-e1fc8a2a9538',_binary ''),('3cae072d-233a-4922-b913-1966d129113a','705952de-5767-4911-9def-668a8e40647e',_binary ''),('3cae072d-233a-4922-b913-1966d129113a','7df8d38e-89af-4a79-93df-073190a8d983',_binary ''),('3cae072d-233a-4922-b913-1966d129113a','8470c070-3cc4-4967-b4e3-502459d8d5cd',_binary '\0'),('3cae072d-233a-4922-b913-1966d129113a','c52269a0-72c8-48f0-b43a-bce7c1afc81a',_binary '\0'),('3cae072d-233a-4922-b913-1966d129113a','de8cf540-cc3c-48ae-a8f8-b9c698bcf422',_binary '\0'),('3cae072d-233a-4922-b913-1966d129113a','e25c4206-b8b5-4cc7-b224-906210e66aed',_binary '\0'),('6a200eb6-3191-496c-8e4c-dbf67658fd2e','13e567cb-710f-4e81-b6dd-022d00453330',_binary ''),('6a200eb6-3191-496c-8e4c-dbf67658fd2e','5758a2d8-b31c-47a7-822a-03089b8b6e2d',_binary ''),('6a200eb6-3191-496c-8e4c-dbf67658fd2e','651c9698-aaaf-437b-be5f-e1fc8a2a9538',_binary ''),('6a200eb6-3191-496c-8e4c-dbf67658fd2e','705952de-5767-4911-9def-668a8e40647e',_binary ''),('6a200eb6-3191-496c-8e4c-dbf67658fd2e','7df8d38e-89af-4a79-93df-073190a8d983',_binary ''),('6a200eb6-3191-496c-8e4c-dbf67658fd2e','8470c070-3cc4-4967-b4e3-502459d8d5cd',_binary '\0'),('6a200eb6-3191-496c-8e4c-dbf67658fd2e','c52269a0-72c8-48f0-b43a-bce7c1afc81a',_binary '\0'),('6a200eb6-3191-496c-8e4c-dbf67658fd2e','de8cf540-cc3c-48ae-a8f8-b9c698bcf422',_binary '\0'),('6a200eb6-3191-496c-8e4c-dbf67658fd2e','e25c4206-b8b5-4cc7-b224-906210e66aed',_binary '\0'),('77bec48a-5470-45a3-bfd6-8fe16883bbf4','13e567cb-710f-4e81-b6dd-022d00453330',_binary ''),('77bec48a-5470-45a3-bfd6-8fe16883bbf4','5758a2d8-b31c-47a7-822a-03089b8b6e2d',_binary ''),('77bec48a-5470-45a3-bfd6-8fe16883bbf4','651c9698-aaaf-437b-be5f-e1fc8a2a9538',_binary ''),('77bec48a-5470-45a3-bfd6-8fe16883bbf4','705952de-5767-4911-9def-668a8e40647e',_binary ''),('77bec48a-5470-45a3-bfd6-8fe16883bbf4','7df8d38e-89af-4a79-93df-073190a8d983',_binary ''),('77bec48a-5470-45a3-bfd6-8fe16883bbf4','8470c070-3cc4-4967-b4e3-502459d8d5cd',_binary '\0'),('77bec48a-5470-45a3-bfd6-8fe16883bbf4','c52269a0-72c8-48f0-b43a-bce7c1afc81a',_binary '\0'),('77bec48a-5470-45a3-bfd6-8fe16883bbf4','de8cf540-cc3c-48ae-a8f8-b9c698bcf422',_binary '\0'),('77bec48a-5470-45a3-bfd6-8fe16883bbf4','e25c4206-b8b5-4cc7-b224-906210e66aed',_binary '\0'),('91fbe4fb-e4b5-4a4b-b6d5-bf80c4f4fe6a','13e567cb-710f-4e81-b6dd-022d00453330',_binary ''),('91fbe4fb-e4b5-4a4b-b6d5-bf80c4f4fe6a','5758a2d8-b31c-47a7-822a-03089b8b6e2d',_binary ''),('91fbe4fb-e4b5-4a4b-b6d5-bf80c4f4fe6a','651c9698-aaaf-437b-be5f-e1fc8a2a9538',_binary ''),('91fbe4fb-e4b5-4a4b-b6d5-bf80c4f4fe6a','705952de-5767-4911-9def-668a8e40647e',_binary ''),('91fbe4fb-e4b5-4a4b-b6d5-bf80c4f4fe6a','7df8d38e-89af-4a79-93df-073190a8d983',_binary ''),('91fbe4fb-e4b5-4a4b-b6d5-bf80c4f4fe6a','8470c070-3cc4-4967-b4e3-502459d8d5cd',_binary '\0'),('91fbe4fb-e4b5-4a4b-b6d5-bf80c4f4fe6a','c52269a0-72c8-48f0-b43a-bce7c1afc81a',_binary '\0'),('91fbe4fb-e4b5-4a4b-b6d5-bf80c4f4fe6a','de8cf540-cc3c-48ae-a8f8-b9c698bcf422',_binary '\0'),('91fbe4fb-e4b5-4a4b-b6d5-bf80c4f4fe6a','e25c4206-b8b5-4cc7-b224-906210e66aed',_binary '\0'),('a1724120-09b9-4727-b44b-69735af49212','13e567cb-710f-4e81-b6dd-022d00453330',_binary ''),('a1724120-09b9-4727-b44b-69735af49212','5758a2d8-b31c-47a7-822a-03089b8b6e2d',_binary ''),('a1724120-09b9-4727-b44b-69735af49212','651c9698-aaaf-437b-be5f-e1fc8a2a9538',_binary ''),('a1724120-09b9-4727-b44b-69735af49212','705952de-5767-4911-9def-668a8e40647e',_binary ''),('a1724120-09b9-4727-b44b-69735af49212','7df8d38e-89af-4a79-93df-073190a8d983',_binary ''),('a1724120-09b9-4727-b44b-69735af49212','8470c070-3cc4-4967-b4e3-502459d8d5cd',_binary '\0'),('a1724120-09b9-4727-b44b-69735af49212','c52269a0-72c8-48f0-b43a-bce7c1afc81a',_binary '\0'),('a1724120-09b9-4727-b44b-69735af49212','de8cf540-cc3c-48ae-a8f8-b9c698bcf422',_binary '\0'),('a1724120-09b9-4727-b44b-69735af49212','e25c4206-b8b5-4cc7-b224-906210e66aed',_binary '\0'),('cbfd0f73-0e6f-43a4-b34d-43b091f30ee7','13e567cb-710f-4e81-b6dd-022d00453330',_binary ''),('cbfd0f73-0e6f-43a4-b34d-43b091f30ee7','5758a2d8-b31c-47a7-822a-03089b8b6e2d',_binary ''),('cbfd0f73-0e6f-43a4-b34d-43b091f30ee7','651c9698-aaaf-437b-be5f-e1fc8a2a9538',_binary ''),('cbfd0f73-0e6f-43a4-b34d-43b091f30ee7','705952de-5767-4911-9def-668a8e40647e',_binary ''),('cbfd0f73-0e6f-43a4-b34d-43b091f30ee7','7df8d38e-89af-4a79-93df-073190a8d983',_binary ''),('cbfd0f73-0e6f-43a4-b34d-43b091f30ee7','8470c070-3cc4-4967-b4e3-502459d8d5cd',_binary '\0'),('cbfd0f73-0e6f-43a4-b34d-43b091f30ee7','c52269a0-72c8-48f0-b43a-bce7c1afc81a',_binary '\0'),('cbfd0f73-0e6f-43a4-b34d-43b091f30ee7','de8cf540-cc3c-48ae-a8f8-b9c698bcf422',_binary '\0'),('cbfd0f73-0e6f-43a4-b34d-43b091f30ee7','e25c4206-b8b5-4cc7-b224-906210e66aed',_binary '\0'),('ef4d1c45-b293-4ce2-b700-2ef194731ba1','13e567cb-710f-4e81-b6dd-022d00453330',_binary ''),('ef4d1c45-b293-4ce2-b700-2ef194731ba1','5758a2d8-b31c-47a7-822a-03089b8b6e2d',_binary ''),('ef4d1c45-b293-4ce2-b700-2ef194731ba1','651c9698-aaaf-437b-be5f-e1fc8a2a9538',_binary ''),('ef4d1c45-b293-4ce2-b700-2ef194731ba1','705952de-5767-4911-9def-668a8e40647e',_binary ''),('ef4d1c45-b293-4ce2-b700-2ef194731ba1','7df8d38e-89af-4a79-93df-073190a8d983',_binary ''),('ef4d1c45-b293-4ce2-b700-2ef194731ba1','8470c070-3cc4-4967-b4e3-502459d8d5cd',_binary '\0'),('ef4d1c45-b293-4ce2-b700-2ef194731ba1','c52269a0-72c8-48f0-b43a-bce7c1afc81a',_binary '\0'),('ef4d1c45-b293-4ce2-b700-2ef194731ba1','de8cf540-cc3c-48ae-a8f8-b9c698bcf422',_binary '\0'),('ef4d1c45-b293-4ce2-b700-2ef194731ba1','e25c4206-b8b5-4cc7-b224-906210e66aed',_binary '\0');
/*!40000 ALTER TABLE `CLIENT_SCOPE_CLIENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SCOPE_ROLE_MAPPING`
--

DROP TABLE IF EXISTS `CLIENT_SCOPE_ROLE_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_SCOPE_ROLE_MAPPING` (
  `SCOPE_ID` varchar(36) NOT NULL,
  `ROLE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`SCOPE_ID`,`ROLE_ID`),
  KEY `IDX_CLSCOPE_ROLE` (`SCOPE_ID`),
  KEY `IDX_ROLE_CLSCOPE` (`ROLE_ID`),
  CONSTRAINT `FK_CL_SCOPE_RM_SCOPE` FOREIGN KEY (`SCOPE_ID`) REFERENCES `CLIENT_SCOPE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SCOPE_ROLE_MAPPING`
--

LOCK TABLES `CLIENT_SCOPE_ROLE_MAPPING` WRITE;
/*!40000 ALTER TABLE `CLIENT_SCOPE_ROLE_MAPPING` DISABLE KEYS */;
INSERT INTO `CLIENT_SCOPE_ROLE_MAPPING` VALUES ('e25c4206-b8b5-4cc7-b224-906210e66aed','191ab440-a308-4c46-8dbd-f93634ed29c0');
/*!40000 ALTER TABLE `CLIENT_SCOPE_ROLE_MAPPING` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SESSION`
--

DROP TABLE IF EXISTS `CLIENT_SESSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_SESSION` (
  `ID` varchar(36) NOT NULL,
  `CLIENT_ID` varchar(36) DEFAULT NULL,
  `REDIRECT_URI` varchar(255) DEFAULT NULL,
  `STATE` varchar(255) DEFAULT NULL,
  `TIMESTAMP` int DEFAULT NULL,
  `SESSION_ID` varchar(36) DEFAULT NULL,
  `AUTH_METHOD` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `AUTH_USER_ID` varchar(36) DEFAULT NULL,
  `CURRENT_ACTION` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_CLIENT_SESSION_SESSION` (`SESSION_ID`),
  CONSTRAINT `FK_B4AO2VCVAT6UKAU74WBWTFQO1` FOREIGN KEY (`SESSION_ID`) REFERENCES `USER_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SESSION`
--

LOCK TABLES `CLIENT_SESSION` WRITE;
/*!40000 ALTER TABLE `CLIENT_SESSION` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_SESSION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SESSION_AUTH_STATUS`
--

DROP TABLE IF EXISTS `CLIENT_SESSION_AUTH_STATUS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_SESSION_AUTH_STATUS` (
  `AUTHENTICATOR` varchar(36) NOT NULL,
  `STATUS` int DEFAULT NULL,
  `CLIENT_SESSION` varchar(36) NOT NULL,
  PRIMARY KEY (`CLIENT_SESSION`,`AUTHENTICATOR`),
  CONSTRAINT `AUTH_STATUS_CONSTRAINT` FOREIGN KEY (`CLIENT_SESSION`) REFERENCES `CLIENT_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SESSION_AUTH_STATUS`
--

LOCK TABLES `CLIENT_SESSION_AUTH_STATUS` WRITE;
/*!40000 ALTER TABLE `CLIENT_SESSION_AUTH_STATUS` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_SESSION_AUTH_STATUS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SESSION_NOTE`
--

DROP TABLE IF EXISTS `CLIENT_SESSION_NOTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_SESSION_NOTE` (
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  `CLIENT_SESSION` varchar(36) NOT NULL,
  PRIMARY KEY (`CLIENT_SESSION`,`NAME`),
  CONSTRAINT `FK5EDFB00FF51C2736` FOREIGN KEY (`CLIENT_SESSION`) REFERENCES `CLIENT_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SESSION_NOTE`
--

LOCK TABLES `CLIENT_SESSION_NOTE` WRITE;
/*!40000 ALTER TABLE `CLIENT_SESSION_NOTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_SESSION_NOTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SESSION_PROT_MAPPER`
--

DROP TABLE IF EXISTS `CLIENT_SESSION_PROT_MAPPER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_SESSION_PROT_MAPPER` (
  `PROTOCOL_MAPPER_ID` varchar(36) NOT NULL,
  `CLIENT_SESSION` varchar(36) NOT NULL,
  PRIMARY KEY (`CLIENT_SESSION`,`PROTOCOL_MAPPER_ID`),
  CONSTRAINT `FK_33A8SGQW18I532811V7O2DK89` FOREIGN KEY (`CLIENT_SESSION`) REFERENCES `CLIENT_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SESSION_PROT_MAPPER`
--

LOCK TABLES `CLIENT_SESSION_PROT_MAPPER` WRITE;
/*!40000 ALTER TABLE `CLIENT_SESSION_PROT_MAPPER` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_SESSION_PROT_MAPPER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SESSION_ROLE`
--

DROP TABLE IF EXISTS `CLIENT_SESSION_ROLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_SESSION_ROLE` (
  `ROLE_ID` varchar(255) NOT NULL,
  `CLIENT_SESSION` varchar(36) NOT NULL,
  PRIMARY KEY (`CLIENT_SESSION`,`ROLE_ID`),
  CONSTRAINT `FK_11B7SGQW18I532811V7O2DV76` FOREIGN KEY (`CLIENT_SESSION`) REFERENCES `CLIENT_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SESSION_ROLE`
--

LOCK TABLES `CLIENT_SESSION_ROLE` WRITE;
/*!40000 ALTER TABLE `CLIENT_SESSION_ROLE` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_SESSION_ROLE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_USER_SESSION_NOTE`
--

DROP TABLE IF EXISTS `CLIENT_USER_SESSION_NOTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_USER_SESSION_NOTE` (
  `NAME` varchar(255) NOT NULL,
  `VALUE` text,
  `CLIENT_SESSION` varchar(36) NOT NULL,
  PRIMARY KEY (`CLIENT_SESSION`,`NAME`),
  CONSTRAINT `FK_CL_USR_SES_NOTE` FOREIGN KEY (`CLIENT_SESSION`) REFERENCES `CLIENT_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_USER_SESSION_NOTE`
--

LOCK TABLES `CLIENT_USER_SESSION_NOTE` WRITE;
/*!40000 ALTER TABLE `CLIENT_USER_SESSION_NOTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_USER_SESSION_NOTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `COMPONENT`
--

DROP TABLE IF EXISTS `COMPONENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `COMPONENT` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `PARENT_ID` varchar(36) DEFAULT NULL,
  `PROVIDER_ID` varchar(36) DEFAULT NULL,
  `PROVIDER_TYPE` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `SUB_TYPE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_COMPONENT_REALM` (`REALM_ID`),
  KEY `IDX_COMPONENT_PROVIDER_TYPE` (`PROVIDER_TYPE`),
  CONSTRAINT `FK_COMPONENT_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COMPONENT`
--

LOCK TABLES `COMPONENT` WRITE;
/*!40000 ALTER TABLE `COMPONENT` DISABLE KEYS */;
INSERT INTO `COMPONENT` VALUES ('0c69f41c-0ca8-44f8-bd31-2b2987563c2d','Full Scope Disabled','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','scope','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','anonymous'),('34bad640-3f4d-4295-9262-e954cfbf686f','Consent Required','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','consent-required','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','anonymous'),('44c6fe55-c281-4057-b772-ebac95d3094e','Allowed Client Scopes','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','allowed-client-templates','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','anonymous'),('5c8927ed-c7dd-4c67-9e5a-e63a785e40c4','rsa-generated','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','rsa-generated','org.keycloak.keys.KeyProvider','7f59a3db-3ce6-4735-8d4e-b391c4609bcb',NULL),('69895e79-bf5a-4a16-b3c5-16daa77b8b84','Trusted Hosts','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','trusted-hosts','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','anonymous'),('6f4cb54c-a896-4945-a8f3-44c337b16665','rsa-enc-generated','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','rsa-enc-generated','org.keycloak.keys.KeyProvider','7f59a3db-3ce6-4735-8d4e-b391c4609bcb',NULL),('7ebac656-8482-4c1d-bc4a-e5db2d14bba8','Allowed Protocol Mapper Types','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','allowed-protocol-mappers','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','authenticated'),('8d895720-e8c1-4c19-a8fb-708672fd3e7e','Allowed Client Scopes','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','allowed-client-templates','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','authenticated'),('90cea08a-b4ff-4f40-a598-3671eaba1684','hmac-generated','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','hmac-generated','org.keycloak.keys.KeyProvider','7f59a3db-3ce6-4735-8d4e-b391c4609bcb',NULL),('c7d4735a-b28f-4708-83f6-426ddcece9ac','Allowed Protocol Mapper Types','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','allowed-protocol-mappers','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','anonymous'),('ec094fc0-1291-496e-b909-07ada1de00da','aes-generated','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','aes-generated','org.keycloak.keys.KeyProvider','7f59a3db-3ce6-4735-8d4e-b391c4609bcb',NULL),('f58f6660-0397-43b5-9fda-4a8b8c0ed37b','Max Clients Limit','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','max-clients','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','anonymous');
/*!40000 ALTER TABLE `COMPONENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `COMPONENT_CONFIG`
--

DROP TABLE IF EXISTS `COMPONENT_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `COMPONENT_CONFIG` (
  `ID` varchar(36) NOT NULL,
  `COMPONENT_ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VALUE` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  PRIMARY KEY (`ID`),
  KEY `IDX_COMPO_CONFIG_COMPO` (`COMPONENT_ID`),
  CONSTRAINT `FK_COMPONENT_CONFIG` FOREIGN KEY (`COMPONENT_ID`) REFERENCES `COMPONENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COMPONENT_CONFIG`
--

LOCK TABLES `COMPONENT_CONFIG` WRITE;
/*!40000 ALTER TABLE `COMPONENT_CONFIG` DISABLE KEYS */;
INSERT INTO `COMPONENT_CONFIG` VALUES ('019a238c-fbd6-42bf-9eca-c143dc365c7f','c7d4735a-b28f-4708-83f6-426ddcece9ac','allowed-protocol-mapper-types','oidc-sha256-pairwise-sub-mapper'),('0ddcd7fb-2edb-435e-9a1c-73beb69bef2e','c7d4735a-b28f-4708-83f6-426ddcece9ac','allowed-protocol-mapper-types','oidc-usermodel-property-mapper'),('1c55fb82-4c97-4b73-9587-151b222bc906','6f4cb54c-a896-4945-a8f3-44c337b16665','privateKey','MIIEogIBAAKCAQEAnQrXLMG73aj/D1mzFvRxmwnr75M8oSptYxt30A4FXuBHW8Ht265PFUrXPtHKSgAfIB+RvkaMp/mUFdLfoHbE9hYl703q+Wv6bTRJPiuwXqzT0LeuBXsn74Sax45AJzLaYhZkjkCNAM8WbsCjHCC2R1g/rFYzOxtzVnlpWwPjk+m1tsUTnvdojR4nFVb2klOhBo48lODhMyAtHrbm1KMeChGIjddSnNSdDcKMM4zWulr8SsTZ15irMlm+pr4rBxjVL1/XV7kiIsAJWlpCfBKBzJCc765DevIbTLvQO7EKfMwH8IvXV/AH9Wioo3HRWkhTzScuE1pMa9H8zUY7FNdyXwIDAQABAoIBAAcqhy+yzTL5pTnxz1jfYY6bl94E1I+5l58d2zDt3AFzeNdGNMMBP0IGVbAlBXb13CyaOwt5Kvcb4Ckv7MrATmrdfQLOPNptcYlyv+zeD8n9oGTIZhel7+hNQ+rbRp4n3nofX3fhvQ1y+ASEEdsUuw7rhyMng9QaXyS1nQn/nyV+sE+3yuLr99iZsdMYz1RwYguTycGJ1eeTU0hc9hL1rKbob9y5/tmmZ5mtLrDNVNMYyq37AAcMk90YK+Lywiaz3Y4Ln8KBVnPvLZD3hR5/Om8/+kZP47ltyhKo6TfGX2tOY19k+fBTPEwJLAWW88FFgyPHeU+YkVhBIAGXMaJj8pECgYEA21iiZtD36sMled17R8J10feUN1IFFuR76ZMSpx7U3gL7Wi1HvKfGgjisYjoHqBY3qixsAu2ImiMJ02kJ3/8woyS2jQiwxpmLXTQ7R7T6l2ic7yjWsubcjI4TFDLzXK5z8o4TC/ssr7YWP58LicxDIauFABoOiWJFMKgVXif+L6MCgYEAt0jr74NtJLa86gznoXLtRgyYEzw9sZTzT7pJRvsdvy7V0My//+PTw4LRHNFVi71pSg4DHTnwadhmwH2hdttFIzpTlRCxjFF5OLhVrzObhEl6SVP/n6EjLKFljzFzB37yLt0lmNfnzpZ2L+RTSHDIVYJWDAIWMSyCSGDvuYu87hUCgYAgy9zkcKRQ9sK4uPQA48OIFHOV3e6i4KDiaLomQMblNx7r+c87Fv7oY57qxPB2InRKPoAb4/ZDza9fa9otItPb4NZmugDsgPLEidW/QAEj+GFWpQ2NDFW3slqJ76BRoEf34WRZq0GgOCKVeqtX/DGhbCrjvAGmawobX1ZqkKJB7wKBgE4RnoV/up6Xw7IB2yvWsyBSPvh6gWDBrD26gHnefpYvkd2FSQbq+QlfEEkxFToXbOChRUxOoIvFJEc7e+oPjcxqjK2C1c2J6pNxWPXuioB3d8ICKHDLBxt8h7DNhEyeEvRJODl5RYCmcCMIIz1I5NwfTx2ASgmaBshjmdizn77dAoGAaH0T+lh8bZn17NJj7huwZz+g3kIj6R5VZxA8z3TvGWVF2JNZnwEVxRV1eYRTLGZeOuJm7XWtJhnbarG90BTzupT3JdLF0LyGtavH5MnE9zzOEkTIsgubqdkWR7EyR/W+NMHFlEfqrNAISyS9jrX9vIopvHbdhZAfmVwzDyEteoQ='),('1da038f8-219b-4bf9-b847-ee5f198aa173','7ebac656-8482-4c1d-bc4a-e5db2d14bba8','allowed-protocol-mapper-types','oidc-address-mapper'),('28a33b49-5628-4764-949e-f20dcfc386ce','69895e79-bf5a-4a16-b3c5-16daa77b8b84','client-uris-must-match','true'),('2acf4f15-baa8-4796-9d18-f5fc1117580c','ec094fc0-1291-496e-b909-07ada1de00da','secret','ihrtuFB-fxSnn-gw-0UXKw'),('2b6718a1-40e6-4645-8432-a16bc7a5b0ea','c7d4735a-b28f-4708-83f6-426ddcece9ac','allowed-protocol-mapper-types','saml-role-list-mapper'),('2de7333d-4d6c-4082-b6cc-98b3873720e6','90cea08a-b4ff-4f40-a598-3671eaba1684','secret','u0gJ4T9PhHl6rNa6s_FI2SBG5xnmiHelmS0zThLxvtpnT92HAd-gGogH-lSatvXI0LviZJg43KQ1fj2mTbNsUw'),('32bfb77e-f3a7-4215-8e6f-82190cf3e702','90cea08a-b4ff-4f40-a598-3671eaba1684','kid','79c1b2a1-2e80-497e-8200-5ff8b6ebedde'),('33588fdc-4832-4d15-8110-e4d7f0f2719b','c7d4735a-b28f-4708-83f6-426ddcece9ac','allowed-protocol-mapper-types','oidc-usermodel-attribute-mapper'),('3a7ed6c6-ed43-48d8-bfd5-1768c01eee36','7ebac656-8482-4c1d-bc4a-e5db2d14bba8','allowed-protocol-mapper-types','oidc-usermodel-attribute-mapper'),('3b0a37b7-93de-45d5-a116-1e989f86a8fb','7ebac656-8482-4c1d-bc4a-e5db2d14bba8','allowed-protocol-mapper-types','oidc-full-name-mapper'),('4427244c-f59e-46cc-acbe-a0671193c52f','c7d4735a-b28f-4708-83f6-426ddcece9ac','allowed-protocol-mapper-types','oidc-address-mapper'),('44809a08-64fd-4464-bad1-ef5e52a9c8d4','ec094fc0-1291-496e-b909-07ada1de00da','kid','423cbdb8-bfdb-493f-86fa-1f13e2be1ab7'),('47db718f-247f-458a-b4fc-342420d96072','90cea08a-b4ff-4f40-a598-3671eaba1684','priority','100'),('4d078ea2-5558-4b16-b030-0eb698cd6055','c7d4735a-b28f-4708-83f6-426ddcece9ac','allowed-protocol-mapper-types','saml-user-attribute-mapper'),('5ccbbe61-01a3-413d-8e50-96ab10b5a2f8','6f4cb54c-a896-4945-a8f3-44c337b16665','priority','100'),('65c4db23-4c9d-48bf-9e31-6268270ac097','90cea08a-b4ff-4f40-a598-3671eaba1684','algorithm','HS256'),('6e059163-2642-4cca-a593-b0ab7413fe93','ec094fc0-1291-496e-b909-07ada1de00da','priority','100'),('9f728555-c651-4ca6-94e3-b61b92a494a3','6f4cb54c-a896-4945-a8f3-44c337b16665','certificate','MIICmzCCAYMCBgGMwW5SgjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMxMjMxMTk0OTQxWhcNMzMxMjMxMTk1MTIxWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCdCtcswbvdqP8PWbMW9HGbCevvkzyhKm1jG3fQDgVe4Edbwe3brk8VStc+0cpKAB8gH5G+Royn+ZQV0t+gdsT2FiXvTer5a/ptNEk+K7BerNPQt64FeyfvhJrHjkAnMtpiFmSOQI0AzxZuwKMcILZHWD+sVjM7G3NWeWlbA+OT6bW2xROe92iNHicVVvaSU6EGjjyU4OEzIC0etubUox4KEYiN11Kc1J0NwowzjNa6WvxKxNnXmKsyWb6mvisHGNUvX9dXuSIiwAlaWkJ8EoHMkJzvrkN68htMu9A7sQp8zAfwi9dX8Af1aKijcdFaSFPNJy4TWkxr0fzNRjsU13JfAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAHv70xFHUXGVwPimXsraoaDd165mrk1w46ZfB3KWCSKiPdwRgFND60B/E6iN8pGp4F7lOccrYtVEShL5HwqTeWE/jm2yYhSTDqgOv4fgaMbvCM/REs6KLw2vwDKRgPcPaki76Gw5PDrt6BeMWMk5ZSSPMOsWzmju5oNuQC0ZzREXb2O18vdJnMKfk8/cknJUEfNeXnMiwUngjmMyBcIsUqMc53iiELyRHyTFxM3GyhO07ufqoAHWo5fJ0pzEgcHi276kciXAF/53mpAOMPBd/JkTEN4st8scaUAEt22PedOjE86Gead3ZhBChKOjuTkcX0Lh84X+pU5dQst4R74mPk4='),('a0d45fa0-e03d-4726-8428-5bfc22a05388','5c8927ed-c7dd-4c67-9e5a-e63a785e40c4','priority','100'),('a555cc39-8afc-47f9-8ce9-0073a7813705','f58f6660-0397-43b5-9fda-4a8b8c0ed37b','max-clients','200'),('a606ca1b-468b-468a-bb9a-491ce88aaeee','6f4cb54c-a896-4945-a8f3-44c337b16665','keyUse','ENC'),('ac8fd676-803c-435f-923a-21a022b8cd3a','7ebac656-8482-4c1d-bc4a-e5db2d14bba8','allowed-protocol-mapper-types','oidc-sha256-pairwise-sub-mapper'),('b1db9f78-5358-48dd-883c-44117539e26a','7ebac656-8482-4c1d-bc4a-e5db2d14bba8','allowed-protocol-mapper-types','oidc-usermodel-property-mapper'),('c2dac744-2f0a-47f0-ba32-f6171a41e245','5c8927ed-c7dd-4c67-9e5a-e63a785e40c4','privateKey','MIIEpAIBAAKCAQEA1N+jFWitQTWtp7vEcVOBtZJHIlWM0c499KL/VY8ALSZ634L0bB3QKQXAGOl+j80xN5Ub8P+Rau2/wg1qsjNGfm5Yxi02M7OX85I+R6cxJHPiq7FXb2OJaMsO9whEdU9rilcE3kzIBotVX0yA0s+S8Mf9tBjQHokASqG4XenGRPl+ztTgJfC/vKyqeLJGvQnYfd7JjRTWmAlwxf9/MCZoZtxCw0fskifor0ZAsRe7dAPfiwpmO8gDu+naYbrhBJS4nDh5ZtSlNmUPY/UGuVWZq3O7r0LKKOOcPL6EgIP4MqZuojUcGb2iDLQXN0nm1vvtmKdfxZRCv99oM2UTSoBPrwIDAQABAoIBACczQaBtJM6H2IE1YiDuXEn39HJ9p49xN9aHd5alXUZzOhhT0LfiK5WKUgwkX2KSyjfulPUl0v0KaBAPkXDcYWRh5KYl6D/QGDDJ4v8l6jZIwtqUL0I7Za/vCMPz+UtTAz439RUMtZ8C5IdGmsh3YhtF8NHL6fNdjjiwHDfrF1BW/W4Li2lx+ptKJYnoq8lfycqFB9w6r48Qv4AUuRmve2P93I/fDB6FBYuwVLWqcu5+2dgNFIzpiDkLxWCQqugcoYZgxWhPchPnS39zxuA76zP4SnPXkxNmCGKeEQNZ3wszu+dGfDETw0/rDAqFNTaFJdkoD+dvQxkWBLm3aVoasskCgYEA9V1jyEBGhJc5JbYpOWOl2HBP6J4Mep67tIPU1xwuxq659sahegA+DelkGavCIg/BhyArL+vTpNqnkrzIgfOgRcuOcx7nRk+M3toDLzRrd9KkTeOFOY9F4edn8EK1m/Phdnkb09sZhH9+H591Wn8SvOVgSPsw5M5RTzQM+Brfm9kCgYEA3hm4FL9QxyQ0eAVRUswP/FAlqx+TbmbmnFO5wtmMCqVuFkh+BGcarFW8pAZRP6TQCTaIRYhCvzwh3oJhZZf7CugeXh6AuVUuxPzNnXCY/HEE1RYJKsK5IMkKmsmDLP5MrCgoPM9aG7aA4QsEoaVx0jQycAfTbjopgKgd0vf3OscCgYEA1J/RUD8i3NOPGjb5Elpf5WeuV45ekgPr9UooryAlCNdxH4CRff+nxrZxoC1PVeUBd+9QfX6HMVypymb9+l78jH8ROoGVOUDGenfCOq3aU0OeTkDTukWF8XVuhK3KYxK8VsYsbzJ2snMpAI5WS83Clx7OiW/jtuNzYodglb/z9kECgYEAqeaW0RhBXPWvRZkbyvDb0bIl/rAbAjupcjECS7JL1OEUQ+uUqx2MZAT6V6eVg9A6bLHQsRA5rzz609J9W1BV9NP4VxuScTReoMabLDM0dPioL7G5tYJcSF5CxIIe3M50LMZTcaFVVxnXoU/ibR244oqXgugZr5rCoO76Uabq84UCgYAeasf/TVi7qpStNtmly5Jp2lfgfyg/Uo9F24qGveDm+9JK5VTHqianIW5EKA4/z+e829zyhjt80jRm9aT5GvlmnJr0mJVKkHFGJZ4e2QE0nEjKKnhFh9HWgqoTEWcbxVHNz2M56TSMO6JVmCLS3YnenTjF78RN8JoKgceaEFxw6A=='),('cf1a838c-cdb1-409d-9460-231aa5e1cad4','c7d4735a-b28f-4708-83f6-426ddcece9ac','allowed-protocol-mapper-types','oidc-full-name-mapper'),('d854b4ca-2d64-4061-9377-af3c8624ad62','7ebac656-8482-4c1d-bc4a-e5db2d14bba8','allowed-protocol-mapper-types','saml-user-property-mapper'),('df343a79-0921-4141-8688-6f94eb7feafb','5c8927ed-c7dd-4c67-9e5a-e63a785e40c4','keyUse','SIG'),('e2144be6-f76e-400b-a1aa-92d6944bd9bd','6f4cb54c-a896-4945-a8f3-44c337b16665','algorithm','RSA-OAEP'),('e8dd919e-8561-44f7-a364-a9149ac99d73','8d895720-e8c1-4c19-a8fb-708672fd3e7e','allow-default-scopes','true'),('e8fc786a-e525-44cd-80c6-b1e8e1a35826','7ebac656-8482-4c1d-bc4a-e5db2d14bba8','allowed-protocol-mapper-types','saml-user-attribute-mapper'),('edc733fd-4df1-495a-9e35-f0ebf8b33d21','69895e79-bf5a-4a16-b3c5-16daa77b8b84','host-sending-registration-request-must-match','true'),('ee69a51a-5db1-41cf-87d7-15db1f476650','5c8927ed-c7dd-4c67-9e5a-e63a785e40c4','certificate','MIICmzCCAYMCBgGMwW5SEDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMxMjMxMTk0OTQxWhcNMzMxMjMxMTk1MTIxWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDU36MVaK1BNa2nu8RxU4G1kkciVYzRzj30ov9VjwAtJnrfgvRsHdApBcAY6X6PzTE3lRvw/5Fq7b/CDWqyM0Z+bljGLTYzs5fzkj5HpzEkc+KrsVdvY4loyw73CER1T2uKVwTeTMgGi1VfTIDSz5Lwx/20GNAeiQBKobhd6cZE+X7O1OAl8L+8rKp4ska9Cdh93smNFNaYCXDF/38wJmhm3ELDR+ySJ+ivRkCxF7t0A9+LCmY7yAO76dphuuEElLicOHlm1KU2ZQ9j9Qa5VZmrc7uvQsoo45w8voSAg/gypm6iNRwZvaIMtBc3SebW++2Yp1/FlEK/32gzZRNKgE+vAgMBAAEwDQYJKoZIhvcNAQELBQADggEBABcZxdZCLbqlnIRHE/LQ7YpWceyncpHFjCzl4UrpxQGI3TBdawmUuZ9/H2ekDmPYJhHpT4TNWIz/JjEDHu+kuc+wrqGs2dWt/iQH9yOdLMoxGIJ+1q86xExFFVWVMh1jLr6j6+JJbnkne0OZN6aylYVPRE2+dEDYdns2B4ufLUhvVLrgUrotT8brZOtZ6x8eBMqfVAdi8ChNuAGBz+2S+zY/kG7ny57gHciHevz9fC2IE0KX31K6vgWi1QUIeM+BC8ICvVflfS0Pu6C3T8xbNXHUPOQKhmU3Sn/Qur0bbudR/7y97Vi5i7ss38bZlVvWVrDvz1RPBqPUCnm2FSg5PYs='),('f1e0220d-3908-4bb1-bf9c-d53d60dd0109','7ebac656-8482-4c1d-bc4a-e5db2d14bba8','allowed-protocol-mapper-types','saml-role-list-mapper'),('f26451d0-c52f-43c7-9365-f1042baf7977','44c6fe55-c281-4057-b772-ebac95d3094e','allow-default-scopes','true'),('f38a5fb0-708f-403a-a02b-974da2a37260','c7d4735a-b28f-4708-83f6-426ddcece9ac','allowed-protocol-mapper-types','saml-user-property-mapper');
/*!40000 ALTER TABLE `COMPONENT_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `COMPOSITE_ROLE`
--

DROP TABLE IF EXISTS `COMPOSITE_ROLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `COMPOSITE_ROLE` (
  `COMPOSITE` varchar(36) NOT NULL,
  `CHILD_ROLE` varchar(36) NOT NULL,
  PRIMARY KEY (`COMPOSITE`,`CHILD_ROLE`),
  KEY `IDX_COMPOSITE` (`COMPOSITE`),
  KEY `IDX_COMPOSITE_CHILD` (`CHILD_ROLE`),
  CONSTRAINT `FK_A63WVEKFTU8JO1PNJ81E7MCE2` FOREIGN KEY (`COMPOSITE`) REFERENCES `KEYCLOAK_ROLE` (`ID`),
  CONSTRAINT `FK_GR7THLLB9LU8Q4VQA4524JJY8` FOREIGN KEY (`CHILD_ROLE`) REFERENCES `KEYCLOAK_ROLE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COMPOSITE_ROLE`
--

LOCK TABLES `COMPOSITE_ROLE` WRITE;
/*!40000 ALTER TABLE `COMPOSITE_ROLE` DISABLE KEYS */;
INSERT INTO `COMPOSITE_ROLE` VALUES ('13739d66-87b6-40e0-bb7d-e3299c21638d','29046e39-a5a8-4b37-8984-edf53da00ad9'),('6ad2a9b1-f3f5-40e7-9681-87e38c31fa5d','2409d900-3e39-4b83-aaf0-5aa0bc05b4ac'),('b86cd9d1-90ec-474e-a2bc-46d348bfff9b','34834b02-5edf-4112-8910-9c94e3fe2c8b'),('b86cd9d1-90ec-474e-a2bc-46d348bfff9b','9d7fd74c-df90-4a9e-95e4-0c847e9dc764'),('cb8670aa-2456-415a-9197-ed2c67de85fd','4d9a64e9-bc80-4f0a-a7bb-d5d91a3f1e2b'),('dc84eb3b-359f-45bc-aaee-73d11486e02c','06a6bd55-fce5-47d8-8d61-caf219216913'),('dc84eb3b-359f-45bc-aaee-73d11486e02c','0a78f5d6-b6b8-4107-b2ea-511f0de0173a'),('dc84eb3b-359f-45bc-aaee-73d11486e02c','26123283-ca5f-4e3b-bd2c-802b23c15d1f'),('dc84eb3b-359f-45bc-aaee-73d11486e02c','33c842e9-c3a9-4aac-a70f-d4850645b3da'),('dc84eb3b-359f-45bc-aaee-73d11486e02c','34834b02-5edf-4112-8910-9c94e3fe2c8b'),('dc84eb3b-359f-45bc-aaee-73d11486e02c','4d9a64e9-bc80-4f0a-a7bb-d5d91a3f1e2b'),('dc84eb3b-359f-45bc-aaee-73d11486e02c','78a7c8ee-0752-4df1-9e2e-27b8bee23aae'),('dc84eb3b-359f-45bc-aaee-73d11486e02c','9607e49a-6017-4904-ab94-7786b2e40bee'),('dc84eb3b-359f-45bc-aaee-73d11486e02c','9d7fd74c-df90-4a9e-95e4-0c847e9dc764'),('dc84eb3b-359f-45bc-aaee-73d11486e02c','aea87a71-fc14-4a20-9235-6b83fc5eeff2'),('dc84eb3b-359f-45bc-aaee-73d11486e02c','af260de1-182b-43db-ad8f-7a16342ef7e0'),('dc84eb3b-359f-45bc-aaee-73d11486e02c','b86cd9d1-90ec-474e-a2bc-46d348bfff9b'),('dc84eb3b-359f-45bc-aaee-73d11486e02c','bf06d95c-cb6f-4fa4-b4e7-9584e3cabfa6'),('dc84eb3b-359f-45bc-aaee-73d11486e02c','bff1746b-37d3-438d-813a-25c0aded4848'),('dc84eb3b-359f-45bc-aaee-73d11486e02c','cb8670aa-2456-415a-9197-ed2c67de85fd'),('dc84eb3b-359f-45bc-aaee-73d11486e02c','eb2e38ad-a994-4f88-88c7-b37e63ecc8c2'),('dc84eb3b-359f-45bc-aaee-73d11486e02c','eba2d389-c75f-4ddd-863d-b6acda709b0c'),('dc84eb3b-359f-45bc-aaee-73d11486e02c','ee32292c-56c1-43ba-992a-d3b84a3aa9b1'),('dc84eb3b-359f-45bc-aaee-73d11486e02c','f20316c5-61e1-46fb-b221-64e018d0cf49'),('fbda23ea-5774-4c94-bea9-579347d92fc1','13739d66-87b6-40e0-bb7d-e3299c21638d'),('fbda23ea-5774-4c94-bea9-579347d92fc1','191ab440-a308-4c46-8dbd-f93634ed29c0'),('fbda23ea-5774-4c94-bea9-579347d92fc1','9bb47083-db3b-41d8-90d1-81e44a833d8d'),('fbda23ea-5774-4c94-bea9-579347d92fc1','ba3eb3aa-ac9a-4933-b976-107ac843e188');
/*!40000 ALTER TABLE `COMPOSITE_ROLE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CREDENTIAL`
--

DROP TABLE IF EXISTS `CREDENTIAL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CREDENTIAL` (
  `ID` varchar(36) NOT NULL,
  `SALT` tinyblob,
  `TYPE` varchar(255) DEFAULT NULL,
  `USER_ID` varchar(36) DEFAULT NULL,
  `CREATED_DATE` bigint DEFAULT NULL,
  `USER_LABEL` varchar(255) DEFAULT NULL,
  `SECRET_DATA` longtext,
  `CREDENTIAL_DATA` longtext,
  `PRIORITY` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_USER_CREDENTIAL` (`USER_ID`),
  CONSTRAINT `FK_PFYR0GLASQYL0DEI3KL69R6V0` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CREDENTIAL`
--

LOCK TABLES `CREDENTIAL` WRITE;
/*!40000 ALTER TABLE `CREDENTIAL` DISABLE KEYS */;
INSERT INTO `CREDENTIAL` VALUES ('454adf28-3b84-4019-8ae3-c9b6e4ba942a',NULL,'password','6c004b19-e5eb-4874-8b29-27737c8c9ccf',1704052407850,'','{\"value\":\"SbOKDrzAj/64XB8ztNm2vcLKSgjS9J1e9Fq0rCDvGhs=\",\"salt\":\"P78kwzw8MnRsltypIR4YdQ==\",\"additionalParameters\":{}}','{\"hashIterations\":27500,\"algorithm\":\"pbkdf2-sha256\",\"additionalParameters\":{}}',10),('7679b855-7e3b-4cb2-90a1-ba2140912604',NULL,'password','0c07de36-aa9a-4caa-bf55-27be1c3f5a22',1704052282416,NULL,'{\"value\":\"zuIL8SxQwCv5JH3fCr+S9faY6/eHnhF2g4vwe795zCE=\",\"salt\":\"xvqbN7DO36jrowmaeixa2Q==\",\"additionalParameters\":{}}','{\"hashIterations\":27500,\"algorithm\":\"pbkdf2-sha256\",\"additionalParameters\":{}}',10);
/*!40000 ALTER TABLE `CREDENTIAL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DATABASECHANGELOG`
--

DROP TABLE IF EXISTS `DATABASECHANGELOG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DATABASECHANGELOG` (
  `ID` varchar(255) NOT NULL,
  `AUTHOR` varchar(255) NOT NULL,
  `FILENAME` varchar(255) NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int NOT NULL,
  `EXECTYPE` varchar(10) NOT NULL,
  `MD5SUM` varchar(35) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `COMMENTS` varchar(255) DEFAULT NULL,
  `TAG` varchar(255) DEFAULT NULL,
  `LIQUIBASE` varchar(20) DEFAULT NULL,
  `CONTEXTS` varchar(255) DEFAULT NULL,
  `LABELS` varchar(255) DEFAULT NULL,
  `DEPLOYMENT_ID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DATABASECHANGELOG`
--

LOCK TABLES `DATABASECHANGELOG` WRITE;
/*!40000 ALTER TABLE `DATABASECHANGELOG` DISABLE KEYS */;
INSERT INTO `DATABASECHANGELOG` VALUES ('1.0.0.Final-KEYCLOAK-5461','sthorger@redhat.com','META-INF/jpa-changelog-1.0.0.Final.xml','2023-12-31 19:49:58',1,'EXECUTED','9:6f1016664e21e16d26517a4418f5e3df','createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('1.0.0.Final-KEYCLOAK-5461','sthorger@redhat.com','META-INF/db2-jpa-changelog-1.0.0.Final.xml','2023-12-31 19:49:58',2,'MARK_RAN','9:828775b1596a07d1200ba1d49e5e3941','createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('1.1.0.Beta1','sthorger@redhat.com','META-INF/jpa-changelog-1.1.0.Beta1.xml','2023-12-31 19:50:00',3,'EXECUTED','9:5f090e44a7d595883c1fb61f4b41fd38','delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('1.1.0.Final','sthorger@redhat.com','META-INF/jpa-changelog-1.1.0.Final.xml','2023-12-31 19:50:00',4,'EXECUTED','9:c07e577387a3d2c04d1adc9aaad8730e','renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY','',NULL,'4.23.2',NULL,NULL,'4052183780'),('1.2.0.Beta1','psilva@redhat.com','META-INF/jpa-changelog-1.2.0.Beta1.xml','2023-12-31 19:50:06',5,'EXECUTED','9:b68ce996c655922dbcd2fe6b6ae72686','delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('1.2.0.Beta1','psilva@redhat.com','META-INF/db2-jpa-changelog-1.2.0.Beta1.xml','2023-12-31 19:50:06',6,'MARK_RAN','9:543b5c9989f024fe35c6f6c5a97de88e','delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('1.2.0.RC1','bburke@redhat.com','META-INF/jpa-changelog-1.2.0.CR1.xml','2023-12-31 19:50:12',7,'EXECUTED','9:765afebbe21cf5bbca048e632df38336','delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('1.2.0.RC1','bburke@redhat.com','META-INF/db2-jpa-changelog-1.2.0.CR1.xml','2023-12-31 19:50:12',8,'MARK_RAN','9:db4a145ba11a6fdaefb397f6dbf829a1','delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('1.2.0.Final','keycloak','META-INF/jpa-changelog-1.2.0.Final.xml','2023-12-31 19:50:12',9,'EXECUTED','9:9d05c7be10cdb873f8bcb41bc3a8ab23','update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT','',NULL,'4.23.2',NULL,NULL,'4052183780'),('1.3.0','bburke@redhat.com','META-INF/jpa-changelog-1.3.0.xml','2023-12-31 19:50:18',10,'EXECUTED','9:18593702353128d53111f9b1ff0b82b8','delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('1.4.0','bburke@redhat.com','META-INF/jpa-changelog-1.4.0.xml','2023-12-31 19:50:21',11,'EXECUTED','9:6122efe5f090e41a85c0f1c9e52cbb62','delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('1.4.0','bburke@redhat.com','META-INF/db2-jpa-changelog-1.4.0.xml','2023-12-31 19:50:21',12,'MARK_RAN','9:e1ff28bf7568451453f844c5d54bb0b5','delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('1.5.0','bburke@redhat.com','META-INF/jpa-changelog-1.5.0.xml','2023-12-31 19:50:21',13,'EXECUTED','9:7af32cd8957fbc069f796b61217483fd','delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('1.6.1_from15','mposolda@redhat.com','META-INF/jpa-changelog-1.6.1.xml','2023-12-31 19:50:22',14,'EXECUTED','9:6005e15e84714cd83226bf7879f54190','addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('1.6.1_from16-pre','mposolda@redhat.com','META-INF/jpa-changelog-1.6.1.xml','2023-12-31 19:50:22',15,'MARK_RAN','9:bf656f5a2b055d07f314431cae76f06c','delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION','',NULL,'4.23.2',NULL,NULL,'4052183780'),('1.6.1_from16','mposolda@redhat.com','META-INF/jpa-changelog-1.6.1.xml','2023-12-31 19:50:22',16,'MARK_RAN','9:f8dadc9284440469dcf71e25ca6ab99b','dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('1.6.1','mposolda@redhat.com','META-INF/jpa-changelog-1.6.1.xml','2023-12-31 19:50:22',17,'EXECUTED','9:d41d8cd98f00b204e9800998ecf8427e','empty','',NULL,'4.23.2',NULL,NULL,'4052183780'),('1.7.0','bburke@redhat.com','META-INF/jpa-changelog-1.7.0.xml','2023-12-31 19:50:25',18,'EXECUTED','9:3368ff0be4c2855ee2dd9ca813b38d8e','createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('1.8.0','mposolda@redhat.com','META-INF/jpa-changelog-1.8.0.xml','2023-12-31 19:50:28',19,'EXECUTED','9:8ac2fb5dd030b24c0570a763ed75ed20','addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('1.8.0-2','keycloak','META-INF/jpa-changelog-1.8.0.xml','2023-12-31 19:50:28',20,'EXECUTED','9:f91ddca9b19743db60e3057679810e6c','dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL','',NULL,'4.23.2',NULL,NULL,'4052183780'),('1.8.0','mposolda@redhat.com','META-INF/db2-jpa-changelog-1.8.0.xml','2023-12-31 19:50:28',21,'MARK_RAN','9:831e82914316dc8a57dc09d755f23c51','addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('1.8.0-2','keycloak','META-INF/db2-jpa-changelog-1.8.0.xml','2023-12-31 19:50:28',22,'MARK_RAN','9:f91ddca9b19743db60e3057679810e6c','dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL','',NULL,'4.23.2',NULL,NULL,'4052183780'),('1.9.0','mposolda@redhat.com','META-INF/jpa-changelog-1.9.0.xml','2023-12-31 19:50:29',23,'EXECUTED','9:bc3d0f9e823a69dc21e23e94c7a94bb1','update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('1.9.1','keycloak','META-INF/jpa-changelog-1.9.1.xml','2023-12-31 19:50:29',24,'EXECUTED','9:c9999da42f543575ab790e76439a2679','modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM','',NULL,'4.23.2',NULL,NULL,'4052183780'),('1.9.1','keycloak','META-INF/db2-jpa-changelog-1.9.1.xml','2023-12-31 19:50:29',25,'MARK_RAN','9:0d6c65c6f58732d81569e77b10ba301d','modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM','',NULL,'4.23.2',NULL,NULL,'4052183780'),('1.9.2','keycloak','META-INF/jpa-changelog-1.9.2.xml','2023-12-31 19:50:30',26,'EXECUTED','9:fc576660fc016ae53d2d4778d84d86d0','createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('authz-2.0.0','psilva@redhat.com','META-INF/jpa-changelog-authz-2.0.0.xml','2023-12-31 19:50:34',27,'EXECUTED','9:43ed6b0da89ff77206289e87eaa9c024','createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('authz-2.5.1','psilva@redhat.com','META-INF/jpa-changelog-authz-2.5.1.xml','2023-12-31 19:50:34',28,'EXECUTED','9:44bae577f551b3738740281eceb4ea70','update tableName=RESOURCE_SERVER_POLICY','',NULL,'4.23.2',NULL,NULL,'4052183780'),('2.1.0-KEYCLOAK-5461','bburke@redhat.com','META-INF/jpa-changelog-2.1.0.xml','2023-12-31 19:50:37',29,'EXECUTED','9:bd88e1f833df0420b01e114533aee5e8','createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('2.2.0','bburke@redhat.com','META-INF/jpa-changelog-2.2.0.xml','2023-12-31 19:50:38',30,'EXECUTED','9:a7022af5267f019d020edfe316ef4371','addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('2.3.0','bburke@redhat.com','META-INF/jpa-changelog-2.3.0.xml','2023-12-31 19:50:39',31,'EXECUTED','9:fc155c394040654d6a79227e56f5e25a','createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('2.4.0','bburke@redhat.com','META-INF/jpa-changelog-2.4.0.xml','2023-12-31 19:50:39',32,'EXECUTED','9:eac4ffb2a14795e5dc7b426063e54d88','customChange','',NULL,'4.23.2',NULL,NULL,'4052183780'),('2.5.0','bburke@redhat.com','META-INF/jpa-changelog-2.5.0.xml','2023-12-31 19:50:39',33,'EXECUTED','9:54937c05672568c4c64fc9524c1e9462','customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION','',NULL,'4.23.2',NULL,NULL,'4052183780'),('2.5.0-unicode-oracle','hmlnarik@redhat.com','META-INF/jpa-changelog-2.5.0.xml','2023-12-31 19:50:39',34,'MARK_RAN','9:3a32bace77c84d7678d035a7f5a8084e','modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('2.5.0-unicode-other-dbs','hmlnarik@redhat.com','META-INF/jpa-changelog-2.5.0.xml','2023-12-31 19:50:44',35,'EXECUTED','9:33d72168746f81f98ae3a1e8e0ca3554','modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('2.5.0-duplicate-email-support','slawomir@dabek.name','META-INF/jpa-changelog-2.5.0.xml','2023-12-31 19:50:44',36,'EXECUTED','9:61b6d3d7a4c0e0024b0c839da283da0c','addColumn tableName=REALM','',NULL,'4.23.2',NULL,NULL,'4052183780'),('2.5.0-unique-group-names','hmlnarik@redhat.com','META-INF/jpa-changelog-2.5.0.xml','2023-12-31 19:50:44',37,'EXECUTED','9:8dcac7bdf7378e7d823cdfddebf72fda','addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP','',NULL,'4.23.2',NULL,NULL,'4052183780'),('2.5.1','bburke@redhat.com','META-INF/jpa-changelog-2.5.1.xml','2023-12-31 19:50:44',38,'EXECUTED','9:a2b870802540cb3faa72098db5388af3','addColumn tableName=FED_USER_CONSENT','',NULL,'4.23.2',NULL,NULL,'4052183780'),('3.0.0','bburke@redhat.com','META-INF/jpa-changelog-3.0.0.xml','2023-12-31 19:50:44',39,'EXECUTED','9:132a67499ba24bcc54fb5cbdcfe7e4c0','addColumn tableName=IDENTITY_PROVIDER','',NULL,'4.23.2',NULL,NULL,'4052183780'),('3.2.0-fix','keycloak','META-INF/jpa-changelog-3.2.0.xml','2023-12-31 19:50:44',40,'MARK_RAN','9:938f894c032f5430f2b0fafb1a243462','addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS','',NULL,'4.23.2',NULL,NULL,'4052183780'),('3.2.0-fix-with-keycloak-5416','keycloak','META-INF/jpa-changelog-3.2.0.xml','2023-12-31 19:50:44',41,'MARK_RAN','9:845c332ff1874dc5d35974b0babf3006','dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS','',NULL,'4.23.2',NULL,NULL,'4052183780'),('3.2.0-fix-offline-sessions','hmlnarik','META-INF/jpa-changelog-3.2.0.xml','2023-12-31 19:50:45',42,'EXECUTED','9:fc86359c079781adc577c5a217e4d04c','customChange','',NULL,'4.23.2',NULL,NULL,'4052183780'),('3.2.0-fixed','keycloak','META-INF/jpa-changelog-3.2.0.xml','2023-12-31 19:50:50',43,'EXECUTED','9:59a64800e3c0d09b825f8a3b444fa8f4','addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('3.3.0','keycloak','META-INF/jpa-changelog-3.3.0.xml','2023-12-31 19:50:50',44,'EXECUTED','9:d48d6da5c6ccf667807f633fe489ce88','addColumn tableName=USER_ENTITY','',NULL,'4.23.2',NULL,NULL,'4052183780'),('authz-3.4.0.CR1-resource-server-pk-change-part1','glavoie@gmail.com','META-INF/jpa-changelog-authz-3.4.0.CR1.xml','2023-12-31 19:50:50',45,'EXECUTED','9:dde36f7973e80d71fceee683bc5d2951','addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE','',NULL,'4.23.2',NULL,NULL,'4052183780'),('authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095','hmlnarik@redhat.com','META-INF/jpa-changelog-authz-3.4.0.CR1.xml','2023-12-31 19:50:50',46,'EXECUTED','9:b855e9b0a406b34fa323235a0cf4f640','customChange','',NULL,'4.23.2',NULL,NULL,'4052183780'),('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed','glavoie@gmail.com','META-INF/jpa-changelog-authz-3.4.0.CR1.xml','2023-12-31 19:50:50',47,'MARK_RAN','9:51abbacd7b416c50c4421a8cabf7927e','dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE','',NULL,'4.23.2',NULL,NULL,'4052183780'),('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex','glavoie@gmail.com','META-INF/jpa-changelog-authz-3.4.0.CR1.xml','2023-12-31 19:50:54',48,'EXECUTED','9:bdc99e567b3398bac83263d375aad143','addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('authn-3.4.0.CR1-refresh-token-max-reuse','glavoie@gmail.com','META-INF/jpa-changelog-authz-3.4.0.CR1.xml','2023-12-31 19:50:54',49,'EXECUTED','9:d198654156881c46bfba39abd7769e69','addColumn tableName=REALM','',NULL,'4.23.2',NULL,NULL,'4052183780'),('3.4.0','keycloak','META-INF/jpa-changelog-3.4.0.xml','2023-12-31 19:50:57',50,'EXECUTED','9:cfdd8736332ccdd72c5256ccb42335db','addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('3.4.0-KEYCLOAK-5230','hmlnarik@redhat.com','META-INF/jpa-changelog-3.4.0.xml','2023-12-31 19:50:58',51,'EXECUTED','9:7c84de3d9bd84d7f077607c1a4dcb714','createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('3.4.1','psilva@redhat.com','META-INF/jpa-changelog-3.4.1.xml','2023-12-31 19:50:58',52,'EXECUTED','9:5a6bb36cbefb6a9d6928452c0852af2d','modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES','',NULL,'4.23.2',NULL,NULL,'4052183780'),('3.4.2','keycloak','META-INF/jpa-changelog-3.4.2.xml','2023-12-31 19:50:58',53,'EXECUTED','9:8f23e334dbc59f82e0a328373ca6ced0','update tableName=REALM','',NULL,'4.23.2',NULL,NULL,'4052183780'),('3.4.2-KEYCLOAK-5172','mkanis@redhat.com','META-INF/jpa-changelog-3.4.2.xml','2023-12-31 19:50:58',54,'EXECUTED','9:9156214268f09d970cdf0e1564d866af','update tableName=CLIENT','',NULL,'4.23.2',NULL,NULL,'4052183780'),('4.0.0-KEYCLOAK-6335','bburke@redhat.com','META-INF/jpa-changelog-4.0.0.xml','2023-12-31 19:50:58',55,'EXECUTED','9:db806613b1ed154826c02610b7dbdf74','createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS','',NULL,'4.23.2',NULL,NULL,'4052183780'),('4.0.0-CLEANUP-UNUSED-TABLE','bburke@redhat.com','META-INF/jpa-changelog-4.0.0.xml','2023-12-31 19:50:58',56,'EXECUTED','9:229a041fb72d5beac76bb94a5fa709de','dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING','',NULL,'4.23.2',NULL,NULL,'4052183780'),('4.0.0-KEYCLOAK-6228','bburke@redhat.com','META-INF/jpa-changelog-4.0.0.xml','2023-12-31 19:50:59',57,'EXECUTED','9:079899dade9c1e683f26b2aa9ca6ff04','dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('4.0.0-KEYCLOAK-5579-fixed','mposolda@redhat.com','META-INF/jpa-changelog-4.0.0.xml','2023-12-31 19:51:06',58,'EXECUTED','9:139b79bcbbfe903bb1c2d2a4dbf001d9','dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('authz-4.0.0.CR1','psilva@redhat.com','META-INF/jpa-changelog-authz-4.0.0.CR1.xml','2023-12-31 19:51:08',59,'EXECUTED','9:b55738ad889860c625ba2bf483495a04','createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('authz-4.0.0.Beta3','psilva@redhat.com','META-INF/jpa-changelog-authz-4.0.0.Beta3.xml','2023-12-31 19:51:09',60,'EXECUTED','9:e0057eac39aa8fc8e09ac6cfa4ae15fe','addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY','',NULL,'4.23.2',NULL,NULL,'4052183780'),('authz-4.2.0.Final','mhajas@redhat.com','META-INF/jpa-changelog-authz-4.2.0.Final.xml','2023-12-31 19:51:09',61,'EXECUTED','9:42a33806f3a0443fe0e7feeec821326c','createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('authz-4.2.0.Final-KEYCLOAK-9944','hmlnarik@redhat.com','META-INF/jpa-changelog-authz-4.2.0.Final.xml','2023-12-31 19:51:09',62,'EXECUTED','9:9968206fca46eecc1f51db9c024bfe56','addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS','',NULL,'4.23.2',NULL,NULL,'4052183780'),('4.2.0-KEYCLOAK-6313','wadahiro@gmail.com','META-INF/jpa-changelog-4.2.0.xml','2023-12-31 19:51:09',63,'EXECUTED','9:92143a6daea0a3f3b8f598c97ce55c3d','addColumn tableName=REQUIRED_ACTION_PROVIDER','',NULL,'4.23.2',NULL,NULL,'4052183780'),('4.3.0-KEYCLOAK-7984','wadahiro@gmail.com','META-INF/jpa-changelog-4.3.0.xml','2023-12-31 19:51:09',64,'EXECUTED','9:82bab26a27195d889fb0429003b18f40','update tableName=REQUIRED_ACTION_PROVIDER','',NULL,'4.23.2',NULL,NULL,'4052183780'),('4.6.0-KEYCLOAK-7950','psilva@redhat.com','META-INF/jpa-changelog-4.6.0.xml','2023-12-31 19:51:09',65,'EXECUTED','9:e590c88ddc0b38b0ae4249bbfcb5abc3','update tableName=RESOURCE_SERVER_RESOURCE','',NULL,'4.23.2',NULL,NULL,'4052183780'),('4.6.0-KEYCLOAK-8377','keycloak','META-INF/jpa-changelog-4.6.0.xml','2023-12-31 19:51:10',66,'EXECUTED','9:5c1f475536118dbdc38d5d7977950cc0','createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('4.6.0-KEYCLOAK-8555','gideonray@gmail.com','META-INF/jpa-changelog-4.6.0.xml','2023-12-31 19:51:10',67,'EXECUTED','9:e7c9f5f9c4d67ccbbcc215440c718a17','createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT','',NULL,'4.23.2',NULL,NULL,'4052183780'),('4.7.0-KEYCLOAK-1267','sguilhen@redhat.com','META-INF/jpa-changelog-4.7.0.xml','2023-12-31 19:51:10',68,'EXECUTED','9:88e0bfdda924690d6f4e430c53447dd5','addColumn tableName=REALM','',NULL,'4.23.2',NULL,NULL,'4052183780'),('4.7.0-KEYCLOAK-7275','keycloak','META-INF/jpa-changelog-4.7.0.xml','2023-12-31 19:51:10',69,'EXECUTED','9:f53177f137e1c46b6a88c59ec1cb5218','renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('4.8.0-KEYCLOAK-8835','sguilhen@redhat.com','META-INF/jpa-changelog-4.8.0.xml','2023-12-31 19:51:11',70,'EXECUTED','9:a74d33da4dc42a37ec27121580d1459f','addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM','',NULL,'4.23.2',NULL,NULL,'4052183780'),('authz-7.0.0-KEYCLOAK-10443','psilva@redhat.com','META-INF/jpa-changelog-authz-7.0.0.xml','2023-12-31 19:51:11',71,'EXECUTED','9:fd4ade7b90c3b67fae0bfcfcb42dfb5f','addColumn tableName=RESOURCE_SERVER','',NULL,'4.23.2',NULL,NULL,'4052183780'),('8.0.0-adding-credential-columns','keycloak','META-INF/jpa-changelog-8.0.0.xml','2023-12-31 19:51:11',72,'EXECUTED','9:aa072ad090bbba210d8f18781b8cebf4','addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL','',NULL,'4.23.2',NULL,NULL,'4052183780'),('8.0.0-updating-credential-data-not-oracle-fixed','keycloak','META-INF/jpa-changelog-8.0.0.xml','2023-12-31 19:51:11',73,'EXECUTED','9:1ae6be29bab7c2aa376f6983b932be37','update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL','',NULL,'4.23.2',NULL,NULL,'4052183780'),('8.0.0-updating-credential-data-oracle-fixed','keycloak','META-INF/jpa-changelog-8.0.0.xml','2023-12-31 19:51:11',74,'MARK_RAN','9:14706f286953fc9a25286dbd8fb30d97','update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL','',NULL,'4.23.2',NULL,NULL,'4052183780'),('8.0.0-credential-cleanup-fixed','keycloak','META-INF/jpa-changelog-8.0.0.xml','2023-12-31 19:51:13',75,'EXECUTED','9:2b9cc12779be32c5b40e2e67711a218b','dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('8.0.0-resource-tag-support','keycloak','META-INF/jpa-changelog-8.0.0.xml','2023-12-31 19:51:13',76,'EXECUTED','9:91fa186ce7a5af127a2d7a91ee083cc5','addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL','',NULL,'4.23.2',NULL,NULL,'4052183780'),('9.0.0-always-display-client','keycloak','META-INF/jpa-changelog-9.0.0.xml','2023-12-31 19:51:13',77,'EXECUTED','9:6335e5c94e83a2639ccd68dd24e2e5ad','addColumn tableName=CLIENT','',NULL,'4.23.2',NULL,NULL,'4052183780'),('9.0.0-drop-constraints-for-column-increase','keycloak','META-INF/jpa-changelog-9.0.0.xml','2023-12-31 19:51:13',78,'MARK_RAN','9:6bdb5658951e028bfe16fa0a8228b530','dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('9.0.0-increase-column-size-federated-fk','keycloak','META-INF/jpa-changelog-9.0.0.xml','2023-12-31 19:51:15',79,'EXECUTED','9:d5bc15a64117ccad481ce8792d4c608f','modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('9.0.0-recreate-constraints-after-column-increase','keycloak','META-INF/jpa-changelog-9.0.0.xml','2023-12-31 19:51:15',80,'MARK_RAN','9:077cba51999515f4d3e7ad5619ab592c','addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('9.0.1-add-index-to-client.client_id','keycloak','META-INF/jpa-changelog-9.0.1.xml','2023-12-31 19:51:16',81,'EXECUTED','9:be969f08a163bf47c6b9e9ead8ac2afb','createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT','',NULL,'4.23.2',NULL,NULL,'4052183780'),('9.0.1-KEYCLOAK-12579-drop-constraints','keycloak','META-INF/jpa-changelog-9.0.1.xml','2023-12-31 19:51:16',82,'MARK_RAN','9:6d3bb4408ba5a72f39bd8a0b301ec6e3','dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP','',NULL,'4.23.2',NULL,NULL,'4052183780'),('9.0.1-KEYCLOAK-12579-add-not-null-constraint','keycloak','META-INF/jpa-changelog-9.0.1.xml','2023-12-31 19:51:16',83,'EXECUTED','9:966bda61e46bebf3cc39518fbed52fa7','addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP','',NULL,'4.23.2',NULL,NULL,'4052183780'),('9.0.1-KEYCLOAK-12579-recreate-constraints','keycloak','META-INF/jpa-changelog-9.0.1.xml','2023-12-31 19:51:16',84,'MARK_RAN','9:8dcac7bdf7378e7d823cdfddebf72fda','addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP','',NULL,'4.23.2',NULL,NULL,'4052183780'),('9.0.1-add-index-to-events','keycloak','META-INF/jpa-changelog-9.0.1.xml','2023-12-31 19:51:16',85,'EXECUTED','9:7d93d602352a30c0c317e6a609b56599','createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY','',NULL,'4.23.2',NULL,NULL,'4052183780'),('map-remove-ri','keycloak','META-INF/jpa-changelog-11.0.0.xml','2023-12-31 19:51:16',86,'EXECUTED','9:71c5969e6cdd8d7b6f47cebc86d37627','dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9','',NULL,'4.23.2',NULL,NULL,'4052183780'),('map-remove-ri','keycloak','META-INF/jpa-changelog-12.0.0.xml','2023-12-31 19:51:16',87,'EXECUTED','9:a9ba7d47f065f041b7da856a81762021','dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('12.1.0-add-realm-localization-table','keycloak','META-INF/jpa-changelog-12.0.0.xml','2023-12-31 19:51:16',88,'EXECUTED','9:fffabce2bc01e1a8f5110d5278500065','createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS','',NULL,'4.23.2',NULL,NULL,'4052183780'),('default-roles','keycloak','META-INF/jpa-changelog-13.0.0.xml','2023-12-31 19:51:17',89,'EXECUTED','9:fa8a5b5445e3857f4b010bafb5009957','addColumn tableName=REALM; customChange','',NULL,'4.23.2',NULL,NULL,'4052183780'),('default-roles-cleanup','keycloak','META-INF/jpa-changelog-13.0.0.xml','2023-12-31 19:51:17',90,'EXECUTED','9:67ac3241df9a8582d591c5ed87125f39','dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES','',NULL,'4.23.2',NULL,NULL,'4052183780'),('13.0.0-KEYCLOAK-16844','keycloak','META-INF/jpa-changelog-13.0.0.xml','2023-12-31 19:51:17',91,'EXECUTED','9:ad1194d66c937e3ffc82386c050ba089','createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION','',NULL,'4.23.2',NULL,NULL,'4052183780'),('map-remove-ri-13.0.0','keycloak','META-INF/jpa-changelog-13.0.0.xml','2023-12-31 19:51:17',92,'EXECUTED','9:d9be619d94af5a2f5d07b9f003543b91','dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('13.0.0-KEYCLOAK-17992-drop-constraints','keycloak','META-INF/jpa-changelog-13.0.0.xml','2023-12-31 19:51:17',93,'MARK_RAN','9:544d201116a0fcc5a5da0925fbbc3bde','dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT','',NULL,'4.23.2',NULL,NULL,'4052183780'),('13.0.0-increase-column-size-federated','keycloak','META-INF/jpa-changelog-13.0.0.xml','2023-12-31 19:51:17',94,'EXECUTED','9:43c0c1055b6761b4b3e89de76d612ccf','modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT','',NULL,'4.23.2',NULL,NULL,'4052183780'),('13.0.0-KEYCLOAK-17992-recreate-constraints','keycloak','META-INF/jpa-changelog-13.0.0.xml','2023-12-31 19:51:17',95,'MARK_RAN','9:8bd711fd0330f4fe980494ca43ab1139','addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('json-string-accomodation-fixed','keycloak','META-INF/jpa-changelog-13.0.0.xml','2023-12-31 19:51:18',96,'EXECUTED','9:e07d2bc0970c348bb06fb63b1f82ddbf','addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE','',NULL,'4.23.2',NULL,NULL,'4052183780'),('14.0.0-KEYCLOAK-11019','keycloak','META-INF/jpa-changelog-14.0.0.xml','2023-12-31 19:51:18',97,'EXECUTED','9:24fb8611e97f29989bea412aa38d12b7','createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION','',NULL,'4.23.2',NULL,NULL,'4052183780'),('14.0.0-KEYCLOAK-18286','keycloak','META-INF/jpa-changelog-14.0.0.xml','2023-12-31 19:51:18',98,'MARK_RAN','9:259f89014ce2506ee84740cbf7163aa7','createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES','',NULL,'4.23.2',NULL,NULL,'4052183780'),('14.0.0-KEYCLOAK-18286-revert','keycloak','META-INF/jpa-changelog-14.0.0.xml','2023-12-31 19:51:18',99,'MARK_RAN','9:04baaf56c116ed19951cbc2cca584022','dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES','',NULL,'4.23.2',NULL,NULL,'4052183780'),('14.0.0-KEYCLOAK-18286-supported-dbs','keycloak','META-INF/jpa-changelog-14.0.0.xml','2023-12-31 19:51:18',100,'EXECUTED','9:bd2bd0fc7768cf0845ac96a8786fa735','createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES','',NULL,'4.23.2',NULL,NULL,'4052183780'),('14.0.0-KEYCLOAK-18286-unsupported-dbs','keycloak','META-INF/jpa-changelog-14.0.0.xml','2023-12-31 19:51:18',101,'MARK_RAN','9:d3d977031d431db16e2c181ce49d73e9','createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES','',NULL,'4.23.2',NULL,NULL,'4052183780'),('KEYCLOAK-17267-add-index-to-user-attributes','keycloak','META-INF/jpa-changelog-14.0.0.xml','2023-12-31 19:51:18',102,'EXECUTED','9:0b305d8d1277f3a89a0a53a659ad274c','createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE','',NULL,'4.23.2',NULL,NULL,'4052183780'),('KEYCLOAK-18146-add-saml-art-binding-identifier','keycloak','META-INF/jpa-changelog-14.0.0.xml','2023-12-31 19:51:18',103,'EXECUTED','9:2c374ad2cdfe20e2905a84c8fac48460','customChange','',NULL,'4.23.2',NULL,NULL,'4052183780'),('15.0.0-KEYCLOAK-18467','keycloak','META-INF/jpa-changelog-15.0.0.xml','2023-12-31 19:51:18',104,'EXECUTED','9:47a760639ac597360a8219f5b768b4de','addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('17.0.0-9562','keycloak','META-INF/jpa-changelog-17.0.0.xml','2023-12-31 19:51:19',105,'EXECUTED','9:a6272f0576727dd8cad2522335f5d99e','createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY','',NULL,'4.23.2',NULL,NULL,'4052183780'),('18.0.0-10625-IDX_ADMIN_EVENT_TIME','keycloak','META-INF/jpa-changelog-18.0.0.xml','2023-12-31 19:51:19',106,'EXECUTED','9:015479dbd691d9cc8669282f4828c41d','createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY','',NULL,'4.23.2',NULL,NULL,'4052183780'),('19.0.0-10135','keycloak','META-INF/jpa-changelog-19.0.0.xml','2023-12-31 19:51:19',107,'EXECUTED','9:9518e495fdd22f78ad6425cc30630221','customChange','',NULL,'4.23.2',NULL,NULL,'4052183780'),('20.0.0-12964-supported-dbs','keycloak','META-INF/jpa-changelog-20.0.0.xml','2023-12-31 19:51:19',108,'EXECUTED','9:f2e1331a71e0aa85e5608fe42f7f681c','createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE','',NULL,'4.23.2',NULL,NULL,'4052183780'),('20.0.0-12964-unsupported-dbs','keycloak','META-INF/jpa-changelog-20.0.0.xml','2023-12-31 19:51:19',109,'MARK_RAN','9:1a6fcaa85e20bdeae0a9ce49b41946a5','createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE','',NULL,'4.23.2',NULL,NULL,'4052183780'),('client-attributes-string-accomodation-fixed','keycloak','META-INF/jpa-changelog-20.0.0.xml','2023-12-31 19:51:19',110,'EXECUTED','9:3f332e13e90739ed0c35b0b25b7822ca','addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES','',NULL,'4.23.2',NULL,NULL,'4052183780'),('21.0.2-17277','keycloak','META-INF/jpa-changelog-21.0.2.xml','2023-12-31 19:51:19',111,'EXECUTED','9:7ee1f7a3fb8f5588f171fb9a6ab623c0','customChange','',NULL,'4.23.2',NULL,NULL,'4052183780'),('21.1.0-19404','keycloak','META-INF/jpa-changelog-21.1.0.xml','2023-12-31 19:51:20',112,'EXECUTED','9:3d7e830b52f33676b9d64f7f2b2ea634','modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER','',NULL,'4.23.2',NULL,NULL,'4052183780'),('21.1.0-19404-2','keycloak','META-INF/jpa-changelog-21.1.0.xml','2023-12-31 19:51:20',113,'MARK_RAN','9:627d032e3ef2c06c0e1f73d2ae25c26c','addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...','',NULL,'4.23.2',NULL,NULL,'4052183780'),('22.0.0-17484-updated','keycloak','META-INF/jpa-changelog-22.0.0.xml','2023-12-31 19:51:20',114,'EXECUTED','9:90af0bfd30cafc17b9f4d6eccd92b8b3','customChange','',NULL,'4.23.2',NULL,NULL,'4052183780'),('22.0.5-24031','keycloak','META-INF/jpa-changelog-22.0.0.xml','2023-12-31 19:51:20',115,'MARK_RAN','9:a60d2d7b315ec2d3eba9e2f145f9df28','customChange','',NULL,'4.23.2',NULL,NULL,'4052183780'),('23.0.0-12062','keycloak','META-INF/jpa-changelog-23.0.0.xml','2023-12-31 19:51:20',116,'EXECUTED','9:2168fbe728fec46ae9baf15bf80927b8','addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG','',NULL,'4.23.2',NULL,NULL,'4052183780'),('23.0.0-17258','keycloak','META-INF/jpa-changelog-23.0.0.xml','2023-12-31 19:51:20',117,'EXECUTED','9:36506d679a83bbfda85a27ea1864dca8','addColumn tableName=EVENT_ENTITY','',NULL,'4.23.2',NULL,NULL,'4052183780');
/*!40000 ALTER TABLE `DATABASECHANGELOG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DATABASECHANGELOGLOCK`
--

DROP TABLE IF EXISTS `DATABASECHANGELOGLOCK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DATABASECHANGELOGLOCK` (
  `ID` int NOT NULL,
  `LOCKED` bit(1) NOT NULL,
  `LOCKGRANTED` datetime DEFAULT NULL,
  `LOCKEDBY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DATABASECHANGELOGLOCK`
--

LOCK TABLES `DATABASECHANGELOGLOCK` WRITE;
/*!40000 ALTER TABLE `DATABASECHANGELOGLOCK` DISABLE KEYS */;
INSERT INTO `DATABASECHANGELOGLOCK` VALUES (1,_binary '\0',NULL,NULL),(1000,_binary '\0',NULL,NULL),(1001,_binary '\0',NULL,NULL);
/*!40000 ALTER TABLE `DATABASECHANGELOGLOCK` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DEFAULT_CLIENT_SCOPE`
--

DROP TABLE IF EXISTS `DEFAULT_CLIENT_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DEFAULT_CLIENT_SCOPE` (
  `REALM_ID` varchar(36) NOT NULL,
  `SCOPE_ID` varchar(36) NOT NULL,
  `DEFAULT_SCOPE` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`REALM_ID`,`SCOPE_ID`),
  KEY `IDX_DEFCLS_REALM` (`REALM_ID`),
  KEY `IDX_DEFCLS_SCOPE` (`SCOPE_ID`),
  CONSTRAINT `FK_R_DEF_CLI_SCOPE_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DEFAULT_CLIENT_SCOPE`
--

LOCK TABLES `DEFAULT_CLIENT_SCOPE` WRITE;
/*!40000 ALTER TABLE `DEFAULT_CLIENT_SCOPE` DISABLE KEYS */;
INSERT INTO `DEFAULT_CLIENT_SCOPE` VALUES ('7f59a3db-3ce6-4735-8d4e-b391c4609bcb','13e567cb-710f-4e81-b6dd-022d00453330',_binary ''),('7f59a3db-3ce6-4735-8d4e-b391c4609bcb','5758a2d8-b31c-47a7-822a-03089b8b6e2d',_binary ''),('7f59a3db-3ce6-4735-8d4e-b391c4609bcb','651c9698-aaaf-437b-be5f-e1fc8a2a9538',_binary ''),('7f59a3db-3ce6-4735-8d4e-b391c4609bcb','705952de-5767-4911-9def-668a8e40647e',_binary ''),('7f59a3db-3ce6-4735-8d4e-b391c4609bcb','7df8d38e-89af-4a79-93df-073190a8d983',_binary ''),('7f59a3db-3ce6-4735-8d4e-b391c4609bcb','8470c070-3cc4-4967-b4e3-502459d8d5cd',_binary '\0'),('7f59a3db-3ce6-4735-8d4e-b391c4609bcb','9028e6ec-23ba-474f-b0ae-2b7e75257d33',_binary ''),('7f59a3db-3ce6-4735-8d4e-b391c4609bcb','c52269a0-72c8-48f0-b43a-bce7c1afc81a',_binary '\0'),('7f59a3db-3ce6-4735-8d4e-b391c4609bcb','de8cf540-cc3c-48ae-a8f8-b9c698bcf422',_binary '\0'),('7f59a3db-3ce6-4735-8d4e-b391c4609bcb','e25c4206-b8b5-4cc7-b224-906210e66aed',_binary '\0');
/*!40000 ALTER TABLE `DEFAULT_CLIENT_SCOPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EVENT_ENTITY`
--

DROP TABLE IF EXISTS `EVENT_ENTITY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EVENT_ENTITY` (
  `ID` varchar(36) NOT NULL,
  `CLIENT_ID` varchar(255) DEFAULT NULL,
  `DETAILS_JSON` text,
  `ERROR` varchar(255) DEFAULT NULL,
  `IP_ADDRESS` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `SESSION_ID` varchar(255) DEFAULT NULL,
  `EVENT_TIME` bigint DEFAULT NULL,
  `TYPE` varchar(255) DEFAULT NULL,
  `USER_ID` varchar(255) DEFAULT NULL,
  `DETAILS_JSON_LONG_VALUE` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  PRIMARY KEY (`ID`),
  KEY `IDX_EVENT_TIME` (`REALM_ID`,`EVENT_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EVENT_ENTITY`
--

LOCK TABLES `EVENT_ENTITY` WRITE;
/*!40000 ALTER TABLE `EVENT_ENTITY` DISABLE KEYS */;
/*!40000 ALTER TABLE `EVENT_ENTITY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FEDERATED_IDENTITY`
--

DROP TABLE IF EXISTS `FEDERATED_IDENTITY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FEDERATED_IDENTITY` (
  `IDENTITY_PROVIDER` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `FEDERATED_USER_ID` varchar(255) DEFAULT NULL,
  `FEDERATED_USERNAME` varchar(255) DEFAULT NULL,
  `TOKEN` text,
  `USER_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`IDENTITY_PROVIDER`,`USER_ID`),
  KEY `IDX_FEDIDENTITY_USER` (`USER_ID`),
  KEY `IDX_FEDIDENTITY_FEDUSER` (`FEDERATED_USER_ID`),
  CONSTRAINT `FK404288B92EF007A6` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FEDERATED_IDENTITY`
--

LOCK TABLES `FEDERATED_IDENTITY` WRITE;
/*!40000 ALTER TABLE `FEDERATED_IDENTITY` DISABLE KEYS */;
/*!40000 ALTER TABLE `FEDERATED_IDENTITY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FEDERATED_USER`
--

DROP TABLE IF EXISTS `FEDERATED_USER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FEDERATED_USER` (
  `ID` varchar(255) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FEDERATED_USER`
--

LOCK TABLES `FEDERATED_USER` WRITE;
/*!40000 ALTER TABLE `FEDERATED_USER` DISABLE KEYS */;
/*!40000 ALTER TABLE `FEDERATED_USER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_ATTRIBUTE`
--

DROP TABLE IF EXISTS `FED_USER_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FED_USER_ATTRIBUTE` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  `VALUE` text,
  PRIMARY KEY (`ID`),
  KEY `IDX_FU_ATTRIBUTE` (`USER_ID`,`REALM_ID`,`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_ATTRIBUTE`
--

LOCK TABLES `FED_USER_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `FED_USER_ATTRIBUTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_CONSENT`
--

DROP TABLE IF EXISTS `FED_USER_CONSENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FED_USER_CONSENT` (
  `ID` varchar(36) NOT NULL,
  `CLIENT_ID` varchar(255) DEFAULT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  `CREATED_DATE` bigint DEFAULT NULL,
  `LAST_UPDATED_DATE` bigint DEFAULT NULL,
  `CLIENT_STORAGE_PROVIDER` varchar(36) DEFAULT NULL,
  `EXTERNAL_CLIENT_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_FU_CONSENT` (`USER_ID`,`CLIENT_ID`),
  KEY `IDX_FU_CONSENT_RU` (`REALM_ID`,`USER_ID`),
  KEY `IDX_FU_CNSNT_EXT` (`USER_ID`,`CLIENT_STORAGE_PROVIDER`,`EXTERNAL_CLIENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_CONSENT`
--

LOCK TABLES `FED_USER_CONSENT` WRITE;
/*!40000 ALTER TABLE `FED_USER_CONSENT` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_CONSENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_CONSENT_CL_SCOPE`
--

DROP TABLE IF EXISTS `FED_USER_CONSENT_CL_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FED_USER_CONSENT_CL_SCOPE` (
  `USER_CONSENT_ID` varchar(36) NOT NULL,
  `SCOPE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`USER_CONSENT_ID`,`SCOPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_CONSENT_CL_SCOPE`
--

LOCK TABLES `FED_USER_CONSENT_CL_SCOPE` WRITE;
/*!40000 ALTER TABLE `FED_USER_CONSENT_CL_SCOPE` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_CONSENT_CL_SCOPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_CREDENTIAL`
--

DROP TABLE IF EXISTS `FED_USER_CREDENTIAL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FED_USER_CREDENTIAL` (
  `ID` varchar(36) NOT NULL,
  `SALT` tinyblob,
  `TYPE` varchar(255) DEFAULT NULL,
  `CREATED_DATE` bigint DEFAULT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  `USER_LABEL` varchar(255) DEFAULT NULL,
  `SECRET_DATA` longtext,
  `CREDENTIAL_DATA` longtext,
  `PRIORITY` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_FU_CREDENTIAL` (`USER_ID`,`TYPE`),
  KEY `IDX_FU_CREDENTIAL_RU` (`REALM_ID`,`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_CREDENTIAL`
--

LOCK TABLES `FED_USER_CREDENTIAL` WRITE;
/*!40000 ALTER TABLE `FED_USER_CREDENTIAL` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_CREDENTIAL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_GROUP_MEMBERSHIP`
--

DROP TABLE IF EXISTS `FED_USER_GROUP_MEMBERSHIP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FED_USER_GROUP_MEMBERSHIP` (
  `GROUP_ID` varchar(36) NOT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`GROUP_ID`,`USER_ID`),
  KEY `IDX_FU_GROUP_MEMBERSHIP` (`USER_ID`,`GROUP_ID`),
  KEY `IDX_FU_GROUP_MEMBERSHIP_RU` (`REALM_ID`,`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_GROUP_MEMBERSHIP`
--

LOCK TABLES `FED_USER_GROUP_MEMBERSHIP` WRITE;
/*!40000 ALTER TABLE `FED_USER_GROUP_MEMBERSHIP` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_GROUP_MEMBERSHIP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_REQUIRED_ACTION`
--

DROP TABLE IF EXISTS `FED_USER_REQUIRED_ACTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FED_USER_REQUIRED_ACTION` (
  `REQUIRED_ACTION` varchar(255) NOT NULL DEFAULT ' ',
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`REQUIRED_ACTION`,`USER_ID`),
  KEY `IDX_FU_REQUIRED_ACTION` (`USER_ID`,`REQUIRED_ACTION`),
  KEY `IDX_FU_REQUIRED_ACTION_RU` (`REALM_ID`,`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_REQUIRED_ACTION`
--

LOCK TABLES `FED_USER_REQUIRED_ACTION` WRITE;
/*!40000 ALTER TABLE `FED_USER_REQUIRED_ACTION` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_REQUIRED_ACTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_ROLE_MAPPING`
--

DROP TABLE IF EXISTS `FED_USER_ROLE_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FED_USER_ROLE_MAPPING` (
  `ROLE_ID` varchar(36) NOT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ROLE_ID`,`USER_ID`),
  KEY `IDX_FU_ROLE_MAPPING` (`USER_ID`,`ROLE_ID`),
  KEY `IDX_FU_ROLE_MAPPING_RU` (`REALM_ID`,`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_ROLE_MAPPING`
--

LOCK TABLES `FED_USER_ROLE_MAPPING` WRITE;
/*!40000 ALTER TABLE `FED_USER_ROLE_MAPPING` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_ROLE_MAPPING` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GROUP_ATTRIBUTE`
--

DROP TABLE IF EXISTS `GROUP_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GROUP_ATTRIBUTE` (
  `ID` varchar(36) NOT NULL DEFAULT 'sybase-needs-something-here',
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `GROUP_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_GROUP_ATTR_GROUP` (`GROUP_ID`),
  KEY `IDX_GROUP_ATT_BY_NAME_VALUE` (`NAME`,`VALUE`),
  CONSTRAINT `FK_GROUP_ATTRIBUTE_GROUP` FOREIGN KEY (`GROUP_ID`) REFERENCES `KEYCLOAK_GROUP` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GROUP_ATTRIBUTE`
--

LOCK TABLES `GROUP_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `GROUP_ATTRIBUTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `GROUP_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GROUP_ROLE_MAPPING`
--

DROP TABLE IF EXISTS `GROUP_ROLE_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GROUP_ROLE_MAPPING` (
  `ROLE_ID` varchar(36) NOT NULL,
  `GROUP_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ROLE_ID`,`GROUP_ID`),
  KEY `IDX_GROUP_ROLE_MAPP_GROUP` (`GROUP_ID`),
  CONSTRAINT `FK_GROUP_ROLE_GROUP` FOREIGN KEY (`GROUP_ID`) REFERENCES `KEYCLOAK_GROUP` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GROUP_ROLE_MAPPING`
--

LOCK TABLES `GROUP_ROLE_MAPPING` WRITE;
/*!40000 ALTER TABLE `GROUP_ROLE_MAPPING` DISABLE KEYS */;
/*!40000 ALTER TABLE `GROUP_ROLE_MAPPING` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IDENTITY_PROVIDER`
--

DROP TABLE IF EXISTS `IDENTITY_PROVIDER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDENTITY_PROVIDER` (
  `INTERNAL_ID` varchar(36) NOT NULL,
  `ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `PROVIDER_ALIAS` varchar(255) DEFAULT NULL,
  `PROVIDER_ID` varchar(255) DEFAULT NULL,
  `STORE_TOKEN` bit(1) NOT NULL DEFAULT b'0',
  `AUTHENTICATE_BY_DEFAULT` bit(1) NOT NULL DEFAULT b'0',
  `REALM_ID` varchar(36) DEFAULT NULL,
  `ADD_TOKEN_ROLE` bit(1) NOT NULL DEFAULT b'1',
  `TRUST_EMAIL` bit(1) NOT NULL DEFAULT b'0',
  `FIRST_BROKER_LOGIN_FLOW_ID` varchar(36) DEFAULT NULL,
  `POST_BROKER_LOGIN_FLOW_ID` varchar(36) DEFAULT NULL,
  `PROVIDER_DISPLAY_NAME` varchar(255) DEFAULT NULL,
  `LINK_ONLY` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`INTERNAL_ID`),
  UNIQUE KEY `UK_2DAELWNIBJI49AVXSRTUF6XJ33` (`PROVIDER_ALIAS`,`REALM_ID`),
  KEY `IDX_IDENT_PROV_REALM` (`REALM_ID`),
  CONSTRAINT `FK2B4EBC52AE5C3B34` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IDENTITY_PROVIDER`
--

LOCK TABLES `IDENTITY_PROVIDER` WRITE;
/*!40000 ALTER TABLE `IDENTITY_PROVIDER` DISABLE KEYS */;
/*!40000 ALTER TABLE `IDENTITY_PROVIDER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IDENTITY_PROVIDER_CONFIG`
--

DROP TABLE IF EXISTS `IDENTITY_PROVIDER_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDENTITY_PROVIDER_CONFIG` (
  `IDENTITY_PROVIDER_ID` varchar(36) NOT NULL,
  `VALUE` longtext,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`IDENTITY_PROVIDER_ID`,`NAME`),
  CONSTRAINT `FKDC4897CF864C4E43` FOREIGN KEY (`IDENTITY_PROVIDER_ID`) REFERENCES `IDENTITY_PROVIDER` (`INTERNAL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IDENTITY_PROVIDER_CONFIG`
--

LOCK TABLES `IDENTITY_PROVIDER_CONFIG` WRITE;
/*!40000 ALTER TABLE `IDENTITY_PROVIDER_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `IDENTITY_PROVIDER_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IDENTITY_PROVIDER_MAPPER`
--

DROP TABLE IF EXISTS `IDENTITY_PROVIDER_MAPPER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDENTITY_PROVIDER_MAPPER` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `IDP_ALIAS` varchar(255) NOT NULL,
  `IDP_MAPPER_NAME` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_ID_PROV_MAPP_REALM` (`REALM_ID`),
  CONSTRAINT `FK_IDPM_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IDENTITY_PROVIDER_MAPPER`
--

LOCK TABLES `IDENTITY_PROVIDER_MAPPER` WRITE;
/*!40000 ALTER TABLE `IDENTITY_PROVIDER_MAPPER` DISABLE KEYS */;
/*!40000 ALTER TABLE `IDENTITY_PROVIDER_MAPPER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IDP_MAPPER_CONFIG`
--

DROP TABLE IF EXISTS `IDP_MAPPER_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDP_MAPPER_CONFIG` (
  `IDP_MAPPER_ID` varchar(36) NOT NULL,
  `VALUE` longtext,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`IDP_MAPPER_ID`,`NAME`),
  CONSTRAINT `FK_IDPMCONFIG` FOREIGN KEY (`IDP_MAPPER_ID`) REFERENCES `IDENTITY_PROVIDER_MAPPER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IDP_MAPPER_CONFIG`
--

LOCK TABLES `IDP_MAPPER_CONFIG` WRITE;
/*!40000 ALTER TABLE `IDP_MAPPER_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `IDP_MAPPER_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `KEYCLOAK_GROUP`
--

DROP TABLE IF EXISTS `KEYCLOAK_GROUP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `KEYCLOAK_GROUP` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `PARENT_GROUP` varchar(36) NOT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SIBLING_NAMES` (`REALM_ID`,`PARENT_GROUP`,`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `KEYCLOAK_GROUP`
--

LOCK TABLES `KEYCLOAK_GROUP` WRITE;
/*!40000 ALTER TABLE `KEYCLOAK_GROUP` DISABLE KEYS */;
/*!40000 ALTER TABLE `KEYCLOAK_GROUP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `KEYCLOAK_ROLE`
--

DROP TABLE IF EXISTS `KEYCLOAK_ROLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `KEYCLOAK_ROLE` (
  `ID` varchar(36) NOT NULL,
  `CLIENT_REALM_CONSTRAINT` varchar(255) DEFAULT NULL,
  `CLIENT_ROLE` bit(1) DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `NAME` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `CLIENT` varchar(36) DEFAULT NULL,
  `REALM` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_J3RWUVD56ONTGSUHOGM184WW2-2` (`NAME`,`CLIENT_REALM_CONSTRAINT`),
  KEY `IDX_KEYCLOAK_ROLE_CLIENT` (`CLIENT`),
  KEY `IDX_KEYCLOAK_ROLE_REALM` (`REALM`),
  CONSTRAINT `FK_6VYQFE4CN4WLQ8R6KT5VDSJ5C` FOREIGN KEY (`REALM`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `KEYCLOAK_ROLE`
--

LOCK TABLES `KEYCLOAK_ROLE` WRITE;
/*!40000 ALTER TABLE `KEYCLOAK_ROLE` DISABLE KEYS */;
INSERT INTO `KEYCLOAK_ROLE` VALUES ('06a6bd55-fce5-47d8-8d61-caf219216913','6a200eb6-3191-496c-8e4c-dbf67658fd2e',_binary '','${role_manage-authorization}','manage-authorization','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','6a200eb6-3191-496c-8e4c-dbf67658fd2e',NULL),('0a78f5d6-b6b8-4107-b2ea-511f0de0173a','6a200eb6-3191-496c-8e4c-dbf67658fd2e',_binary '','${role_impersonation}','impersonation','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','6a200eb6-3191-496c-8e4c-dbf67658fd2e',NULL),('13739d66-87b6-40e0-bb7d-e3299c21638d','3cae072d-233a-4922-b913-1966d129113a',_binary '','${role_manage-account}','manage-account','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','3cae072d-233a-4922-b913-1966d129113a',NULL),('191ab440-a308-4c46-8dbd-f93634ed29c0','7f59a3db-3ce6-4735-8d4e-b391c4609bcb',_binary '\0','${role_offline-access}','offline_access','7f59a3db-3ce6-4735-8d4e-b391c4609bcb',NULL,NULL),('2409d900-3e39-4b83-aaf0-5aa0bc05b4ac','3cae072d-233a-4922-b913-1966d129113a',_binary '','${role_view-consent}','view-consent','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','3cae072d-233a-4922-b913-1966d129113a',NULL),('26123283-ca5f-4e3b-bd2c-802b23c15d1f','6a200eb6-3191-496c-8e4c-dbf67658fd2e',_binary '','${role_view-identity-providers}','view-identity-providers','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','6a200eb6-3191-496c-8e4c-dbf67658fd2e',NULL),('29046e39-a5a8-4b37-8984-edf53da00ad9','3cae072d-233a-4922-b913-1966d129113a',_binary '','${role_manage-account-links}','manage-account-links','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','3cae072d-233a-4922-b913-1966d129113a',NULL),('33c842e9-c3a9-4aac-a70f-d4850645b3da','6a200eb6-3191-496c-8e4c-dbf67658fd2e',_binary '','${role_view-events}','view-events','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','6a200eb6-3191-496c-8e4c-dbf67658fd2e',NULL),('34834b02-5edf-4112-8910-9c94e3fe2c8b','6a200eb6-3191-496c-8e4c-dbf67658fd2e',_binary '','${role_query-groups}','query-groups','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','6a200eb6-3191-496c-8e4c-dbf67658fd2e',NULL),('4d9a64e9-bc80-4f0a-a7bb-d5d91a3f1e2b','6a200eb6-3191-496c-8e4c-dbf67658fd2e',_binary '','${role_query-clients}','query-clients','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','6a200eb6-3191-496c-8e4c-dbf67658fd2e',NULL),('5709bcbf-1636-4872-9235-e5fea0fd77d3','3cae072d-233a-4922-b913-1966d129113a',_binary '','${role_view-groups}','view-groups','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','3cae072d-233a-4922-b913-1966d129113a',NULL),('6ad2a9b1-f3f5-40e7-9681-87e38c31fa5d','3cae072d-233a-4922-b913-1966d129113a',_binary '','${role_manage-consent}','manage-consent','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','3cae072d-233a-4922-b913-1966d129113a',NULL),('78a7c8ee-0752-4df1-9e2e-27b8bee23aae','6a200eb6-3191-496c-8e4c-dbf67658fd2e',_binary '','${role_query-realms}','query-realms','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','6a200eb6-3191-496c-8e4c-dbf67658fd2e',NULL),('9607e49a-6017-4904-ab94-7786b2e40bee','6a200eb6-3191-496c-8e4c-dbf67658fd2e',_binary '','${role_manage-realm}','manage-realm','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','6a200eb6-3191-496c-8e4c-dbf67658fd2e',NULL),('9bb47083-db3b-41d8-90d1-81e44a833d8d','3cae072d-233a-4922-b913-1966d129113a',_binary '','${role_view-profile}','view-profile','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','3cae072d-233a-4922-b913-1966d129113a',NULL),('9d7fd74c-df90-4a9e-95e4-0c847e9dc764','6a200eb6-3191-496c-8e4c-dbf67658fd2e',_binary '','${role_query-users}','query-users','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','6a200eb6-3191-496c-8e4c-dbf67658fd2e',NULL),('aea87a71-fc14-4a20-9235-6b83fc5eeff2','6a200eb6-3191-496c-8e4c-dbf67658fd2e',_binary '','${role_view-realm}','view-realm','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','6a200eb6-3191-496c-8e4c-dbf67658fd2e',NULL),('af260de1-182b-43db-ad8f-7a16342ef7e0','6a200eb6-3191-496c-8e4c-dbf67658fd2e',_binary '','${role_manage-users}','manage-users','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','6a200eb6-3191-496c-8e4c-dbf67658fd2e',NULL),('b86cd9d1-90ec-474e-a2bc-46d348bfff9b','6a200eb6-3191-496c-8e4c-dbf67658fd2e',_binary '','${role_view-users}','view-users','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','6a200eb6-3191-496c-8e4c-dbf67658fd2e',NULL),('ba3eb3aa-ac9a-4933-b976-107ac843e188','7f59a3db-3ce6-4735-8d4e-b391c4609bcb',_binary '\0','${role_uma_authorization}','uma_authorization','7f59a3db-3ce6-4735-8d4e-b391c4609bcb',NULL,NULL),('bcd5d69f-b8ed-401c-abcc-0298245db705','3cae072d-233a-4922-b913-1966d129113a',_binary '','${role_delete-account}','delete-account','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','3cae072d-233a-4922-b913-1966d129113a',NULL),('bf06d95c-cb6f-4fa4-b4e7-9584e3cabfa6','6a200eb6-3191-496c-8e4c-dbf67658fd2e',_binary '','${role_manage-events}','manage-events','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','6a200eb6-3191-496c-8e4c-dbf67658fd2e',NULL),('bff1746b-37d3-438d-813a-25c0aded4848','7f59a3db-3ce6-4735-8d4e-b391c4609bcb',_binary '\0','${role_create-realm}','create-realm','7f59a3db-3ce6-4735-8d4e-b391c4609bcb',NULL,NULL),('ca313f0b-fc18-49cf-a138-978368628548','3cae072d-233a-4922-b913-1966d129113a',_binary '','${role_view-applications}','view-applications','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','3cae072d-233a-4922-b913-1966d129113a',NULL),('cb8670aa-2456-415a-9197-ed2c67de85fd','6a200eb6-3191-496c-8e4c-dbf67658fd2e',_binary '','${role_view-clients}','view-clients','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','6a200eb6-3191-496c-8e4c-dbf67658fd2e',NULL),('d8d07b77-5f4d-47fc-8ad7-a688ddc70ff0','91fbe4fb-e4b5-4a4b-b6d5-bf80c4f4fe6a',_binary '','${role_read-token}','read-token','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','91fbe4fb-e4b5-4a4b-b6d5-bf80c4f4fe6a',NULL),('dc84eb3b-359f-45bc-aaee-73d11486e02c','7f59a3db-3ce6-4735-8d4e-b391c4609bcb',_binary '\0','${role_admin}','admin','7f59a3db-3ce6-4735-8d4e-b391c4609bcb',NULL,NULL),('eb2e38ad-a994-4f88-88c7-b37e63ecc8c2','6a200eb6-3191-496c-8e4c-dbf67658fd2e',_binary '','${role_manage-clients}','manage-clients','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','6a200eb6-3191-496c-8e4c-dbf67658fd2e',NULL),('eba2d389-c75f-4ddd-863d-b6acda709b0c','6a200eb6-3191-496c-8e4c-dbf67658fd2e',_binary '','${role_create-client}','create-client','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','6a200eb6-3191-496c-8e4c-dbf67658fd2e',NULL),('ed3d10cc-09a0-4b7f-a623-d64128d97d9e','a1724120-09b9-4727-b44b-69735af49212',_binary '',NULL,'uma_protection','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','a1724120-09b9-4727-b44b-69735af49212',NULL),('ee32292c-56c1-43ba-992a-d3b84a3aa9b1','6a200eb6-3191-496c-8e4c-dbf67658fd2e',_binary '','${role_manage-identity-providers}','manage-identity-providers','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','6a200eb6-3191-496c-8e4c-dbf67658fd2e',NULL),('f20316c5-61e1-46fb-b221-64e018d0cf49','6a200eb6-3191-496c-8e4c-dbf67658fd2e',_binary '','${role_view-authorization}','view-authorization','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','6a200eb6-3191-496c-8e4c-dbf67658fd2e',NULL),('fbda23ea-5774-4c94-bea9-579347d92fc1','7f59a3db-3ce6-4735-8d4e-b391c4609bcb',_binary '\0','${role_default-roles}','default-roles-master','7f59a3db-3ce6-4735-8d4e-b391c4609bcb',NULL,NULL);
/*!40000 ALTER TABLE `KEYCLOAK_ROLE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MIGRATION_MODEL`
--

DROP TABLE IF EXISTS `MIGRATION_MODEL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MIGRATION_MODEL` (
  `ID` varchar(36) NOT NULL,
  `VERSION` varchar(36) DEFAULT NULL,
  `UPDATE_TIME` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `IDX_UPDATE_TIME` (`UPDATE_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MIGRATION_MODEL`
--

LOCK TABLES `MIGRATION_MODEL` WRITE;
/*!40000 ALTER TABLE `MIGRATION_MODEL` DISABLE KEYS */;
INSERT INTO `MIGRATION_MODEL` VALUES ('0vn10','23.0.3',1704052281);
/*!40000 ALTER TABLE `MIGRATION_MODEL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OFFLINE_CLIENT_SESSION`
--

DROP TABLE IF EXISTS `OFFLINE_CLIENT_SESSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OFFLINE_CLIENT_SESSION` (
  `USER_SESSION_ID` varchar(36) NOT NULL,
  `CLIENT_ID` varchar(255) NOT NULL,
  `OFFLINE_FLAG` varchar(4) NOT NULL,
  `TIMESTAMP` int DEFAULT NULL,
  `DATA` longtext,
  `CLIENT_STORAGE_PROVIDER` varchar(36) NOT NULL DEFAULT 'local',
  `EXTERNAL_CLIENT_ID` varchar(255) NOT NULL DEFAULT 'local',
  PRIMARY KEY (`USER_SESSION_ID`,`CLIENT_ID`,`CLIENT_STORAGE_PROVIDER`,`EXTERNAL_CLIENT_ID`,`OFFLINE_FLAG`),
  KEY `IDX_US_SESS_ID_ON_CL_SESS` (`USER_SESSION_ID`),
  KEY `IDX_OFFLINE_CSS_PRELOAD` (`CLIENT_ID`,`OFFLINE_FLAG`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OFFLINE_CLIENT_SESSION`
--

LOCK TABLES `OFFLINE_CLIENT_SESSION` WRITE;
/*!40000 ALTER TABLE `OFFLINE_CLIENT_SESSION` DISABLE KEYS */;
/*!40000 ALTER TABLE `OFFLINE_CLIENT_SESSION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OFFLINE_USER_SESSION`
--

DROP TABLE IF EXISTS `OFFLINE_USER_SESSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OFFLINE_USER_SESSION` (
  `USER_SESSION_ID` varchar(36) NOT NULL,
  `USER_ID` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `CREATED_ON` int NOT NULL,
  `OFFLINE_FLAG` varchar(4) NOT NULL,
  `DATA` longtext,
  `LAST_SESSION_REFRESH` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`USER_SESSION_ID`,`OFFLINE_FLAG`),
  KEY `IDX_OFFLINE_USS_CREATEDON` (`CREATED_ON`),
  KEY `IDX_OFFLINE_USS_PRELOAD` (`OFFLINE_FLAG`,`CREATED_ON`,`USER_SESSION_ID`),
  KEY `IDX_OFFLINE_USS_BY_USER` (`USER_ID`,`REALM_ID`,`OFFLINE_FLAG`),
  KEY `IDX_OFFLINE_USS_BY_USERSESS` (`REALM_ID`,`OFFLINE_FLAG`,`USER_SESSION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OFFLINE_USER_SESSION`
--

LOCK TABLES `OFFLINE_USER_SESSION` WRITE;
/*!40000 ALTER TABLE `OFFLINE_USER_SESSION` DISABLE KEYS */;
/*!40000 ALTER TABLE `OFFLINE_USER_SESSION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `POLICY_CONFIG`
--

DROP TABLE IF EXISTS `POLICY_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `POLICY_CONFIG` (
  `POLICY_ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VALUE` longtext,
  PRIMARY KEY (`POLICY_ID`,`NAME`),
  CONSTRAINT `FKDC34197CF864C4E43` FOREIGN KEY (`POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `POLICY_CONFIG`
--

LOCK TABLES `POLICY_CONFIG` WRITE;
/*!40000 ALTER TABLE `POLICY_CONFIG` DISABLE KEYS */;
INSERT INTO `POLICY_CONFIG` VALUES ('75e10802-5f6d-4802-8020-5a494dc10f2b','defaultResourceType','urn:home-portal:resources:default'),('7654d293-2101-4fda-ab02-5ecffc35434e','code','// by default, grants any permission associated with this policy\n$evaluation.grant();\n');
/*!40000 ALTER TABLE `POLICY_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PROTOCOL_MAPPER`
--

DROP TABLE IF EXISTS `PROTOCOL_MAPPER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PROTOCOL_MAPPER` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `PROTOCOL` varchar(255) NOT NULL,
  `PROTOCOL_MAPPER_NAME` varchar(255) NOT NULL,
  `CLIENT_ID` varchar(36) DEFAULT NULL,
  `CLIENT_SCOPE_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_PROTOCOL_MAPPER_CLIENT` (`CLIENT_ID`),
  KEY `IDX_CLSCOPE_PROTMAP` (`CLIENT_SCOPE_ID`),
  CONSTRAINT `FK_CLI_SCOPE_MAPPER` FOREIGN KEY (`CLIENT_SCOPE_ID`) REFERENCES `CLIENT_SCOPE` (`ID`),
  CONSTRAINT `FK_PCM_REALM` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PROTOCOL_MAPPER`
--

LOCK TABLES `PROTOCOL_MAPPER` WRITE;
/*!40000 ALTER TABLE `PROTOCOL_MAPPER` DISABLE KEYS */;
INSERT INTO `PROTOCOL_MAPPER` VALUES ('0b73a096-16ac-426a-b1e5-9febb5325b5e','email','openid-connect','oidc-usermodel-attribute-mapper',NULL,'13e567cb-710f-4e81-b6dd-022d00453330'),('11ce5876-1901-497d-ab88-b7d0b34977c6','realm roles','openid-connect','oidc-usermodel-realm-role-mapper',NULL,'7df8d38e-89af-4a79-93df-073190a8d983'),('137f3c75-5153-4b9b-ac92-cfd5a721bd44','middle name','openid-connect','oidc-usermodel-attribute-mapper',NULL,'5758a2d8-b31c-47a7-822a-03089b8b6e2d'),('1f055b68-452b-486a-8444-aaec9e41fd11','full name','openid-connect','oidc-full-name-mapper',NULL,'5758a2d8-b31c-47a7-822a-03089b8b6e2d'),('268186a3-084b-4bd2-a5b9-b6df1d79b959','updated at','openid-connect','oidc-usermodel-attribute-mapper',NULL,'5758a2d8-b31c-47a7-822a-03089b8b6e2d'),('2c932acc-90bc-4d7b-8418-3dbc35bd2c60','allowed web origins','openid-connect','oidc-allowed-origins-mapper',NULL,'705952de-5767-4911-9def-668a8e40647e'),('3abd51a7-03d8-41ac-b23e-718f863d7afb','zoneinfo','openid-connect','oidc-usermodel-attribute-mapper',NULL,'5758a2d8-b31c-47a7-822a-03089b8b6e2d'),('50598eb9-ed45-4f5d-835e-531da1bbe1d2','family name','openid-connect','oidc-usermodel-attribute-mapper',NULL,'5758a2d8-b31c-47a7-822a-03089b8b6e2d'),('5088a950-d5d1-431c-ad21-21dbbebaa4ac','phone number','openid-connect','oidc-usermodel-attribute-mapper',NULL,'de8cf540-cc3c-48ae-a8f8-b9c698bcf422'),('536c3d61-82dc-4ddb-9a9c-6dc73ff94214','groups','openid-connect','oidc-usermodel-realm-role-mapper',NULL,'c52269a0-72c8-48f0-b43a-bce7c1afc81a'),('59c273be-6452-4b54-9894-d5bf4228a478','username','openid-connect','oidc-usermodel-attribute-mapper',NULL,'5758a2d8-b31c-47a7-822a-03089b8b6e2d'),('5d8d04c1-0bd4-4c86-b6e8-2309ccb75df8','Client Host','openid-connect','oidc-usersessionmodel-note-mapper','a1724120-09b9-4727-b44b-69735af49212',NULL),('6148be48-2985-4a94-a9fb-78599d3b8506','acr loa level','openid-connect','oidc-acr-mapper',NULL,'651c9698-aaaf-437b-be5f-e1fc8a2a9538'),('75795b16-14fc-4f63-8871-7e7bd5766c58','role list','saml','saml-role-list-mapper',NULL,'9028e6ec-23ba-474f-b0ae-2b7e75257d33'),('7870e17e-f396-48ca-8659-660fc5acdc00','birthdate','openid-connect','oidc-usermodel-attribute-mapper',NULL,'5758a2d8-b31c-47a7-822a-03089b8b6e2d'),('78d46984-6951-476e-9040-f3ac110af4b0','locale','openid-connect','oidc-usermodel-attribute-mapper',NULL,'5758a2d8-b31c-47a7-822a-03089b8b6e2d'),('84745641-fc45-4a9a-bda8-e12530316f77','upn','openid-connect','oidc-usermodel-attribute-mapper',NULL,'c52269a0-72c8-48f0-b43a-bce7c1afc81a'),('86583377-a02a-4464-a992-2f287063b15d','phone number verified','openid-connect','oidc-usermodel-attribute-mapper',NULL,'de8cf540-cc3c-48ae-a8f8-b9c698bcf422'),('9760481a-a78c-4f14-928e-8621e9682eba','address','openid-connect','oidc-address-mapper',NULL,'8470c070-3cc4-4967-b4e3-502459d8d5cd'),('97b093b6-6102-4283-8957-7eb856286ada','locale','openid-connect','oidc-usermodel-attribute-mapper','ef4d1c45-b293-4ce2-b700-2ef194731ba1',NULL),('abf07b2e-98bd-40d8-9d4f-8756427bcea3','email verified','openid-connect','oidc-usermodel-property-mapper',NULL,'13e567cb-710f-4e81-b6dd-022d00453330'),('b06fd0c0-ee03-4a63-b77f-875633e48388','client roles','openid-connect','oidc-usermodel-client-role-mapper',NULL,'7df8d38e-89af-4a79-93df-073190a8d983'),('b47ecfe4-d3e0-479d-b77e-581c3ca3e14d','website','openid-connect','oidc-usermodel-attribute-mapper',NULL,'5758a2d8-b31c-47a7-822a-03089b8b6e2d'),('b730fbf8-c135-46d3-b6aa-641e4dc27ca7','gender','openid-connect','oidc-usermodel-attribute-mapper',NULL,'5758a2d8-b31c-47a7-822a-03089b8b6e2d'),('c5fc8e2b-1177-449c-b526-bcd1b5f77850','profile','openid-connect','oidc-usermodel-attribute-mapper',NULL,'5758a2d8-b31c-47a7-822a-03089b8b6e2d'),('ca2c78f1-2254-4fa1-82fe-4c2ed08ac523','audience resolve','openid-connect','oidc-audience-resolve-mapper',NULL,'7df8d38e-89af-4a79-93df-073190a8d983'),('d4711ed9-8b3f-4894-9a72-553d79137df5','given name','openid-connect','oidc-usermodel-attribute-mapper',NULL,'5758a2d8-b31c-47a7-822a-03089b8b6e2d'),('db60a20d-9ae3-4d62-b7d9-9b538df99abe','audience resolve','openid-connect','oidc-audience-resolve-mapper','77bec48a-5470-45a3-bfd6-8fe16883bbf4',NULL),('de67ca21-6020-48c4-b18a-071baabc054e','nickname','openid-connect','oidc-usermodel-attribute-mapper',NULL,'5758a2d8-b31c-47a7-822a-03089b8b6e2d'),('df666e1a-e261-4b4a-a44b-92ff46d10aa7','picture','openid-connect','oidc-usermodel-attribute-mapper',NULL,'5758a2d8-b31c-47a7-822a-03089b8b6e2d'),('eeb67f75-448d-4edc-a120-e9beb24b9785','Client IP Address','openid-connect','oidc-usersessionmodel-note-mapper','a1724120-09b9-4727-b44b-69735af49212',NULL),('f75e1f9a-28ce-4070-bb76-7b8f58228002','Client ID','openid-connect','oidc-usersessionmodel-note-mapper','a1724120-09b9-4727-b44b-69735af49212',NULL);
/*!40000 ALTER TABLE `PROTOCOL_MAPPER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PROTOCOL_MAPPER_CONFIG`
--

DROP TABLE IF EXISTS `PROTOCOL_MAPPER_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PROTOCOL_MAPPER_CONFIG` (
  `PROTOCOL_MAPPER_ID` varchar(36) NOT NULL,
  `VALUE` longtext,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`PROTOCOL_MAPPER_ID`,`NAME`),
  CONSTRAINT `FK_PMCONFIG` FOREIGN KEY (`PROTOCOL_MAPPER_ID`) REFERENCES `PROTOCOL_MAPPER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PROTOCOL_MAPPER_CONFIG`
--

LOCK TABLES `PROTOCOL_MAPPER_CONFIG` WRITE;
/*!40000 ALTER TABLE `PROTOCOL_MAPPER_CONFIG` DISABLE KEYS */;
INSERT INTO `PROTOCOL_MAPPER_CONFIG` VALUES ('0b73a096-16ac-426a-b1e5-9febb5325b5e','true','access.token.claim'),('0b73a096-16ac-426a-b1e5-9febb5325b5e','email','claim.name'),('0b73a096-16ac-426a-b1e5-9febb5325b5e','true','id.token.claim'),('0b73a096-16ac-426a-b1e5-9febb5325b5e','true','introspection.token.claim'),('0b73a096-16ac-426a-b1e5-9febb5325b5e','String','jsonType.label'),('0b73a096-16ac-426a-b1e5-9febb5325b5e','email','user.attribute'),('0b73a096-16ac-426a-b1e5-9febb5325b5e','true','userinfo.token.claim'),('11ce5876-1901-497d-ab88-b7d0b34977c6','true','access.token.claim'),('11ce5876-1901-497d-ab88-b7d0b34977c6','realm_access.roles','claim.name'),('11ce5876-1901-497d-ab88-b7d0b34977c6','true','introspection.token.claim'),('11ce5876-1901-497d-ab88-b7d0b34977c6','String','jsonType.label'),('11ce5876-1901-497d-ab88-b7d0b34977c6','true','multivalued'),('11ce5876-1901-497d-ab88-b7d0b34977c6','foo','user.attribute'),('137f3c75-5153-4b9b-ac92-cfd5a721bd44','true','access.token.claim'),('137f3c75-5153-4b9b-ac92-cfd5a721bd44','middle_name','claim.name'),('137f3c75-5153-4b9b-ac92-cfd5a721bd44','true','id.token.claim'),('137f3c75-5153-4b9b-ac92-cfd5a721bd44','true','introspection.token.claim'),('137f3c75-5153-4b9b-ac92-cfd5a721bd44','String','jsonType.label'),('137f3c75-5153-4b9b-ac92-cfd5a721bd44','middleName','user.attribute'),('137f3c75-5153-4b9b-ac92-cfd5a721bd44','true','userinfo.token.claim'),('1f055b68-452b-486a-8444-aaec9e41fd11','true','access.token.claim'),('1f055b68-452b-486a-8444-aaec9e41fd11','true','id.token.claim'),('1f055b68-452b-486a-8444-aaec9e41fd11','true','introspection.token.claim'),('1f055b68-452b-486a-8444-aaec9e41fd11','true','userinfo.token.claim'),('268186a3-084b-4bd2-a5b9-b6df1d79b959','true','access.token.claim'),('268186a3-084b-4bd2-a5b9-b6df1d79b959','updated_at','claim.name'),('268186a3-084b-4bd2-a5b9-b6df1d79b959','true','id.token.claim'),('268186a3-084b-4bd2-a5b9-b6df1d79b959','true','introspection.token.claim'),('268186a3-084b-4bd2-a5b9-b6df1d79b959','long','jsonType.label'),('268186a3-084b-4bd2-a5b9-b6df1d79b959','updatedAt','user.attribute'),('268186a3-084b-4bd2-a5b9-b6df1d79b959','true','userinfo.token.claim'),('2c932acc-90bc-4d7b-8418-3dbc35bd2c60','true','access.token.claim'),('2c932acc-90bc-4d7b-8418-3dbc35bd2c60','true','introspection.token.claim'),('3abd51a7-03d8-41ac-b23e-718f863d7afb','true','access.token.claim'),('3abd51a7-03d8-41ac-b23e-718f863d7afb','zoneinfo','claim.name'),('3abd51a7-03d8-41ac-b23e-718f863d7afb','true','id.token.claim'),('3abd51a7-03d8-41ac-b23e-718f863d7afb','true','introspection.token.claim'),('3abd51a7-03d8-41ac-b23e-718f863d7afb','String','jsonType.label'),('3abd51a7-03d8-41ac-b23e-718f863d7afb','zoneinfo','user.attribute'),('3abd51a7-03d8-41ac-b23e-718f863d7afb','true','userinfo.token.claim'),('50598eb9-ed45-4f5d-835e-531da1bbe1d2','true','access.token.claim'),('50598eb9-ed45-4f5d-835e-531da1bbe1d2','family_name','claim.name'),('50598eb9-ed45-4f5d-835e-531da1bbe1d2','true','id.token.claim'),('50598eb9-ed45-4f5d-835e-531da1bbe1d2','true','introspection.token.claim'),('50598eb9-ed45-4f5d-835e-531da1bbe1d2','String','jsonType.label'),('50598eb9-ed45-4f5d-835e-531da1bbe1d2','lastName','user.attribute'),('50598eb9-ed45-4f5d-835e-531da1bbe1d2','true','userinfo.token.claim'),('5088a950-d5d1-431c-ad21-21dbbebaa4ac','true','access.token.claim'),('5088a950-d5d1-431c-ad21-21dbbebaa4ac','phone_number','claim.name'),('5088a950-d5d1-431c-ad21-21dbbebaa4ac','true','id.token.claim'),('5088a950-d5d1-431c-ad21-21dbbebaa4ac','true','introspection.token.claim'),('5088a950-d5d1-431c-ad21-21dbbebaa4ac','String','jsonType.label'),('5088a950-d5d1-431c-ad21-21dbbebaa4ac','phoneNumber','user.attribute'),('5088a950-d5d1-431c-ad21-21dbbebaa4ac','true','userinfo.token.claim'),('536c3d61-82dc-4ddb-9a9c-6dc73ff94214','true','access.token.claim'),('536c3d61-82dc-4ddb-9a9c-6dc73ff94214','groups','claim.name'),('536c3d61-82dc-4ddb-9a9c-6dc73ff94214','true','id.token.claim'),('536c3d61-82dc-4ddb-9a9c-6dc73ff94214','true','introspection.token.claim'),('536c3d61-82dc-4ddb-9a9c-6dc73ff94214','String','jsonType.label'),('536c3d61-82dc-4ddb-9a9c-6dc73ff94214','true','multivalued'),('536c3d61-82dc-4ddb-9a9c-6dc73ff94214','foo','user.attribute'),('59c273be-6452-4b54-9894-d5bf4228a478','true','access.token.claim'),('59c273be-6452-4b54-9894-d5bf4228a478','preferred_username','claim.name'),('59c273be-6452-4b54-9894-d5bf4228a478','true','id.token.claim'),('59c273be-6452-4b54-9894-d5bf4228a478','true','introspection.token.claim'),('59c273be-6452-4b54-9894-d5bf4228a478','String','jsonType.label'),('59c273be-6452-4b54-9894-d5bf4228a478','username','user.attribute'),('59c273be-6452-4b54-9894-d5bf4228a478','true','userinfo.token.claim'),('5d8d04c1-0bd4-4c86-b6e8-2309ccb75df8','true','access.token.claim'),('5d8d04c1-0bd4-4c86-b6e8-2309ccb75df8','clientHost','claim.name'),('5d8d04c1-0bd4-4c86-b6e8-2309ccb75df8','true','id.token.claim'),('5d8d04c1-0bd4-4c86-b6e8-2309ccb75df8','true','introspection.token.claim'),('5d8d04c1-0bd4-4c86-b6e8-2309ccb75df8','String','jsonType.label'),('5d8d04c1-0bd4-4c86-b6e8-2309ccb75df8','clientHost','user.session.note'),('6148be48-2985-4a94-a9fb-78599d3b8506','true','access.token.claim'),('6148be48-2985-4a94-a9fb-78599d3b8506','true','id.token.claim'),('6148be48-2985-4a94-a9fb-78599d3b8506','true','introspection.token.claim'),('75795b16-14fc-4f63-8871-7e7bd5766c58','Role','attribute.name'),('75795b16-14fc-4f63-8871-7e7bd5766c58','Basic','attribute.nameformat'),('75795b16-14fc-4f63-8871-7e7bd5766c58','false','single'),('7870e17e-f396-48ca-8659-660fc5acdc00','true','access.token.claim'),('7870e17e-f396-48ca-8659-660fc5acdc00','birthdate','claim.name'),('7870e17e-f396-48ca-8659-660fc5acdc00','true','id.token.claim'),('7870e17e-f396-48ca-8659-660fc5acdc00','true','introspection.token.claim'),('7870e17e-f396-48ca-8659-660fc5acdc00','String','jsonType.label'),('7870e17e-f396-48ca-8659-660fc5acdc00','birthdate','user.attribute'),('7870e17e-f396-48ca-8659-660fc5acdc00','true','userinfo.token.claim'),('78d46984-6951-476e-9040-f3ac110af4b0','true','access.token.claim'),('78d46984-6951-476e-9040-f3ac110af4b0','locale','claim.name'),('78d46984-6951-476e-9040-f3ac110af4b0','true','id.token.claim'),('78d46984-6951-476e-9040-f3ac110af4b0','true','introspection.token.claim'),('78d46984-6951-476e-9040-f3ac110af4b0','String','jsonType.label'),('78d46984-6951-476e-9040-f3ac110af4b0','locale','user.attribute'),('78d46984-6951-476e-9040-f3ac110af4b0','true','userinfo.token.claim'),('84745641-fc45-4a9a-bda8-e12530316f77','true','access.token.claim'),('84745641-fc45-4a9a-bda8-e12530316f77','upn','claim.name'),('84745641-fc45-4a9a-bda8-e12530316f77','true','id.token.claim'),('84745641-fc45-4a9a-bda8-e12530316f77','true','introspection.token.claim'),('84745641-fc45-4a9a-bda8-e12530316f77','String','jsonType.label'),('84745641-fc45-4a9a-bda8-e12530316f77','username','user.attribute'),('84745641-fc45-4a9a-bda8-e12530316f77','true','userinfo.token.claim'),('86583377-a02a-4464-a992-2f287063b15d','true','access.token.claim'),('86583377-a02a-4464-a992-2f287063b15d','phone_number_verified','claim.name'),('86583377-a02a-4464-a992-2f287063b15d','true','id.token.claim'),('86583377-a02a-4464-a992-2f287063b15d','true','introspection.token.claim'),('86583377-a02a-4464-a992-2f287063b15d','boolean','jsonType.label'),('86583377-a02a-4464-a992-2f287063b15d','phoneNumberVerified','user.attribute'),('86583377-a02a-4464-a992-2f287063b15d','true','userinfo.token.claim'),('9760481a-a78c-4f14-928e-8621e9682eba','true','access.token.claim'),('9760481a-a78c-4f14-928e-8621e9682eba','true','id.token.claim'),('9760481a-a78c-4f14-928e-8621e9682eba','true','introspection.token.claim'),('9760481a-a78c-4f14-928e-8621e9682eba','country','user.attribute.country'),('9760481a-a78c-4f14-928e-8621e9682eba','formatted','user.attribute.formatted'),('9760481a-a78c-4f14-928e-8621e9682eba','locality','user.attribute.locality'),('9760481a-a78c-4f14-928e-8621e9682eba','postal_code','user.attribute.postal_code'),('9760481a-a78c-4f14-928e-8621e9682eba','region','user.attribute.region'),('9760481a-a78c-4f14-928e-8621e9682eba','street','user.attribute.street'),('9760481a-a78c-4f14-928e-8621e9682eba','true','userinfo.token.claim'),('97b093b6-6102-4283-8957-7eb856286ada','true','access.token.claim'),('97b093b6-6102-4283-8957-7eb856286ada','locale','claim.name'),('97b093b6-6102-4283-8957-7eb856286ada','true','id.token.claim'),('97b093b6-6102-4283-8957-7eb856286ada','true','introspection.token.claim'),('97b093b6-6102-4283-8957-7eb856286ada','String','jsonType.label'),('97b093b6-6102-4283-8957-7eb856286ada','locale','user.attribute'),('97b093b6-6102-4283-8957-7eb856286ada','true','userinfo.token.claim'),('abf07b2e-98bd-40d8-9d4f-8756427bcea3','true','access.token.claim'),('abf07b2e-98bd-40d8-9d4f-8756427bcea3','email_verified','claim.name'),('abf07b2e-98bd-40d8-9d4f-8756427bcea3','true','id.token.claim'),('abf07b2e-98bd-40d8-9d4f-8756427bcea3','true','introspection.token.claim'),('abf07b2e-98bd-40d8-9d4f-8756427bcea3','boolean','jsonType.label'),('abf07b2e-98bd-40d8-9d4f-8756427bcea3','emailVerified','user.attribute'),('abf07b2e-98bd-40d8-9d4f-8756427bcea3','true','userinfo.token.claim'),('b06fd0c0-ee03-4a63-b77f-875633e48388','true','access.token.claim'),('b06fd0c0-ee03-4a63-b77f-875633e48388','resource_access.${client_id}.roles','claim.name'),('b06fd0c0-ee03-4a63-b77f-875633e48388','true','introspection.token.claim'),('b06fd0c0-ee03-4a63-b77f-875633e48388','String','jsonType.label'),('b06fd0c0-ee03-4a63-b77f-875633e48388','true','multivalued'),('b06fd0c0-ee03-4a63-b77f-875633e48388','foo','user.attribute'),('b47ecfe4-d3e0-479d-b77e-581c3ca3e14d','true','access.token.claim'),('b47ecfe4-d3e0-479d-b77e-581c3ca3e14d','website','claim.name'),('b47ecfe4-d3e0-479d-b77e-581c3ca3e14d','true','id.token.claim'),('b47ecfe4-d3e0-479d-b77e-581c3ca3e14d','true','introspection.token.claim'),('b47ecfe4-d3e0-479d-b77e-581c3ca3e14d','String','jsonType.label'),('b47ecfe4-d3e0-479d-b77e-581c3ca3e14d','website','user.attribute'),('b47ecfe4-d3e0-479d-b77e-581c3ca3e14d','true','userinfo.token.claim'),('b730fbf8-c135-46d3-b6aa-641e4dc27ca7','true','access.token.claim'),('b730fbf8-c135-46d3-b6aa-641e4dc27ca7','gender','claim.name'),('b730fbf8-c135-46d3-b6aa-641e4dc27ca7','true','id.token.claim'),('b730fbf8-c135-46d3-b6aa-641e4dc27ca7','true','introspection.token.claim'),('b730fbf8-c135-46d3-b6aa-641e4dc27ca7','String','jsonType.label'),('b730fbf8-c135-46d3-b6aa-641e4dc27ca7','gender','user.attribute'),('b730fbf8-c135-46d3-b6aa-641e4dc27ca7','true','userinfo.token.claim'),('c5fc8e2b-1177-449c-b526-bcd1b5f77850','true','access.token.claim'),('c5fc8e2b-1177-449c-b526-bcd1b5f77850','profile','claim.name'),('c5fc8e2b-1177-449c-b526-bcd1b5f77850','true','id.token.claim'),('c5fc8e2b-1177-449c-b526-bcd1b5f77850','true','introspection.token.claim'),('c5fc8e2b-1177-449c-b526-bcd1b5f77850','String','jsonType.label'),('c5fc8e2b-1177-449c-b526-bcd1b5f77850','profile','user.attribute'),('c5fc8e2b-1177-449c-b526-bcd1b5f77850','true','userinfo.token.claim'),('ca2c78f1-2254-4fa1-82fe-4c2ed08ac523','true','access.token.claim'),('ca2c78f1-2254-4fa1-82fe-4c2ed08ac523','true','introspection.token.claim'),('d4711ed9-8b3f-4894-9a72-553d79137df5','true','access.token.claim'),('d4711ed9-8b3f-4894-9a72-553d79137df5','given_name','claim.name'),('d4711ed9-8b3f-4894-9a72-553d79137df5','true','id.token.claim'),('d4711ed9-8b3f-4894-9a72-553d79137df5','true','introspection.token.claim'),('d4711ed9-8b3f-4894-9a72-553d79137df5','String','jsonType.label'),('d4711ed9-8b3f-4894-9a72-553d79137df5','firstName','user.attribute'),('d4711ed9-8b3f-4894-9a72-553d79137df5','true','userinfo.token.claim'),('de67ca21-6020-48c4-b18a-071baabc054e','true','access.token.claim'),('de67ca21-6020-48c4-b18a-071baabc054e','nickname','claim.name'),('de67ca21-6020-48c4-b18a-071baabc054e','true','id.token.claim'),('de67ca21-6020-48c4-b18a-071baabc054e','true','introspection.token.claim'),('de67ca21-6020-48c4-b18a-071baabc054e','String','jsonType.label'),('de67ca21-6020-48c4-b18a-071baabc054e','nickname','user.attribute'),('de67ca21-6020-48c4-b18a-071baabc054e','true','userinfo.token.claim'),('df666e1a-e261-4b4a-a44b-92ff46d10aa7','true','access.token.claim'),('df666e1a-e261-4b4a-a44b-92ff46d10aa7','picture','claim.name'),('df666e1a-e261-4b4a-a44b-92ff46d10aa7','true','id.token.claim'),('df666e1a-e261-4b4a-a44b-92ff46d10aa7','true','introspection.token.claim'),('df666e1a-e261-4b4a-a44b-92ff46d10aa7','String','jsonType.label'),('df666e1a-e261-4b4a-a44b-92ff46d10aa7','picture','user.attribute'),('df666e1a-e261-4b4a-a44b-92ff46d10aa7','true','userinfo.token.claim'),('eeb67f75-448d-4edc-a120-e9beb24b9785','true','access.token.claim'),('eeb67f75-448d-4edc-a120-e9beb24b9785','clientAddress','claim.name'),('eeb67f75-448d-4edc-a120-e9beb24b9785','true','id.token.claim'),('eeb67f75-448d-4edc-a120-e9beb24b9785','true','introspection.token.claim'),('eeb67f75-448d-4edc-a120-e9beb24b9785','String','jsonType.label'),('eeb67f75-448d-4edc-a120-e9beb24b9785','clientAddress','user.session.note'),('f75e1f9a-28ce-4070-bb76-7b8f58228002','true','access.token.claim'),('f75e1f9a-28ce-4070-bb76-7b8f58228002','client_id','claim.name'),('f75e1f9a-28ce-4070-bb76-7b8f58228002','true','id.token.claim'),('f75e1f9a-28ce-4070-bb76-7b8f58228002','true','introspection.token.claim'),('f75e1f9a-28ce-4070-bb76-7b8f58228002','String','jsonType.label'),('f75e1f9a-28ce-4070-bb76-7b8f58228002','client_id','user.session.note');
/*!40000 ALTER TABLE `PROTOCOL_MAPPER_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM`
--

DROP TABLE IF EXISTS `REALM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REALM` (
  `ID` varchar(36) NOT NULL,
  `ACCESS_CODE_LIFESPAN` int DEFAULT NULL,
  `USER_ACTION_LIFESPAN` int DEFAULT NULL,
  `ACCESS_TOKEN_LIFESPAN` int DEFAULT NULL,
  `ACCOUNT_THEME` varchar(255) DEFAULT NULL,
  `ADMIN_THEME` varchar(255) DEFAULT NULL,
  `EMAIL_THEME` varchar(255) DEFAULT NULL,
  `ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `EVENTS_ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `EVENTS_EXPIRATION` bigint DEFAULT NULL,
  `LOGIN_THEME` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `NOT_BEFORE` int DEFAULT NULL,
  `PASSWORD_POLICY` text,
  `REGISTRATION_ALLOWED` bit(1) NOT NULL DEFAULT b'0',
  `REMEMBER_ME` bit(1) NOT NULL DEFAULT b'0',
  `RESET_PASSWORD_ALLOWED` bit(1) NOT NULL DEFAULT b'0',
  `SOCIAL` bit(1) NOT NULL DEFAULT b'0',
  `SSL_REQUIRED` varchar(255) DEFAULT NULL,
  `SSO_IDLE_TIMEOUT` int DEFAULT NULL,
  `SSO_MAX_LIFESPAN` int DEFAULT NULL,
  `UPDATE_PROFILE_ON_SOC_LOGIN` bit(1) NOT NULL DEFAULT b'0',
  `VERIFY_EMAIL` bit(1) NOT NULL DEFAULT b'0',
  `MASTER_ADMIN_CLIENT` varchar(36) DEFAULT NULL,
  `LOGIN_LIFESPAN` int DEFAULT NULL,
  `INTERNATIONALIZATION_ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `DEFAULT_LOCALE` varchar(255) DEFAULT NULL,
  `REG_EMAIL_AS_USERNAME` bit(1) NOT NULL DEFAULT b'0',
  `ADMIN_EVENTS_ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `ADMIN_EVENTS_DETAILS_ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `EDIT_USERNAME_ALLOWED` bit(1) NOT NULL DEFAULT b'0',
  `OTP_POLICY_COUNTER` int DEFAULT '0',
  `OTP_POLICY_WINDOW` int DEFAULT '1',
  `OTP_POLICY_PERIOD` int DEFAULT '30',
  `OTP_POLICY_DIGITS` int DEFAULT '6',
  `OTP_POLICY_ALG` varchar(36) DEFAULT 'HmacSHA1',
  `OTP_POLICY_TYPE` varchar(36) DEFAULT 'totp',
  `BROWSER_FLOW` varchar(36) DEFAULT NULL,
  `REGISTRATION_FLOW` varchar(36) DEFAULT NULL,
  `DIRECT_GRANT_FLOW` varchar(36) DEFAULT NULL,
  `RESET_CREDENTIALS_FLOW` varchar(36) DEFAULT NULL,
  `CLIENT_AUTH_FLOW` varchar(36) DEFAULT NULL,
  `OFFLINE_SESSION_IDLE_TIMEOUT` int DEFAULT '0',
  `REVOKE_REFRESH_TOKEN` bit(1) NOT NULL DEFAULT b'0',
  `ACCESS_TOKEN_LIFE_IMPLICIT` int DEFAULT '0',
  `LOGIN_WITH_EMAIL_ALLOWED` bit(1) NOT NULL DEFAULT b'1',
  `DUPLICATE_EMAILS_ALLOWED` bit(1) NOT NULL DEFAULT b'0',
  `DOCKER_AUTH_FLOW` varchar(36) DEFAULT NULL,
  `REFRESH_TOKEN_MAX_REUSE` int DEFAULT '0',
  `ALLOW_USER_MANAGED_ACCESS` bit(1) NOT NULL DEFAULT b'0',
  `SSO_MAX_LIFESPAN_REMEMBER_ME` int NOT NULL,
  `SSO_IDLE_TIMEOUT_REMEMBER_ME` int NOT NULL,
  `DEFAULT_ROLE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_ORVSDMLA56612EAEFIQ6WL5OI` (`NAME`),
  KEY `IDX_REALM_MASTER_ADM_CLI` (`MASTER_ADMIN_CLIENT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM`
--

LOCK TABLES `REALM` WRITE;
/*!40000 ALTER TABLE `REALM` DISABLE KEYS */;
INSERT INTO `REALM` VALUES ('7f59a3db-3ce6-4735-8d4e-b391c4609bcb',60,300,60,NULL,NULL,NULL,_binary '',_binary '\0',0,NULL,'master',0,NULL,_binary '\0',_binary '\0',_binary '\0',_binary '\0','EXTERNAL',1800,36000,_binary '\0',_binary '\0','6a200eb6-3191-496c-8e4c-dbf67658fd2e',1800,_binary '\0',NULL,_binary '\0',_binary '\0',_binary '\0',_binary '\0',0,1,30,6,'HmacSHA1','totp','64f2e709-d32f-46e4-b1cf-d7e4b5fd670d','eefd9a0d-8ece-4c9b-9bba-164397f5bab0','5e1b6c13-7fc8-423a-91df-a9d33b8021a4','7f22d11d-1f1c-4687-9cc3-c44b1fb39002','858a2ecc-22ef-4d3d-9512-0858a1ca0286',2592000,_binary '\0',900,_binary '',_binary '\0','845fe7dc-15b8-4ba3-99c7-67f600622813',0,_binary '\0',0,0,'fbda23ea-5774-4c94-bea9-579347d92fc1');
/*!40000 ALTER TABLE `REALM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_ATTRIBUTE`
--

DROP TABLE IF EXISTS `REALM_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REALM_ATTRIBUTE` (
  `NAME` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `VALUE` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  PRIMARY KEY (`NAME`,`REALM_ID`),
  KEY `IDX_REALM_ATTR_REALM` (`REALM_ID`),
  CONSTRAINT `FK_8SHXD6L3E9ATQUKACXGPFFPTW` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_ATTRIBUTE`
--

LOCK TABLES `REALM_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `REALM_ATTRIBUTE` DISABLE KEYS */;
INSERT INTO `REALM_ATTRIBUTE` VALUES ('_browser_header.contentSecurityPolicy','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','frame-src \'self\'; frame-ancestors \'self\'; object-src \'none\';'),('_browser_header.contentSecurityPolicyReportOnly','7f59a3db-3ce6-4735-8d4e-b391c4609bcb',''),('_browser_header.referrerPolicy','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','no-referrer'),('_browser_header.strictTransportSecurity','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','max-age=31536000; includeSubDomains'),('_browser_header.xContentTypeOptions','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','nosniff'),('_browser_header.xFrameOptions','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','SAMEORIGIN'),('_browser_header.xRobotsTag','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','none'),('_browser_header.xXSSProtection','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','1; mode=block'),('bruteForceProtected','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','false'),('defaultSignatureAlgorithm','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','RS256'),('displayName','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','Keycloak'),('displayNameHtml','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','<div class=\"kc-logo-text\"><span>Keycloak</span></div>'),('failureFactor','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','30'),('maxDeltaTimeSeconds','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','43200'),('maxFailureWaitSeconds','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','900'),('minimumQuickLoginWaitSeconds','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','60'),('offlineSessionMaxLifespan','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','5184000'),('offlineSessionMaxLifespanEnabled','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','false'),('permanentLockout','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','false'),('quickLoginCheckMilliSeconds','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','1000'),('realmReusableOtpCode','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','false'),('waitIncrementSeconds','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','60');
/*!40000 ALTER TABLE `REALM_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_DEFAULT_GROUPS`
--

DROP TABLE IF EXISTS `REALM_DEFAULT_GROUPS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REALM_DEFAULT_GROUPS` (
  `REALM_ID` varchar(36) NOT NULL,
  `GROUP_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`REALM_ID`,`GROUP_ID`),
  UNIQUE KEY `CON_GROUP_ID_DEF_GROUPS` (`GROUP_ID`),
  KEY `IDX_REALM_DEF_GRP_REALM` (`REALM_ID`),
  CONSTRAINT `FK_DEF_GROUPS_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_DEFAULT_GROUPS`
--

LOCK TABLES `REALM_DEFAULT_GROUPS` WRITE;
/*!40000 ALTER TABLE `REALM_DEFAULT_GROUPS` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALM_DEFAULT_GROUPS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_ENABLED_EVENT_TYPES`
--

DROP TABLE IF EXISTS `REALM_ENABLED_EVENT_TYPES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REALM_ENABLED_EVENT_TYPES` (
  `REALM_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`REALM_ID`,`VALUE`),
  KEY `IDX_REALM_EVT_TYPES_REALM` (`REALM_ID`),
  CONSTRAINT `FK_H846O4H0W8EPX5NWEDRF5Y69J` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_ENABLED_EVENT_TYPES`
--

LOCK TABLES `REALM_ENABLED_EVENT_TYPES` WRITE;
/*!40000 ALTER TABLE `REALM_ENABLED_EVENT_TYPES` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALM_ENABLED_EVENT_TYPES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_EVENTS_LISTENERS`
--

DROP TABLE IF EXISTS `REALM_EVENTS_LISTENERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REALM_EVENTS_LISTENERS` (
  `REALM_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`REALM_ID`,`VALUE`),
  KEY `IDX_REALM_EVT_LIST_REALM` (`REALM_ID`),
  CONSTRAINT `FK_H846O4H0W8EPX5NXEV9F5Y69J` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_EVENTS_LISTENERS`
--

LOCK TABLES `REALM_EVENTS_LISTENERS` WRITE;
/*!40000 ALTER TABLE `REALM_EVENTS_LISTENERS` DISABLE KEYS */;
INSERT INTO `REALM_EVENTS_LISTENERS` VALUES ('7f59a3db-3ce6-4735-8d4e-b391c4609bcb','jboss-logging');
/*!40000 ALTER TABLE `REALM_EVENTS_LISTENERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_LOCALIZATIONS`
--

DROP TABLE IF EXISTS `REALM_LOCALIZATIONS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REALM_LOCALIZATIONS` (
  `REALM_ID` varchar(255) NOT NULL,
  `LOCALE` varchar(255) NOT NULL,
  `TEXTS` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`REALM_ID`,`LOCALE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_LOCALIZATIONS`
--

LOCK TABLES `REALM_LOCALIZATIONS` WRITE;
/*!40000 ALTER TABLE `REALM_LOCALIZATIONS` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALM_LOCALIZATIONS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_REQUIRED_CREDENTIAL`
--

DROP TABLE IF EXISTS `REALM_REQUIRED_CREDENTIAL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REALM_REQUIRED_CREDENTIAL` (
  `TYPE` varchar(255) NOT NULL,
  `FORM_LABEL` varchar(255) DEFAULT NULL,
  `INPUT` bit(1) NOT NULL DEFAULT b'0',
  `SECRET` bit(1) NOT NULL DEFAULT b'0',
  `REALM_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`REALM_ID`,`TYPE`),
  CONSTRAINT `FK_5HG65LYBEVAVKQFKI3KPONH9V` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_REQUIRED_CREDENTIAL`
--

LOCK TABLES `REALM_REQUIRED_CREDENTIAL` WRITE;
/*!40000 ALTER TABLE `REALM_REQUIRED_CREDENTIAL` DISABLE KEYS */;
INSERT INTO `REALM_REQUIRED_CREDENTIAL` VALUES ('password','password',_binary '',_binary '','7f59a3db-3ce6-4735-8d4e-b391c4609bcb');
/*!40000 ALTER TABLE `REALM_REQUIRED_CREDENTIAL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_SMTP_CONFIG`
--

DROP TABLE IF EXISTS `REALM_SMTP_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REALM_SMTP_CONFIG` (
  `REALM_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`REALM_ID`,`NAME`),
  CONSTRAINT `FK_70EJ8XDXGXD0B9HH6180IRR0O` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_SMTP_CONFIG`
--

LOCK TABLES `REALM_SMTP_CONFIG` WRITE;
/*!40000 ALTER TABLE `REALM_SMTP_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALM_SMTP_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_SUPPORTED_LOCALES`
--

DROP TABLE IF EXISTS `REALM_SUPPORTED_LOCALES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REALM_SUPPORTED_LOCALES` (
  `REALM_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`REALM_ID`,`VALUE`),
  KEY `IDX_REALM_SUPP_LOCAL_REALM` (`REALM_ID`),
  CONSTRAINT `FK_SUPPORTED_LOCALES_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_SUPPORTED_LOCALES`
--

LOCK TABLES `REALM_SUPPORTED_LOCALES` WRITE;
/*!40000 ALTER TABLE `REALM_SUPPORTED_LOCALES` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALM_SUPPORTED_LOCALES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REDIRECT_URIS`
--

DROP TABLE IF EXISTS `REDIRECT_URIS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REDIRECT_URIS` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`CLIENT_ID`,`VALUE`),
  KEY `IDX_REDIR_URI_CLIENT` (`CLIENT_ID`),
  CONSTRAINT `FK_1BURS8PB4OUJ97H5WUPPAHV9F` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REDIRECT_URIS`
--

LOCK TABLES `REDIRECT_URIS` WRITE;
/*!40000 ALTER TABLE `REDIRECT_URIS` DISABLE KEYS */;
INSERT INTO `REDIRECT_URIS` VALUES ('3cae072d-233a-4922-b913-1966d129113a','/realms/master/account/*'),('77bec48a-5470-45a3-bfd6-8fe16883bbf4','/realms/master/account/*'),('a1724120-09b9-4727-b44b-69735af49212','http://localhost:8080/*'),('a1724120-09b9-4727-b44b-69735af49212','http://localhost/*'),('ef4d1c45-b293-4ce2-b700-2ef194731ba1','/admin/master/console/*');
/*!40000 ALTER TABLE `REDIRECT_URIS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REQUIRED_ACTION_CONFIG`
--

DROP TABLE IF EXISTS `REQUIRED_ACTION_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REQUIRED_ACTION_CONFIG` (
  `REQUIRED_ACTION_ID` varchar(36) NOT NULL,
  `VALUE` longtext,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`REQUIRED_ACTION_ID`,`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REQUIRED_ACTION_CONFIG`
--

LOCK TABLES `REQUIRED_ACTION_CONFIG` WRITE;
/*!40000 ALTER TABLE `REQUIRED_ACTION_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `REQUIRED_ACTION_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REQUIRED_ACTION_PROVIDER`
--

DROP TABLE IF EXISTS `REQUIRED_ACTION_PROVIDER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REQUIRED_ACTION_PROVIDER` (
  `ID` varchar(36) NOT NULL,
  `ALIAS` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `DEFAULT_ACTION` bit(1) NOT NULL DEFAULT b'0',
  `PROVIDER_ID` varchar(255) DEFAULT NULL,
  `PRIORITY` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_REQ_ACT_PROV_REALM` (`REALM_ID`),
  CONSTRAINT `FK_REQ_ACT_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REQUIRED_ACTION_PROVIDER`
--

LOCK TABLES `REQUIRED_ACTION_PROVIDER` WRITE;
/*!40000 ALTER TABLE `REQUIRED_ACTION_PROVIDER` DISABLE KEYS */;
INSERT INTO `REQUIRED_ACTION_PROVIDER` VALUES ('032c6ca9-4f93-4010-9572-f2a1d4d508f9','UPDATE_PASSWORD','Update Password','7f59a3db-3ce6-4735-8d4e-b391c4609bcb',_binary '',_binary '\0','UPDATE_PASSWORD',30),('0e0d6147-f33b-4e92-b9be-87997396df47','webauthn-register','Webauthn Register','7f59a3db-3ce6-4735-8d4e-b391c4609bcb',_binary '',_binary '\0','webauthn-register',70),('363c13c2-6e25-485a-b572-717d71d1909d','CONFIGURE_TOTP','Configure OTP','7f59a3db-3ce6-4735-8d4e-b391c4609bcb',_binary '',_binary '\0','CONFIGURE_TOTP',10),('58b39016-a369-4717-854a-0f160c584c47','TERMS_AND_CONDITIONS','Terms and Conditions','7f59a3db-3ce6-4735-8d4e-b391c4609bcb',_binary '\0',_binary '\0','TERMS_AND_CONDITIONS',20),('58c06cd5-a254-4ea7-a49f-d2d05a0d189c','UPDATE_PROFILE','Update Profile','7f59a3db-3ce6-4735-8d4e-b391c4609bcb',_binary '',_binary '\0','UPDATE_PROFILE',40),('67a34bc1-f26a-4f51-a251-d661d439bf27','update_user_locale','Update User Locale','7f59a3db-3ce6-4735-8d4e-b391c4609bcb',_binary '',_binary '\0','update_user_locale',1000),('9e4263b9-7c99-4096-984a-63e61a59ed7d','delete_account','Delete Account','7f59a3db-3ce6-4735-8d4e-b391c4609bcb',_binary '\0',_binary '\0','delete_account',60),('b568041e-4d9e-4957-95a1-783ee6b27512','VERIFY_EMAIL','Verify Email','7f59a3db-3ce6-4735-8d4e-b391c4609bcb',_binary '',_binary '\0','VERIFY_EMAIL',50),('f6bb5222-0b52-45c2-ab61-11e0a44f3c61','webauthn-register-passwordless','Webauthn Register Passwordless','7f59a3db-3ce6-4735-8d4e-b391c4609bcb',_binary '',_binary '\0','webauthn-register-passwordless',80);
/*!40000 ALTER TABLE `REQUIRED_ACTION_PROVIDER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_ATTRIBUTE`
--

DROP TABLE IF EXISTS `RESOURCE_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RESOURCE_ATTRIBUTE` (
  `ID` varchar(36) NOT NULL DEFAULT 'sybase-needs-something-here',
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  `RESOURCE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_5HRM2VLF9QL5FU022KQEPOVBR` (`RESOURCE_ID`),
  CONSTRAINT `FK_5HRM2VLF9QL5FU022KQEPOVBR` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `RESOURCE_SERVER_RESOURCE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_ATTRIBUTE`
--

LOCK TABLES `RESOURCE_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `RESOURCE_ATTRIBUTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_POLICY`
--

DROP TABLE IF EXISTS `RESOURCE_POLICY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RESOURCE_POLICY` (
  `RESOURCE_ID` varchar(36) NOT NULL,
  `POLICY_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`RESOURCE_ID`,`POLICY_ID`),
  KEY `IDX_RES_POLICY_POLICY` (`POLICY_ID`),
  CONSTRAINT `FK_FRSRPOS53XCX4WNKOG82SSRFY` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `RESOURCE_SERVER_RESOURCE` (`ID`),
  CONSTRAINT `FK_FRSRPP213XCX4WNKOG82SSRFY` FOREIGN KEY (`POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_POLICY`
--

LOCK TABLES `RESOURCE_POLICY` WRITE;
/*!40000 ALTER TABLE `RESOURCE_POLICY` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_POLICY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_SCOPE`
--

DROP TABLE IF EXISTS `RESOURCE_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RESOURCE_SCOPE` (
  `RESOURCE_ID` varchar(36) NOT NULL,
  `SCOPE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`RESOURCE_ID`,`SCOPE_ID`),
  KEY `IDX_RES_SCOPE_SCOPE` (`SCOPE_ID`),
  CONSTRAINT `FK_FRSRPOS13XCX4WNKOG82SSRFY` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `RESOURCE_SERVER_RESOURCE` (`ID`),
  CONSTRAINT `FK_FRSRPS213XCX4WNKOG82SSRFY` FOREIGN KEY (`SCOPE_ID`) REFERENCES `RESOURCE_SERVER_SCOPE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_SCOPE`
--

LOCK TABLES `RESOURCE_SCOPE` WRITE;
/*!40000 ALTER TABLE `RESOURCE_SCOPE` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_SCOPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_SERVER`
--

DROP TABLE IF EXISTS `RESOURCE_SERVER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RESOURCE_SERVER` (
  `ID` varchar(36) NOT NULL,
  `ALLOW_RS_REMOTE_MGMT` bit(1) NOT NULL DEFAULT b'0',
  `POLICY_ENFORCE_MODE` tinyint DEFAULT NULL,
  `DECISION_STRATEGY` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_SERVER`
--

LOCK TABLES `RESOURCE_SERVER` WRITE;
/*!40000 ALTER TABLE `RESOURCE_SERVER` DISABLE KEYS */;
INSERT INTO `RESOURCE_SERVER` VALUES ('a1724120-09b9-4727-b44b-69735af49212',_binary '',0,1);
/*!40000 ALTER TABLE `RESOURCE_SERVER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_SERVER_PERM_TICKET`
--

DROP TABLE IF EXISTS `RESOURCE_SERVER_PERM_TICKET`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RESOURCE_SERVER_PERM_TICKET` (
  `ID` varchar(36) NOT NULL,
  `OWNER` varchar(255) DEFAULT NULL,
  `REQUESTER` varchar(255) DEFAULT NULL,
  `CREATED_TIMESTAMP` bigint NOT NULL,
  `GRANTED_TIMESTAMP` bigint DEFAULT NULL,
  `RESOURCE_ID` varchar(36) NOT NULL,
  `SCOPE_ID` varchar(36) DEFAULT NULL,
  `RESOURCE_SERVER_ID` varchar(36) NOT NULL,
  `POLICY_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_FRSR6T700S9V50BU18WS5PMT` (`OWNER`,`REQUESTER`,`RESOURCE_SERVER_ID`,`RESOURCE_ID`,`SCOPE_ID`),
  KEY `FK_FRSRHO213XCX4WNKOG82SSPMT` (`RESOURCE_SERVER_ID`),
  KEY `FK_FRSRHO213XCX4WNKOG83SSPMT` (`RESOURCE_ID`),
  KEY `FK_FRSRHO213XCX4WNKOG84SSPMT` (`SCOPE_ID`),
  KEY `FK_FRSRPO2128CX4WNKOG82SSRFY` (`POLICY_ID`),
  CONSTRAINT `FK_FRSRHO213XCX4WNKOG82SSPMT` FOREIGN KEY (`RESOURCE_SERVER_ID`) REFERENCES `RESOURCE_SERVER` (`ID`),
  CONSTRAINT `FK_FRSRHO213XCX4WNKOG83SSPMT` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `RESOURCE_SERVER_RESOURCE` (`ID`),
  CONSTRAINT `FK_FRSRHO213XCX4WNKOG84SSPMT` FOREIGN KEY (`SCOPE_ID`) REFERENCES `RESOURCE_SERVER_SCOPE` (`ID`),
  CONSTRAINT `FK_FRSRPO2128CX4WNKOG82SSRFY` FOREIGN KEY (`POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_SERVER_PERM_TICKET`
--

LOCK TABLES `RESOURCE_SERVER_PERM_TICKET` WRITE;
/*!40000 ALTER TABLE `RESOURCE_SERVER_PERM_TICKET` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_SERVER_PERM_TICKET` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_SERVER_POLICY`
--

DROP TABLE IF EXISTS `RESOURCE_SERVER_POLICY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RESOURCE_SERVER_POLICY` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `TYPE` varchar(255) NOT NULL,
  `DECISION_STRATEGY` tinyint DEFAULT NULL,
  `LOGIC` tinyint DEFAULT NULL,
  `RESOURCE_SERVER_ID` varchar(36) DEFAULT NULL,
  `OWNER` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_FRSRPT700S9V50BU18WS5HA6` (`NAME`,`RESOURCE_SERVER_ID`),
  KEY `IDX_RES_SERV_POL_RES_SERV` (`RESOURCE_SERVER_ID`),
  CONSTRAINT `FK_FRSRPO213XCX4WNKOG82SSRFY` FOREIGN KEY (`RESOURCE_SERVER_ID`) REFERENCES `RESOURCE_SERVER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_SERVER_POLICY`
--

LOCK TABLES `RESOURCE_SERVER_POLICY` WRITE;
/*!40000 ALTER TABLE `RESOURCE_SERVER_POLICY` DISABLE KEYS */;
INSERT INTO `RESOURCE_SERVER_POLICY` VALUES ('75e10802-5f6d-4802-8020-5a494dc10f2b','Default Permission','A permission that applies to the default resource type','resource',1,0,'a1724120-09b9-4727-b44b-69735af49212',NULL),('7654d293-2101-4fda-ab02-5ecffc35434e','Default Policy','A policy that grants access only for users within this realm','js',0,0,'a1724120-09b9-4727-b44b-69735af49212',NULL);
/*!40000 ALTER TABLE `RESOURCE_SERVER_POLICY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_SERVER_RESOURCE`
--

DROP TABLE IF EXISTS `RESOURCE_SERVER_RESOURCE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RESOURCE_SERVER_RESOURCE` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `TYPE` varchar(255) DEFAULT NULL,
  `ICON_URI` varchar(255) DEFAULT NULL,
  `OWNER` varchar(255) DEFAULT NULL,
  `RESOURCE_SERVER_ID` varchar(36) DEFAULT NULL,
  `OWNER_MANAGED_ACCESS` bit(1) NOT NULL DEFAULT b'0',
  `DISPLAY_NAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_FRSR6T700S9V50BU18WS5HA6` (`NAME`,`OWNER`,`RESOURCE_SERVER_ID`),
  KEY `IDX_RES_SRV_RES_RES_SRV` (`RESOURCE_SERVER_ID`),
  CONSTRAINT `FK_FRSRHO213XCX4WNKOG82SSRFY` FOREIGN KEY (`RESOURCE_SERVER_ID`) REFERENCES `RESOURCE_SERVER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_SERVER_RESOURCE`
--

LOCK TABLES `RESOURCE_SERVER_RESOURCE` WRITE;
/*!40000 ALTER TABLE `RESOURCE_SERVER_RESOURCE` DISABLE KEYS */;
INSERT INTO `RESOURCE_SERVER_RESOURCE` VALUES ('ddbbc43f-74cf-4c7c-8fb7-8bca50da2469','Default Resource','urn:home-portal:resources:default',NULL,'a1724120-09b9-4727-b44b-69735af49212','a1724120-09b9-4727-b44b-69735af49212',_binary '\0',NULL);
/*!40000 ALTER TABLE `RESOURCE_SERVER_RESOURCE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_SERVER_SCOPE`
--

DROP TABLE IF EXISTS `RESOURCE_SERVER_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RESOURCE_SERVER_SCOPE` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `ICON_URI` varchar(255) DEFAULT NULL,
  `RESOURCE_SERVER_ID` varchar(36) DEFAULT NULL,
  `DISPLAY_NAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_FRSRST700S9V50BU18WS5HA6` (`NAME`,`RESOURCE_SERVER_ID`),
  KEY `IDX_RES_SRV_SCOPE_RES_SRV` (`RESOURCE_SERVER_ID`),
  CONSTRAINT `FK_FRSRSO213XCX4WNKOG82SSRFY` FOREIGN KEY (`RESOURCE_SERVER_ID`) REFERENCES `RESOURCE_SERVER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_SERVER_SCOPE`
--

LOCK TABLES `RESOURCE_SERVER_SCOPE` WRITE;
/*!40000 ALTER TABLE `RESOURCE_SERVER_SCOPE` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_SERVER_SCOPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_URIS`
--

DROP TABLE IF EXISTS `RESOURCE_URIS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RESOURCE_URIS` (
  `RESOURCE_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`RESOURCE_ID`,`VALUE`),
  CONSTRAINT `FK_RESOURCE_SERVER_URIS` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `RESOURCE_SERVER_RESOURCE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_URIS`
--

LOCK TABLES `RESOURCE_URIS` WRITE;
/*!40000 ALTER TABLE `RESOURCE_URIS` DISABLE KEYS */;
INSERT INTO `RESOURCE_URIS` VALUES ('ddbbc43f-74cf-4c7c-8fb7-8bca50da2469','/*');
/*!40000 ALTER TABLE `RESOURCE_URIS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ROLE_ATTRIBUTE`
--

DROP TABLE IF EXISTS `ROLE_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ROLE_ATTRIBUTE` (
  `ID` varchar(36) NOT NULL,
  `ROLE_ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_ROLE_ATTRIBUTE` (`ROLE_ID`),
  CONSTRAINT `FK_ROLE_ATTRIBUTE_ID` FOREIGN KEY (`ROLE_ID`) REFERENCES `KEYCLOAK_ROLE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ROLE_ATTRIBUTE`
--

LOCK TABLES `ROLE_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `ROLE_ATTRIBUTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `ROLE_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SCOPE_MAPPING`
--

DROP TABLE IF EXISTS `SCOPE_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SCOPE_MAPPING` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `ROLE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`CLIENT_ID`,`ROLE_ID`),
  KEY `IDX_SCOPE_MAPPING_ROLE` (`ROLE_ID`),
  CONSTRAINT `FK_OUSE064PLMLR732LXJCN1Q5F1` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SCOPE_MAPPING`
--

LOCK TABLES `SCOPE_MAPPING` WRITE;
/*!40000 ALTER TABLE `SCOPE_MAPPING` DISABLE KEYS */;
INSERT INTO `SCOPE_MAPPING` VALUES ('77bec48a-5470-45a3-bfd6-8fe16883bbf4','13739d66-87b6-40e0-bb7d-e3299c21638d'),('77bec48a-5470-45a3-bfd6-8fe16883bbf4','5709bcbf-1636-4872-9235-e5fea0fd77d3');
/*!40000 ALTER TABLE `SCOPE_MAPPING` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SCOPE_POLICY`
--

DROP TABLE IF EXISTS `SCOPE_POLICY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SCOPE_POLICY` (
  `SCOPE_ID` varchar(36) NOT NULL,
  `POLICY_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`SCOPE_ID`,`POLICY_ID`),
  KEY `IDX_SCOPE_POLICY_POLICY` (`POLICY_ID`),
  CONSTRAINT `FK_FRSRASP13XCX4WNKOG82SSRFY` FOREIGN KEY (`POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`),
  CONSTRAINT `FK_FRSRPASS3XCX4WNKOG82SSRFY` FOREIGN KEY (`SCOPE_ID`) REFERENCES `RESOURCE_SERVER_SCOPE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SCOPE_POLICY`
--

LOCK TABLES `SCOPE_POLICY` WRITE;
/*!40000 ALTER TABLE `SCOPE_POLICY` DISABLE KEYS */;
/*!40000 ALTER TABLE `SCOPE_POLICY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USERNAME_LOGIN_FAILURE`
--

DROP TABLE IF EXISTS `USERNAME_LOGIN_FAILURE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USERNAME_LOGIN_FAILURE` (
  `REALM_ID` varchar(36) NOT NULL,
  `USERNAME` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FAILED_LOGIN_NOT_BEFORE` int DEFAULT NULL,
  `LAST_FAILURE` bigint DEFAULT NULL,
  `LAST_IP_FAILURE` varchar(255) DEFAULT NULL,
  `NUM_FAILURES` int DEFAULT NULL,
  PRIMARY KEY (`REALM_ID`,`USERNAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USERNAME_LOGIN_FAILURE`
--

LOCK TABLES `USERNAME_LOGIN_FAILURE` WRITE;
/*!40000 ALTER TABLE `USERNAME_LOGIN_FAILURE` DISABLE KEYS */;
/*!40000 ALTER TABLE `USERNAME_LOGIN_FAILURE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_ATTRIBUTE`
--

DROP TABLE IF EXISTS `USER_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_ATTRIBUTE` (
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `USER_ID` varchar(36) NOT NULL,
  `ID` varchar(36) NOT NULL DEFAULT 'sybase-needs-something-here',
  PRIMARY KEY (`ID`),
  KEY `IDX_USER_ATTRIBUTE` (`USER_ID`),
  KEY `IDX_USER_ATTRIBUTE_NAME` (`NAME`,`VALUE`),
  CONSTRAINT `FK_5HRM2VLF9QL5FU043KQEPOVBR` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_ATTRIBUTE`
--

LOCK TABLES `USER_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `USER_ATTRIBUTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_CONSENT`
--

DROP TABLE IF EXISTS `USER_CONSENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_CONSENT` (
  `ID` varchar(36) NOT NULL,
  `CLIENT_ID` varchar(255) DEFAULT NULL,
  `USER_ID` varchar(36) NOT NULL,
  `CREATED_DATE` bigint DEFAULT NULL,
  `LAST_UPDATED_DATE` bigint DEFAULT NULL,
  `CLIENT_STORAGE_PROVIDER` varchar(36) DEFAULT NULL,
  `EXTERNAL_CLIENT_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_JKUWUVD56ONTGSUHOGM8UEWRT` (`CLIENT_ID`,`CLIENT_STORAGE_PROVIDER`,`EXTERNAL_CLIENT_ID`,`USER_ID`),
  KEY `IDX_USER_CONSENT` (`USER_ID`),
  CONSTRAINT `FK_GRNTCSNT_USER` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_CONSENT`
--

LOCK TABLES `USER_CONSENT` WRITE;
/*!40000 ALTER TABLE `USER_CONSENT` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_CONSENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_CONSENT_CLIENT_SCOPE`
--

DROP TABLE IF EXISTS `USER_CONSENT_CLIENT_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_CONSENT_CLIENT_SCOPE` (
  `USER_CONSENT_ID` varchar(36) NOT NULL,
  `SCOPE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`USER_CONSENT_ID`,`SCOPE_ID`),
  KEY `IDX_USCONSENT_CLSCOPE` (`USER_CONSENT_ID`),
  CONSTRAINT `FK_GRNTCSNT_CLSC_USC` FOREIGN KEY (`USER_CONSENT_ID`) REFERENCES `USER_CONSENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_CONSENT_CLIENT_SCOPE`
--

LOCK TABLES `USER_CONSENT_CLIENT_SCOPE` WRITE;
/*!40000 ALTER TABLE `USER_CONSENT_CLIENT_SCOPE` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_CONSENT_CLIENT_SCOPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_ENTITY`
--

DROP TABLE IF EXISTS `USER_ENTITY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_ENTITY` (
  `ID` varchar(36) NOT NULL,
  `EMAIL` varchar(255) DEFAULT NULL,
  `EMAIL_CONSTRAINT` varchar(255) DEFAULT NULL,
  `EMAIL_VERIFIED` bit(1) NOT NULL DEFAULT b'0',
  `ENABLED` bit(1) NOT NULL DEFAULT b'0',
  `FEDERATION_LINK` varchar(255) DEFAULT NULL,
  `FIRST_NAME` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `LAST_NAME` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `USERNAME` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `CREATED_TIMESTAMP` bigint DEFAULT NULL,
  `SERVICE_ACCOUNT_CLIENT_LINK` varchar(255) DEFAULT NULL,
  `NOT_BEFORE` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_DYKN684SL8UP1CRFEI6ECKHD7` (`REALM_ID`,`EMAIL_CONSTRAINT`),
  UNIQUE KEY `UK_RU8TT6T700S9V50BU18WS5HA6` (`REALM_ID`,`USERNAME`),
  KEY `IDX_USER_EMAIL` (`EMAIL`),
  KEY `IDX_USER_SERVICE_ACCOUNT` (`REALM_ID`,`SERVICE_ACCOUNT_CLIENT_LINK`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_ENTITY`
--

LOCK TABLES `USER_ENTITY` WRITE;
/*!40000 ALTER TABLE `USER_ENTITY` DISABLE KEYS */;
INSERT INTO `USER_ENTITY` VALUES ('007a6cb2-6ab9-4e04-898f-b246505ffc22',NULL,'f1739be4-7da4-4c1f-9e59-a5ca5788d51c',_binary '\0',_binary '',NULL,NULL,NULL,'7f59a3db-3ce6-4735-8d4e-b391c4609bcb','service-account-iv-mvn',1704052615199,'a1724120-09b9-4727-b44b-69735af49212',0),('0c07de36-aa9a-4caa-bf55-27be1c3f5a22','admin@domain.com','admin@domain.com',_binary '',_binary '',NULL,'admin','admin','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','admin',1704052282308,NULL,0),('6c004b19-e5eb-4874-8b29-27737c8c9ccf','user@domain.com','user@domain.com',_binary '',_binary '',NULL,'user','user','7f59a3db-3ce6-4735-8d4e-b391c4609bcb','user',1704052366596,NULL,0);
/*!40000 ALTER TABLE `USER_ENTITY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_FEDERATION_CONFIG`
--

DROP TABLE IF EXISTS `USER_FEDERATION_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_FEDERATION_CONFIG` (
  `USER_FEDERATION_PROVIDER_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`USER_FEDERATION_PROVIDER_ID`,`NAME`),
  CONSTRAINT `FK_T13HPU1J94R2EBPEKR39X5EU5` FOREIGN KEY (`USER_FEDERATION_PROVIDER_ID`) REFERENCES `USER_FEDERATION_PROVIDER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_FEDERATION_CONFIG`
--

LOCK TABLES `USER_FEDERATION_CONFIG` WRITE;
/*!40000 ALTER TABLE `USER_FEDERATION_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_FEDERATION_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_FEDERATION_MAPPER`
--

DROP TABLE IF EXISTS `USER_FEDERATION_MAPPER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_FEDERATION_MAPPER` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `FEDERATION_PROVIDER_ID` varchar(36) NOT NULL,
  `FEDERATION_MAPPER_TYPE` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_USR_FED_MAP_FED_PRV` (`FEDERATION_PROVIDER_ID`),
  KEY `IDX_USR_FED_MAP_REALM` (`REALM_ID`),
  CONSTRAINT `FK_FEDMAPPERPM_FEDPRV` FOREIGN KEY (`FEDERATION_PROVIDER_ID`) REFERENCES `USER_FEDERATION_PROVIDER` (`ID`),
  CONSTRAINT `FK_FEDMAPPERPM_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_FEDERATION_MAPPER`
--

LOCK TABLES `USER_FEDERATION_MAPPER` WRITE;
/*!40000 ALTER TABLE `USER_FEDERATION_MAPPER` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_FEDERATION_MAPPER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_FEDERATION_MAPPER_CONFIG`
--

DROP TABLE IF EXISTS `USER_FEDERATION_MAPPER_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_FEDERATION_MAPPER_CONFIG` (
  `USER_FEDERATION_MAPPER_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`USER_FEDERATION_MAPPER_ID`,`NAME`),
  CONSTRAINT `FK_FEDMAPPER_CFG` FOREIGN KEY (`USER_FEDERATION_MAPPER_ID`) REFERENCES `USER_FEDERATION_MAPPER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_FEDERATION_MAPPER_CONFIG`
--

LOCK TABLES `USER_FEDERATION_MAPPER_CONFIG` WRITE;
/*!40000 ALTER TABLE `USER_FEDERATION_MAPPER_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_FEDERATION_MAPPER_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_FEDERATION_PROVIDER`
--

DROP TABLE IF EXISTS `USER_FEDERATION_PROVIDER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_FEDERATION_PROVIDER` (
  `ID` varchar(36) NOT NULL,
  `CHANGED_SYNC_PERIOD` int DEFAULT NULL,
  `DISPLAY_NAME` varchar(255) DEFAULT NULL,
  `FULL_SYNC_PERIOD` int DEFAULT NULL,
  `LAST_SYNC` int DEFAULT NULL,
  `PRIORITY` int DEFAULT NULL,
  `PROVIDER_NAME` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_USR_FED_PRV_REALM` (`REALM_ID`),
  CONSTRAINT `FK_1FJ32F6PTOLW2QY60CD8N01E8` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_FEDERATION_PROVIDER`
--

LOCK TABLES `USER_FEDERATION_PROVIDER` WRITE;
/*!40000 ALTER TABLE `USER_FEDERATION_PROVIDER` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_FEDERATION_PROVIDER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_GROUP_MEMBERSHIP`
--

DROP TABLE IF EXISTS `USER_GROUP_MEMBERSHIP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_GROUP_MEMBERSHIP` (
  `GROUP_ID` varchar(36) NOT NULL,
  `USER_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`GROUP_ID`,`USER_ID`),
  KEY `IDX_USER_GROUP_MAPPING` (`USER_ID`),
  CONSTRAINT `FK_USER_GROUP_USER` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_GROUP_MEMBERSHIP`
--

LOCK TABLES `USER_GROUP_MEMBERSHIP` WRITE;
/*!40000 ALTER TABLE `USER_GROUP_MEMBERSHIP` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_GROUP_MEMBERSHIP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_REQUIRED_ACTION`
--

DROP TABLE IF EXISTS `USER_REQUIRED_ACTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_REQUIRED_ACTION` (
  `USER_ID` varchar(36) NOT NULL,
  `REQUIRED_ACTION` varchar(255) NOT NULL DEFAULT ' ',
  PRIMARY KEY (`REQUIRED_ACTION`,`USER_ID`),
  KEY `IDX_USER_REQACTIONS` (`USER_ID`),
  CONSTRAINT `FK_6QJ3W1JW9CVAFHE19BWSIUVMD` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_REQUIRED_ACTION`
--

LOCK TABLES `USER_REQUIRED_ACTION` WRITE;
/*!40000 ALTER TABLE `USER_REQUIRED_ACTION` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_REQUIRED_ACTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_ROLE_MAPPING`
--

DROP TABLE IF EXISTS `USER_ROLE_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_ROLE_MAPPING` (
  `ROLE_ID` varchar(255) NOT NULL,
  `USER_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ROLE_ID`,`USER_ID`),
  KEY `IDX_USER_ROLE_MAPPING` (`USER_ID`),
  CONSTRAINT `FK_C4FQV34P1MBYLLOXANG7B1Q3L` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_ROLE_MAPPING`
--

LOCK TABLES `USER_ROLE_MAPPING` WRITE;
/*!40000 ALTER TABLE `USER_ROLE_MAPPING` DISABLE KEYS */;
INSERT INTO `USER_ROLE_MAPPING` VALUES ('ed3d10cc-09a0-4b7f-a623-d64128d97d9e','007a6cb2-6ab9-4e04-898f-b246505ffc22'),('fbda23ea-5774-4c94-bea9-579347d92fc1','007a6cb2-6ab9-4e04-898f-b246505ffc22'),('dc84eb3b-359f-45bc-aaee-73d11486e02c','0c07de36-aa9a-4caa-bf55-27be1c3f5a22'),('fbda23ea-5774-4c94-bea9-579347d92fc1','0c07de36-aa9a-4caa-bf55-27be1c3f5a22'),('fbda23ea-5774-4c94-bea9-579347d92fc1','6c004b19-e5eb-4874-8b29-27737c8c9ccf');
/*!40000 ALTER TABLE `USER_ROLE_MAPPING` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_SESSION`
--

DROP TABLE IF EXISTS `USER_SESSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_SESSION` (
  `ID` varchar(36) NOT NULL,
  `AUTH_METHOD` varchar(255) DEFAULT NULL,
  `IP_ADDRESS` varchar(255) DEFAULT NULL,
  `LAST_SESSION_REFRESH` int DEFAULT NULL,
  `LOGIN_USERNAME` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `REMEMBER_ME` bit(1) NOT NULL DEFAULT b'0',
  `STARTED` int DEFAULT NULL,
  `USER_ID` varchar(255) DEFAULT NULL,
  `USER_SESSION_STATE` int DEFAULT NULL,
  `BROKER_SESSION_ID` varchar(255) DEFAULT NULL,
  `BROKER_USER_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_SESSION`
--

LOCK TABLES `USER_SESSION` WRITE;
/*!40000 ALTER TABLE `USER_SESSION` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_SESSION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_SESSION_NOTE`
--

DROP TABLE IF EXISTS `USER_SESSION_NOTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_SESSION_NOTE` (
  `USER_SESSION` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VALUE` text,
  PRIMARY KEY (`USER_SESSION`,`NAME`),
  CONSTRAINT `FK5EDFB00FF51D3472` FOREIGN KEY (`USER_SESSION`) REFERENCES `USER_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_SESSION_NOTE`
--

LOCK TABLES `USER_SESSION_NOTE` WRITE;
/*!40000 ALTER TABLE `USER_SESSION_NOTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_SESSION_NOTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WEB_ORIGINS`
--

DROP TABLE IF EXISTS `WEB_ORIGINS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `WEB_ORIGINS` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`CLIENT_ID`,`VALUE`),
  KEY `IDX_WEB_ORIG_CLIENT` (`CLIENT_ID`),
  CONSTRAINT `FK_LOJPHO213XCX4WNKOG82SSRFY` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WEB_ORIGINS`
--

LOCK TABLES `WEB_ORIGINS` WRITE;
/*!40000 ALTER TABLE `WEB_ORIGINS` DISABLE KEYS */;
INSERT INTO `WEB_ORIGINS` VALUES ('a1724120-09b9-4727-b44b-69735af49212','http://localhost'),('a1724120-09b9-4727-b44b-69735af49212','http://localhost:8080'),('ef4d1c45-b293-4ce2-b700-2ef194731ba1','+');
/*!40000 ALTER TABLE `WEB_ORIGINS` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-10 19:41:59
