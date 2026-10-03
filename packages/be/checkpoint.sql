-- MariaDB dump 10.19-11.1.2-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: tahfeedz
-- ------------------------------------------------------
-- Server version	11.1.2-MariaDB-debug

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `academic_calendars`
--

DROP TABLE IF EXISTS `academic_calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `academic_calendars` (
  `id` varchar(36) NOT NULL,
  `school_id` varchar(36) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `description` text NOT NULL,
  `color` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academic_calendars`
--

LOCK TABLES `academic_calendars` WRITE;
/*!40000 ALTER TABLE `academic_calendars` DISABLE KEYS */;
INSERT INTO `academic_calendars` VALUES
('34a6be7c-49b5-11f1-8bb0-1865b4599d0c','582e4596-bb5b-11f0-8be0-d0008dc32c8f','2026-05-29','2026-06-03','Samain aja',NULL,'2026-05-07 01:35:07','2026-05-07 01:35:07',NULL),
('8aab2f95-15a1-4251-8f05-e03e7125c19b','582e4596-bb5b-11f0-8be0-d0008dc32c8f','2026-06-05','2026-06-08','SAya mau ngapain di hari ini juga gak tahu',NULL,'2026-05-07 02:29:31','2026-05-07 02:29:31',NULL),
('b4f89ac3-7c8c-4d33-a512-0a600d422042','582e4596-bb5b-11f0-8be0-d0008dc32c8f','2026-05-14','2026-05-16','Cuti jalan-jalan bersama',NULL,'2026-05-07 02:28:43','2026-05-07 02:28:43',NULL),
('f55fab4b-15b7-4d5d-9b44-ee9f2b2bcfba','582e4596-bb5b-11f0-8be0-d0008dc32c8f','2026-05-20','2026-05-22','Ngapain ya...',NULL,'2026-05-09 00:49:46','2026-05-09 00:49:46',NULL),
('fa96a255-49b4-11f1-8bb0-1865b4599d0c','582e4596-bb5b-11f0-8be0-d0008dc32c8f','2026-05-01','2026-05-05','Libur apa ya',NULL,'2026-05-07 01:35:07','2026-05-07 01:35:07',NULL);
/*!40000 ALTER TABLE `academic_calendars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activities`
--

DROP TABLE IF EXISTS `activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activities` (
  `id` varchar(36) NOT NULL,
  `school_id` varchar(36) NOT NULL,
  `year_id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activities`
--

LOCK TABLES `activities` WRITE;
/*!40000 ALTER TABLE `activities` DISABLE KEYS */;
/*!40000 ALTER TABLE `activities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activity_group_students`
--

DROP TABLE IF EXISTS `activity_group_students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity_group_students` (
  `activity_group_id` varchar(36) NOT NULL,
  `student_id` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_group_students`
--

LOCK TABLES `activity_group_students` WRITE;
/*!40000 ALTER TABLE `activity_group_students` DISABLE KEYS */;
/*!40000 ALTER TABLE `activity_group_students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activity_groups`
--

DROP TABLE IF EXISTS `activity_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activity_groups` (
  `id` varchar(36) NOT NULL,
  `activity_id` varchar(36) NOT NULL,
  `group_name` varchar(512) NOT NULL,
  `type` enum('repeat','event') NOT NULL,
  `repeat_time` text DEFAULT NULL,
  `event_time` text DEFAULT NULL,
  `teacher_id` varchar(36) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity_groups`
--

LOCK TABLES `activity_groups` WRITE;
/*!40000 ALTER TABLE `activity_groups` DISABLE KEYS */;
INSERT INTO `activity_groups` VALUES
('7efca2e1-1da9-4f30-b928-86f059641de0','33631473-72c2-433d-905c-cca991f64a63','Group Aja','repeat','[{\"day\":1,\"time\":\"3:30\"},{\"day\":2,\"time\":\"4:30\"}]',NULL,'6eb813b2-3db3-4e28-8bda-f8f9d49fae70','2026-05-22 23:59:42','2026-05-22 23:59:42',NULL);
/*!40000 ALTER TABLE `activity_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_settings`
--

DROP TABLE IF EXISTS `app_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_settings` (
  `id` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_settings`
--

LOCK TABLES `app_settings` WRITE;
/*!40000 ALTER TABLE `app_settings` DISABLE KEYS */;
INSERT INTO `app_settings` VALUES
('app_admin_phone','\"085755789922\"');
/*!40000 ALTER TABLE `app_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bill_details`
--

DROP TABLE IF EXISTS `bill_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bill_details` (
  `id` varchar(36) NOT NULL,
  `bill_id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL,
  `document` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_bill_detail_bill` (`bill_id`),
  CONSTRAINT `FK_bill_detail_bill` FOREIGN KEY (`bill_id`) REFERENCES `bills` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill_details`
--

LOCK TABLES `bill_details` WRITE;
/*!40000 ALTER TABLE `bill_details` DISABLE KEYS */;
INSERT INTO `bill_details` VALUES
('3bf512e9-192d-48be-8e5f-5a801973f42a','2c65885c-486f-4260-a114-cc00a7dbd0c2','SPP',250000,NULL),
('488c02db-7ab6-46f3-ba44-51cee432fd68','57e19a5d-187b-4a52-b12e-793541bf1a77','Foto-foto',6000,NULL),
('4fe7f210-0737-49ea-845c-52a09e570ce8','b5629708-6d85-4e51-b618-95dbda2ce582','Seragam',120000,'bill_98e96552-2f43-4404-b395-d36bf7f4b1d1.pdf'),
('62f7f6df-5239-4d48-90e2-37fa8dd91f26','57e19a5d-187b-4a52-b12e-793541bf1a77','Iuran Aja',18000,NULL),
('81ca9531-3ebb-45a5-a9e7-f4ecf6798ec1','8c882756-9ec8-4b62-960a-d0a6484f73b6','Membeli Yuyu',60000,NULL),
('dc831c64-6a36-480a-9c73-324d7b5b5f75','dadf6b09-a372-47e5-a9f0-f71cdd68f6a4','Hacuing',12300,NULL),
('edd24ce0-63bd-4679-b2fa-6290c6775d2c','0c3c60f6-47b3-4e7c-aa74-aab0e92b80c7','Muadaah',45000,'bill_22f5c387-751a-4392-8675-14691be8be21.pdf'),
('efd08f64-cf68-4182-bc30-fa65a40c9196','f4a0c31b-8b18-43f2-952f-0dc9d1cec37b','pui',990,NULL);
/*!40000 ALTER TABLE `bill_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bill_discounts`
--

DROP TABLE IF EXISTS `bill_discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bill_discounts` (
  `id` varchar(36) NOT NULL,
  `student_id` varchar(36) NOT NULL,
  `bill_detail_id` varchar(36) NOT NULL,
  `kind` enum('absolute','percentage') NOT NULL,
  `amount` int(11) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill_discounts`
--

LOCK TABLES `bill_discounts` WRITE;
/*!40000 ALTER TABLE `bill_discounts` DISABLE KEYS */;
INSERT INTO `bill_discounts` VALUES
('2adda6a6-93aa-4eb5-9d34-980cc2e801c6','cdc43038-bcb3-11f0-8ff6-9efd1c949119','4fe7f210-0737-49ea-845c-52a09e570ce8','absolute',6000,'','2026-06-02 02:02:51','2026-06-02 02:02:51',NULL),
('4bc1f4dc-9ca1-4a8f-a457-6ba2bd682c7b','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','3bf512e9-192d-48be-8e5f-5a801973f42a','percentage',50,'','2026-06-02 02:15:10','2026-06-02 02:15:10',NULL),
('5ecbf39a-b7bc-42cd-a788-54ce6ac88d83','cdc43038-bcb3-11f0-8ff6-9efd1c949119','edd24ce0-63bd-4679-b2fa-6290c6775d2c','absolute',15000,'Kongkow bersama','2026-06-02 02:02:51','2026-06-02 02:02:51',NULL),
('7b948d66-ce31-4c25-8cbe-33a28be38a09','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','3bf512e9-192d-48be-8e5f-5a801973f42a','percentage',40,'','2026-06-02 02:34:17','2026-06-02 02:34:17',NULL),
('8fc43ed7-847c-4e63-8d20-cece42d166e3','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119','edd24ce0-63bd-4679-b2fa-6290c6775d2c','percentage',70,'Anak yatim','2026-06-02 02:02:29','2026-06-02 02:02:29',NULL),
('90e5ac4a-dd0b-4e2c-86ca-17e6032bd613','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','edd24ce0-63bd-4679-b2fa-6290c6775d2c','percentage',50,'Anak pungut','2026-06-02 02:15:10','2026-06-02 02:15:10',NULL),
('ba560137-e82d-442d-ad60-e1b8f78ed1a8','cdc43038-bcb3-11f0-8ff6-9efd1c949119','3bf512e9-192d-48be-8e5f-5a801973f42a','percentage',40,'','2026-06-02 02:02:51','2026-06-02 02:02:51',NULL),
('cd38d5c7-0362-4cc6-a812-b771e2f405a2','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','edd24ce0-63bd-4679-b2fa-6290c6775d2c','absolute',20000,'','2026-06-02 02:34:17','2026-06-02 02:34:17',NULL);
/*!40000 ALTER TABLE `bill_discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bills`
--

DROP TABLE IF EXISTS `bills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bills` (
  `id` varchar(36) NOT NULL,
  `school_id` varchar(36) NOT NULL,
  `year_id` varchar(36) NOT NULL,
  `level` int(11) DEFAULT NULL,
  `class_id` varchar(36) DEFAULT NULL,
  `type` enum('monthly','event') NOT NULL,
  `event_date` date DEFAULT NULL,
  `monthly_date` int(11) DEFAULT NULL,
  `months` varchar(512) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bills`
--

LOCK TABLES `bills` WRITE;
/*!40000 ALTER TABLE `bills` DISABLE KEYS */;
INSERT INTO `bills` VALUES
('0c3c60f6-47b3-4e7c-aa74-aab0e92b80c7','582e4596-bb5b-11f0-8be0-d0008dc32c8f','c02187d2-bfd2-11f0-8d7c-cdee4485d186',NULL,NULL,'event','2026-01-10',NULL,NULL,'2026-01-13 16:23:18','2026-01-13 16:23:18',NULL),
('2c65885c-486f-4260-a114-cc00a7dbd0c2','582e4596-bb5b-11f0-8be0-d0008dc32c8f','c02187d2-bfd2-11f0-8d7c-cdee4485d186',NULL,NULL,'monthly',NULL,25,'[1,2,10,11,12,6,5,4,3,9,8,7]','2026-01-10 14:34:22','2026-01-10 14:34:22',NULL),
('57e19a5d-187b-4a52-b12e-793541bf1a77','582e4596-bb5b-11f0-8be0-d0008dc32c8f','c02187d2-bfd2-11f0-8d7c-cdee4485d186',7,NULL,'event','2026-05-07',NULL,'null','2026-05-16 09:06:14','2026-05-16 09:06:14',NULL),
('8c882756-9ec8-4b62-960a-d0a6484f73b6','582e4596-bb5b-11f0-8be0-d0008dc32c8f','c02187d2-bfd2-11f0-8d7c-cdee4485d186',7,'620f5ad2-bb60-11f0-8be0-d0008dc32c8f','event',NULL,NULL,'null','2026-05-16 09:07:37','2026-05-16 09:07:37',NULL),
('b5629708-6d85-4e51-b618-95dbda2ce582','582e4596-bb5b-11f0-8be0-d0008dc32c8f','c02187d2-bfd2-11f0-8d7c-cdee4485d186',NULL,NULL,'event','2026-01-08',NULL,NULL,'2026-01-10 20:45:10','2026-01-10 20:45:10',NULL),
('dadf6b09-a372-47e5-a9f0-f71cdd68f6a4','582e4596-bb5b-11f0-8be0-d0008dc32c8f','c02187d2-bfd2-11f0-8d7c-cdee4485d186',7,'6684dbce-bb60-11f0-8be0-d0008dc32c8f','monthly',NULL,25,'[1,2,3,4,7,8,9,10,11,12]','2026-05-21 03:29:59','2026-05-21 03:29:59',NULL),
('f4a0c31b-8b18-43f2-952f-0dc9d1cec37b','582e4596-bb5b-11f0-8be0-d0008dc32c8f','c02187d2-bfd2-11f0-8d7c-cdee4485d186',8,NULL,'event',NULL,NULL,NULL,'2026-05-16 09:40:56','2026-05-16 09:40:56',NULL);
/*!40000 ALTER TABLE `bills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `checklist`
--

DROP TABLE IF EXISTS `checklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `checklist` (
  `id` varchar(36) NOT NULL,
  `juz` int(11) NOT NULL,
  `reader` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `checklist`
--

LOCK TABLES `checklist` WRITE;
/*!40000 ALTER TABLE `checklist` DISABLE KEYS */;
INSERT INTO `checklist` VALUES
('0966a087-ae9b-4cde-9484-50fb248a168a',20,'Asep'),
('993849e9-7c58-4fe1-a0b6-8e81642ba7a6',1,'Bue'),
('d60a6322-b275-431d-b448-48cb6af322e4',2,'Asep');
/*!40000 ALTER TABLE `checklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class_students`
--

DROP TABLE IF EXISTS `class_students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class_students` (
  `class_id` varchar(36) NOT NULL,
  `student_id` varchar(36) NOT NULL,
  PRIMARY KEY (`class_id`,`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_students`
--

LOCK TABLES `class_students` WRITE;
/*!40000 ALTER TABLE `class_students` DISABLE KEYS */;
INSERT INTO `class_students` VALUES
('30548357-bb60-11f0-8be0-d0008dc32c8f','181eed5e-bc92-11f0-8ff6-9efd1c949119'),
('30548357-bb60-11f0-8be0-d0008dc32c8f','ade39ae6-0a74-4aa6-8469-332338c67f5a'),
('3ee690c5-e563-4628-921b-caf8c5211c89','decd6e92-8608-41c5-a1de-0a7cab1978ca'),
('620f5ad2-bb60-11f0-8be0-d0008dc32c8f','3c60f715-d997-11f0-8cda-5bb67e5632f8'),
('620f5ad2-bb60-11f0-8be0-d0008dc32c8f','598f3241-bc5f-11f0-8b9c-41333d9a4eb4'),
('620f5ad2-bb60-11f0-8be0-d0008dc32c8f','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4'),
('620f5ad2-bb60-11f0-8be0-d0008dc32c8f','7c923100-bc5f-11f0-8b9c-41333d9a4eb4'),
('620f5ad2-bb60-11f0-8be0-d0008dc32c8f','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119'),
('6684dbce-bb60-11f0-8be0-d0008dc32c8f','b31b930f-74e4-48ca-9b60-b2fe6a5ffc38'),
('6d4ce003-c233-11f0-97b8-7f5632f63d4c','038321b7-2a60-4198-b33c-fcda3097384f'),
('6d4ce003-c233-11f0-97b8-7f5632f63d4c','04d1dde7-8a7a-41be-9e05-1a6742431068'),
('6d4ce003-c233-11f0-97b8-7f5632f63d4c','25cbd15f-7be5-444a-b3ce-4d365523ad7d'),
('6d4ce003-c233-11f0-97b8-7f5632f63d4c','2bea7bf8-e0a0-4381-9fce-e3ebd436ce8a'),
('6d4ce003-c233-11f0-97b8-7f5632f63d4c','32dc7214-5768-40ae-b970-c249ae09f061'),
('6d4ce003-c233-11f0-97b8-7f5632f63d4c','4f5e9005-82e1-4594-b84f-c454e23c3115'),
('6d4ce003-c233-11f0-97b8-7f5632f63d4c','508a76f9-4bad-4fa4-a2a0-b49dbb52e92f'),
('6d4ce003-c233-11f0-97b8-7f5632f63d4c','b149abd8-87a1-404d-b6ca-e639d7d13e36'),
('6d4ce003-c233-11f0-97b8-7f5632f63d4c','bcaf2469-4320-4f0b-a8ee-585a8f9d5747'),
('6d4ce003-c233-11f0-97b8-7f5632f63d4c','c9746ea1-0524-4577-baf7-71f6311a4789'),
('6d4ce003-c233-11f0-97b8-7f5632f63d4c','cdc43038-bcb3-11f0-8ff6-9efd1c949119'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','00cfd0ba-cbb2-4670-8b3c-d6cd2a4f8454'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','0100b8d3-db1a-4e5c-b8c6-6e9331296639'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','0ddc9d71-d531-4aa6-9a1b-522f84f3392f'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','10a4dc87-b25f-4e16-86f6-7419e5bf6680'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','13462007-01ce-4706-8ec1-a79e66e13810'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','14c67b62-baab-473e-bf68-162609dc58a6'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','1c350c0c-0049-4279-8cda-979cec168cee'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','1e608249-c576-4859-ba48-3d9953698ff1'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','28fe7b79-0425-449a-9bc8-c17614b10ef3'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','299e5fcc-6b5e-46e9-a2fa-e87cfa58130d'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','30ee6a18-7d01-494f-9c94-a011d718fdaf'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','39c0261f-c11d-48e2-b016-21c2fbc132c5'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','3f01fb8a-4be9-4d66-9532-788f41e8180f'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','3f15a0c5-f4be-4be2-8281-febe2d6df0bf'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','41b2ddfd-0b33-4489-a36c-1dc9d7ab8220'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','477df533-0808-43c9-a197-5f0217263fb6'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','53c1ec9d-a0b0-47b7-aca9-232d101ff9ac'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','5bb761e7-1970-4713-9091-e93657ecd549'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','5cc59331-3990-4f11-a7d0-c68b451580d1'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','66ec75ea-34a2-4998-b903-bc5a43140c83'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','6bf811b9-c46e-4bbd-a01a-e9352ba1ed9a'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','740a830d-c6d4-48f2-ae86-fb41dd79daf8'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','747b2ae0-78fe-4f5a-bc61-49192238cbb0'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','7941f389-e340-4832-b2b4-a143c2e5edb0'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','7c2e69b6-c5cf-48dd-8c12-0be1926d913a'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','7cbe8ac5-dd08-44d9-9211-fa904de1fd36'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','80836b79-60ab-4854-b012-220f6c455eab'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','8df751a2-d892-4d1f-b0e9-206293967ee7'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','8f01b104-752a-47f7-af6e-556255f45c98'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','8f4ef44e-5c24-4f57-9e42-7fc4c2be3f82'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','99e34b4c-b2e1-449c-b57c-e105321ff486'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','9b84a652-bec4-419e-92ff-439d4ecc769d'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','9be982c3-07ec-437a-8daf-812aa3aabc8b'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','9bf64ba7-87bf-4619-97c4-1f4ede80f6f2'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','9edeba00-41ab-4123-9e39-6bd5ee0f4ec7'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','a73e31f7-d91c-4289-b1c1-6fb24aa41de6'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','a8ff31af-53bf-476c-8510-bf5563ca4888'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','b046a17e-7500-4885-8059-0107a9a175f4'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','b1ad3592-8a5b-4306-a4b8-2073226a316b'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','b8059962-dd58-4d00-92a6-d4dd7da612d4'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','babbb196-bbfe-414d-93b2-04f7ecb41ab9'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','c1af427c-51f0-4e6f-a431-907641b5a881'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','c27649d9-fa9f-4deb-9ffb-17c0e08734aa'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','c88d10f9-1e87-45a9-8b3b-413444a9b6dd'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','c9447e02-d2b3-4c83-9994-c14fda0bcacb'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','cd4eb5de-1e72-4067-92af-9c5ef419c3f1'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','d2d31358-584e-4676-8d6e-d84d9fdb0dac'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','da860c99-dfc5-4ab3-8f71-774401627be7'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','dab46734-674f-44f3-b00e-f3cce2b96616'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','dd7effba-3042-41b4-a50e-bc2ae9f3bebc'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','df9c5bb7-b51d-4323-8361-cdce95040f9c'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','eaad1e70-771d-4bbb-966b-704d14d694a7'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','ec56c62a-ce80-4dfc-b486-297cb6718d43'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','ed40f062-7c70-4080-8939-293375cc6f13'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','f1be5352-69a0-40d3-9c79-89d7a3af3254'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','f2bbc5e7-58c3-4ce5-9b1d-4139c2c3c2b2'),
('726afee5-c233-11f0-97b8-7f5632f63d4c','fc36c5cb-32ee-4e29-acc7-19778abf0afd'),
('776268a8-c233-11f0-97b8-7f5632f63d4c','40874588-f436-4d59-a9e2-48b9bebe563d');
/*!40000 ALTER TABLE `class_students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class_teachers`
--

DROP TABLE IF EXISTS `class_teachers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class_teachers` (
  `class_id` varchar(36) NOT NULL,
  `teacher_id` varchar(36) NOT NULL,
  PRIMARY KEY (`class_id`,`teacher_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_teachers`
--

LOCK TABLES `class_teachers` WRITE;
/*!40000 ALTER TABLE `class_teachers` DISABLE KEYS */;
INSERT INTO `class_teachers` VALUES
('30548357-bb60-11f0-8be0-d0008dc32c8f','9310ee0e-bcb1-11f0-8ff6-9efd1c949119'),
('30548357-bb60-11f0-8be0-d0008dc32c8f','f82def14-bc61-11f0-8b9c-41333d9a4eb4');
/*!40000 ALTER TABLE `class_teachers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classes`
--

DROP TABLE IF EXISTS `classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classes` (
  `id` varchar(36) NOT NULL,
  `school_id` varchar(36) NOT NULL,
  `year_id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `level` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classes`
--

LOCK TABLES `classes` WRITE;
/*!40000 ALTER TABLE `classes` DISABLE KEYS */;
INSERT INTO `classes` VALUES
('30548357-bb60-11f0-8be0-d0008dc32c8f','582e4596-bb5b-11f0-8be0-d0008dc32c8f','c02187d2-bfd2-11f0-8d7c-cdee4485d186','1A',7,'2025-11-06 15:30:23','2025-11-06 15:30:23',NULL),
('3ee690c5-e563-4628-921b-caf8c5211c89','0001795c-2ef5-e011-a96c-63a882fbcc5a','c02187d2-bfd2-11f0-8d7c-cdee4485d186','1 A',7,'2026-05-16 06:44:24','2026-05-16 06:44:24',NULL),
('620f5ad2-bb60-11f0-8be0-d0008dc32c8f','582e4596-bb5b-11f0-8be0-d0008dc32c8f','c02187d2-bfd2-11f0-8d7c-cdee4485d186','1B',7,'2025-11-06 15:31:47','2025-11-06 15:31:47',NULL),
('6684dbce-bb60-11f0-8be0-d0008dc32c8f','582e4596-bb5b-11f0-8be0-d0008dc32c8f','c02187d2-bfd2-11f0-8d7c-cdee4485d186','1C',7,'2025-11-06 15:31:54','2025-11-06 15:31:54',NULL),
('6d4ce003-c233-11f0-97b8-7f5632f63d4c','582e4596-bb5b-11f0-8be0-d0008dc32c8f','c02187d2-bfd2-11f0-8d7c-cdee4485d186','2A',8,'2025-11-15 07:57:37','2025-11-15 07:57:37',NULL),
('726afee5-c233-11f0-97b8-7f5632f63d4c','582e4596-bb5b-11f0-8be0-d0008dc32c8f','c02187d2-bfd2-11f0-8d7c-cdee4485d186','2B',8,'2025-11-15 07:57:46','2025-11-15 07:57:46',NULL),
('776268a8-c233-11f0-97b8-7f5632f63d4c','582e4596-bb5b-11f0-8be0-d0008dc32c8f','c02187d2-bfd2-11f0-8d7c-cdee4485d186','3A',9,'2025-11-15 07:57:54','2025-11-15 07:57:54',NULL),
('8e11f1e0-b17b-4b31-b2d5-2199a1664a13','582e4596-bb5b-11f0-8be0-d0008dc32c8f','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Salman Salfarisi',7,'2026-05-01 19:19:51','2026-05-01 19:19:51',NULL),
('9e8c89af-bc74-11f0-8ff6-9efd1c949119','582e4596-bb5b-11f0-8be0-d0008dc32c8f','c02187d2-bfd2-11f0-8d7c-cdee4485d186','1D',7,'2025-11-08 07:29:11','2025-11-08 07:29:11',NULL),
('a92f3fca-c93c-11f0-915c-67eb632cb60c','582e4596-bb5b-11f0-8be0-d0008dc32c8f','c02187d2-bfd2-11f0-8d7c-cdee4485d186','1 SMA A',10,'2025-11-24 13:51:14','2025-11-24 13:51:14',NULL),
('bd5cd34a-bc74-11f0-8ff6-9efd1c949119','582e4596-bb5b-11f0-8be0-d0008dc32c8f','c02187d2-bfd2-11f0-8d7c-cdee4485d186','1E',7,'2025-11-08 07:30:02','2025-11-08 07:30:02',NULL),
('ca955fb7-3859-4e19-9f9d-732207a464d7','0005ed5c-2ef5-e011-9fee-6124ccb9e3de','c02187d2-bfd2-11f0-8d7c-cdee4485d186','1A',7,'2026-07-09 00:57:55','2026-07-09 00:57:55',NULL);
/*!40000 ALTER TABLE `classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` varchar(36) NOT NULL,
  `owner_id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  `reply_comment_id` varchar(36) DEFAULT NULL,
  `content` text NOT NULL,
  `is_edited` tinyint(1) NOT NULL DEFAULT 0,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES
('0bca8e0c-45c7-4911-840e-b28863911eaa','fab1679b-0e9b-4a32-8f5e-ba1d1ba3b688','5b81ce5e-cce5-11f0-8f97-aa3b281802c1',NULL,'Apa ya',0,'2026-02-17 04:21:19','2026-02-17 04:21:19','2026-02-17 04:21:19',NULL),
('0d714f10-deb8-4a49-ae8d-93cc74688017','fab1679b-0e9b-4a32-8f5e-ba1d1ba3b688','5b81ce5e-cce5-11f0-8f97-aa3b281802c1','8f3bdd50-1c0f-4841-ab0e-bad851b3bb50','Masak gak tau',0,'2026-02-09 19:07:25','2026-02-09 19:07:25','2026-02-09 19:07:25',NULL),
('1b9f86d2-8792-4a4f-9065-0e000c13d491','6a9ed6fc-5f5a-4a3a-9350-eccdc5332f8c','5b81ce5e-cce5-11f0-8f97-aa3b281802c1',NULL,'Comment',0,'2026-05-09 02:23:55','2026-05-09 02:23:55','2026-05-09 02:23:55',NULL),
('304e349f-3442-4f90-beef-acbdb554dfa9','fd239790-b99b-40ac-9674-c5aac3a3ca1d','7296ff26-bca0-11f0-8ff6-9efd1c949119',NULL,'oke',0,'2026-02-22 19:16:56','2026-02-22 19:16:56','2026-02-22 19:16:56',NULL),
('517a3660-b7d7-4616-a371-625a69de5201','fd239790-b99b-40ac-9674-c5aac3a3ca1d','7296ff26-bca0-11f0-8ff6-9efd1c949119','808c0511-21ca-486d-81b3-c58a5573f801','iya',0,'2026-02-22 19:17:38','2026-02-22 19:17:38','2026-02-22 19:17:38',NULL),
('730207f8-d808-4210-a9fa-9679a4e1245f','6a9ed6fc-5f5a-4a3a-9350-eccdc5332f8c','7296ff26-bca0-11f0-8ff6-9efd1c949119','e37df775-ae82-4675-9940-8974ea5145bb','Bintang kejora',0,'2026-06-14 02:52:30','2026-06-14 02:52:30','2026-06-14 02:52:30',NULL),
('808c0511-21ca-486d-81b3-c58a5573f801','fd239790-b99b-40ac-9674-c5aac3a3ca1d','7296ff26-bca0-11f0-8ff6-9efd1c949119','304e349f-3442-4f90-beef-acbdb554dfa9','bagus',0,'2026-02-22 19:17:05','2026-02-22 19:17:05','2026-02-22 19:17:05',NULL),
('8f3bdd50-1c0f-4841-ab0e-bad851b3bb50','fab1679b-0e9b-4a32-8f5e-ba1d1ba3b688','5b81ce5e-cce5-11f0-8f97-aa3b281802c1',NULL,'Apa ini?',0,'2026-02-09 19:07:10','2026-02-09 19:07:10','2026-02-09 19:07:10',NULL),
('8fd66823-af40-4d75-9984-5f0c69fedc90','fab1679b-0e9b-4a32-8f5e-ba1d1ba3b688','7296ff26-bca0-11f0-8ff6-9efd1c949119',NULL,'SAya siapa',0,'2026-02-22 19:07:30','2026-02-22 19:07:30','2026-02-22 19:07:30',NULL),
('98c6799f-dff2-415d-be6a-a99d5c0c8c96','6a9ed6fc-5f5a-4a3a-9350-eccdc5332f8c','7296ff26-bca0-11f0-8ff6-9efd1c949119','e37df775-ae82-4675-9940-8974ea5145bb','Bintang pelita',0,'2026-06-14 02:52:56','2026-06-14 02:52:56','2026-06-14 02:52:56',NULL),
('aa40853f-3657-4941-9de1-5bad36212fc2','fab1679b-0e9b-4a32-8f5e-ba1d1ba3b688','7296ff26-bca0-11f0-8ff6-9efd1c949119','0d714f10-deb8-4a49-ae8d-93cc74688017','Kalau gak tau kenapa?',0,'2026-05-18 18:19:43','2026-05-18 18:19:43','2026-05-18 18:19:43',NULL),
('c5e79873-3b9d-41af-95ca-a54e8a78a2a7','fd239790-b99b-40ac-9674-c5aac3a3ca1d','7296ff26-bca0-11f0-8ff6-9efd1c949119','808c0511-21ca-486d-81b3-c58a5573f801','bagus sekali',0,'2026-02-22 19:17:24','2026-02-22 19:17:24','2026-02-22 19:17:24',NULL),
('df71fabf-70a3-4ae7-90e3-931a0206b549','fd239790-b99b-40ac-9674-c5aac3a3ca1d','7296ff26-bca0-11f0-8ff6-9efd1c949119','304e349f-3442-4f90-beef-acbdb554dfa9','yap',0,'2026-02-22 19:17:46','2026-02-22 19:17:46','2026-02-22 19:17:46',NULL),
('e37df775-ae82-4675-9940-8974ea5145bb','6a9ed6fc-5f5a-4a3a-9350-eccdc5332f8c','7296ff26-bca0-11f0-8ff6-9efd1c949119',NULL,'Oke',0,'2026-06-14 02:51:28','2026-06-14 02:51:28','2026-06-14 02:51:28',NULL);
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contract_preparations`
--

DROP TABLE IF EXISTS `contract_preparations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contract_preparations` (
  `id` varchar(36) NOT NULL,
  `institute_name` varchar(255) NOT NULL,
  `institute_address` varchar(255) NOT NULL,
  `institute_pic` varchar(255) NOT NULL,
  `institute_pic_position` varchar(255) NOT NULL,
  `institute_phone` varchar(255) NOT NULL,
  `service_packet` varchar(255) NOT NULL,
  `service_student_count` varchar(255) NOT NULL,
  `service_whitelabel` varchar(255) NOT NULL,
  `service_period` varchar(255) NOT NULL,
  `service_note` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contract_preparations`
--

LOCK TABLES `contract_preparations` WRITE;
/*!40000 ALTER TABLE `contract_preparations` DISABLE KEYS */;
/*!40000 ALTER TABLE `contract_preparations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `counters`
--

DROP TABLE IF EXISTS `counters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `counters` (
  `counter_key` varchar(50) NOT NULL,
  `add_key` varchar(50) DEFAULT NULL,
  `current_value` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`counter_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `counters`
--

LOCK TABLES `counters` WRITE;
/*!40000 ALTER TABLE `counters` DISABLE KEYS */;
INSERT INTO `counters` VALUES
('payment_transactions','20260515',2);
/*!40000 ALTER TABLE `counters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_schedules`
--

DROP TABLE IF EXISTS `course_schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_schedules` (
  `id` varchar(36) NOT NULL,
  `class_id` varchar(36) NOT NULL,
  `course_id` varchar(36) NOT NULL,
  `day` int(11) NOT NULL,
  `slot_number` int(11) NOT NULL,
  `lh` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_schedules`
--

LOCK TABLES `course_schedules` WRITE;
/*!40000 ALTER TABLE `course_schedules` DISABLE KEYS */;
INSERT INTO `course_schedules` VALUES
('00be635f-93e1-4738-8684-66527a5267e9','30548357-bb60-11f0-8be0-d0008dc32c8f','82d04c26-ba0c-4e62-9f79-eb0f980024e5',3,1,1,'2026-01-24 15:26:43','2026-01-24 15:26:43',NULL),
('0244e759-bfef-4588-99a5-78bc8810b2fb','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','e8725c90-e3f0-4f54-8b5f-83214fedabbc',5,3,1,'2026-01-24 17:17:52','2026-01-24 17:17:52',NULL),
('03b2ab50-d96d-4480-a001-d72f5f7b994d','30548357-bb60-11f0-8be0-d0008dc32c8f','e8725c90-e3f0-4f54-8b5f-83214fedabbc',4,1,1,'2026-01-24 15:27:31','2026-01-24 15:27:31',NULL),
('0599c276-36b7-4fa0-8595-51d62014e1eb','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','7d14a4fb-8739-45d2-a981-26fcbe9d7877',3,9,1,'2026-01-24 15:45:51','2026-01-24 15:45:51',NULL),
('072cd63b-bea4-4109-b5bc-f2d9b25f27f1','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','7da73b69-f93b-11f0-8ce0-93ce4d178a72',0,2,1,'2026-05-03 16:01:32','2026-05-03 16:01:32',NULL),
('0873dc7a-be07-4903-a2d8-a2180beacbdd','30548357-bb60-11f0-8be0-d0008dc32c8f','82d04c26-ba0c-4e62-9f79-eb0f980024e5',4,4,1,'2026-01-24 15:27:37','2026-01-24 15:27:37',NULL),
('09e14c2c-c129-47f4-8e1b-a562621ca0f0','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','269fd7de-c53b-45e4-9b8c-3d94b2b1ba21',6,2,1,'2026-01-24 15:53:39','2026-01-24 15:53:39',NULL),
('0e8f4114-8d9b-40a4-86b9-7f493f8d11d8','30548357-bb60-11f0-8be0-d0008dc32c8f','82d04c26-ba0c-4e62-9f79-eb0f980024e5',4,3,1,'2026-01-24 15:27:34','2026-01-24 15:27:34',NULL),
('0f0e42a0-a06f-46d2-a8fc-ebcc7369cb68','6684dbce-bb60-11f0-8be0-d0008dc32c8f','269fd7de-c53b-45e4-9b8c-3d94b2b1ba21',1,1,1,'2026-01-28 15:43:37','2026-01-28 15:43:37',NULL),
('0f4653b3-6b11-4877-9f6b-cb9727c5f726','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','e8725c90-e3f0-4f54-8b5f-83214fedabbc',1,7,1,'2026-01-24 15:40:51','2026-01-24 15:40:51',NULL),
('102b6d38-dd2d-4b18-b250-e1e3492d77a6','30548357-bb60-11f0-8be0-d0008dc32c8f','82d04c26-ba0c-4e62-9f79-eb0f980024e5',1,2,1,'2026-01-24 15:07:27','2026-01-24 15:07:27',NULL),
('15c490c5-f717-4b4f-bfad-15d93d53e7b8','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','47bcdeda-afef-42bf-8b6b-780f29e15d6f',5,6,1,'2026-01-24 17:17:56','2026-01-24 17:17:56',NULL),
('177e3220-1928-46f4-9bde-dc8fbe38c87a','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','12cacf7b-c4a0-43b0-989d-748baf2ddf83',1,9,1,'2026-01-24 15:40:54','2026-01-24 15:40:54',NULL),
('199f3fd2-a20e-4fbc-b66e-fabd916b5e75','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','e8725c90-e3f0-4f54-8b5f-83214fedabbc',4,2,1,'2026-01-24 18:15:26','2026-01-24 18:15:26',NULL),
('1d3bf5d3-40d1-4968-8466-f39c8e27659a','30548357-bb60-11f0-8be0-d0008dc32c8f','82d04c26-ba0c-4e62-9f79-eb0f980024e5',6,5,1,'2026-05-14 22:50:27','2026-05-14 22:50:27',NULL),
('1dde0091-3561-4e84-8e92-129235447126','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','e8725c90-e3f0-4f54-8b5f-83214fedabbc',4,9,1,'2026-01-24 18:15:38','2026-01-24 18:15:38',NULL),
('1e363340-6f46-401a-a28d-9539152cd88a','30548357-bb60-11f0-8be0-d0008dc32c8f','8cca993f-6a1c-4a75-b92c-bc280f001deb',4,6,1,'2026-01-24 15:27:41','2026-01-24 15:27:41',NULL),
('2074264b-2a5f-4630-bd1e-87f1ef51ee33','6684dbce-bb60-11f0-8be0-d0008dc32c8f','e8725c90-e3f0-4f54-8b5f-83214fedabbc',1,2,1,'2026-01-28 15:43:38','2026-01-28 15:43:38',NULL),
('2212cc23-f64f-4159-9f8d-03aa1248d2fa','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','12cacf7b-c4a0-43b0-989d-748baf2ddf83',3,8,1,'2026-01-24 15:45:48','2026-01-24 15:45:48',NULL),
('223c8a4d-373b-47ee-bf2b-c9786409e2dc','30548357-bb60-11f0-8be0-d0008dc32c8f','ccf7b1c3-d440-4452-b78a-dbdf49ca8e57',3,6,1,'2026-01-24 15:26:54','2026-01-24 15:26:54',NULL),
('291133d0-413d-468d-a3c7-f65675cec182','30548357-bb60-11f0-8be0-d0008dc32c8f','ccf7b1c3-d440-4452-b78a-dbdf49ca8e57',2,5,1,'2026-01-24 15:16:43','2026-01-24 15:16:43',NULL),
('2cc71317-09b2-4230-b6db-4b742422947a','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','ccf7b1c3-d440-4452-b78a-dbdf49ca8e57',6,6,1,'2026-01-24 15:53:45','2026-01-24 15:53:45',NULL),
('2f2e21fd-f10d-4c77-9fca-79d89d20a98d','30548357-bb60-11f0-8be0-d0008dc32c8f','12cacf7b-c4a0-43b0-989d-748baf2ddf83',5,4,1,'2026-01-24 15:28:16','2026-01-24 15:28:16',NULL),
('2f80ffeb-584c-4acc-a7cc-f59b2524ddef','30548357-bb60-11f0-8be0-d0008dc32c8f','12cacf7b-c4a0-43b0-989d-748baf2ddf83',3,8,1,'2026-01-24 15:26:59','2026-01-24 15:26:59',NULL),
('2fac98fa-27d0-4fc3-935a-d065f6e3f782','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','7da73b69-f93b-11f0-8ce0-93ce4d178a72',5,8,1,'2026-01-24 17:18:01','2026-01-24 17:18:01',NULL),
('34646f5b-ace7-462b-a40f-7cdb5878a769','6d4ce003-c233-11f0-97b8-7f5632f63d4c','82d04c26-ba0c-4e62-9f79-eb0f980024e5',1,1,1,'2026-03-13 20:06:12','2026-03-13 20:06:12',NULL),
('35131f98-4173-4f90-854c-277fd01565c8','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','47bcdeda-afef-42bf-8b6b-780f29e15d6f',2,6,1,'2026-01-24 15:41:10','2026-01-24 15:41:10',NULL),
('35a263e6-5eb3-4be2-b44d-c33a19dc96a4','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','82d04c26-ba0c-4e62-9f79-eb0f980024e5',1,1,1,'2026-01-24 15:40:40','2026-01-24 15:40:40',NULL),
('3641a61a-4c65-420f-8422-cf4dba91500d','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','8cca993f-6a1c-4a75-b92c-bc280f001deb',6,8,1,'2026-01-24 15:53:49','2026-01-24 15:53:49',NULL),
('3713f565-0355-4834-a9a4-1cdd690b150f','30548357-bb60-11f0-8be0-d0008dc32c8f','82d04c26-ba0c-4e62-9f79-eb0f980024e5',3,2,1,'2026-01-24 15:26:44','2026-01-24 15:26:44',NULL),
('3bb3ac9d-6bfe-49b4-9162-d4a5257e788f','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','e8725c90-e3f0-4f54-8b5f-83214fedabbc',5,4,1,'2026-01-24 17:17:54','2026-01-24 17:17:54',NULL),
('3d27e631-bb61-47a1-ad45-64ee87438864','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','7d14a4fb-8739-45d2-a981-26fcbe9d7877',3,3,1,'2026-01-24 15:41:26','2026-01-24 15:41:26',NULL),
('3dfa32bb-e71f-4e0a-8a1d-7c6e5df45290','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','47bcdeda-afef-42bf-8b6b-780f29e15d6f',1,4,1,'2026-01-24 15:40:45','2026-01-24 15:40:45',NULL),
('3ee8a8f5-6ebd-4c08-ac0d-b13a1aaf70b7','30548357-bb60-11f0-8be0-d0008dc32c8f','7d14a4fb-8739-45d2-a981-26fcbe9d7877',3,7,1,'2026-01-24 15:26:56','2026-01-24 15:26:56',NULL),
('43b52e85-f07d-4ef6-835f-e0ece204c5c1','6d4ce003-c233-11f0-97b8-7f5632f63d4c','47bcdeda-afef-42bf-8b6b-780f29e15d6f',1,2,1,'2026-03-13 20:06:14','2026-03-13 20:06:14',NULL),
('442218c6-0ebe-4e8f-8dcf-2fa822e83ff1','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','ccf7b1c3-d440-4452-b78a-dbdf49ca8e57',2,8,1,'2026-01-24 15:41:15','2026-01-24 15:41:15',NULL),
('44a82f8c-99ce-45e3-a0e8-ea8504b0ccad','30548357-bb60-11f0-8be0-d0008dc32c8f','12cacf7b-c4a0-43b0-989d-748baf2ddf83',2,7,1,'2026-01-24 15:16:46','2026-01-24 15:16:46',NULL),
('49d4a6d5-4b49-415d-a437-65d76f076ded','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','7da73b69-f93b-11f0-8ce0-93ce4d178a72',5,9,1,'2026-01-24 17:18:03','2026-01-24 17:18:03',NULL),
('4b28b213-981e-49ce-8222-9ad7567ef22f','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','7da73b69-f93b-11f0-8ce0-93ce4d178a72',6,5,1,'2026-01-24 15:53:44','2026-01-24 15:53:44',NULL),
('4e8675ac-1011-4427-9fb9-edfdfdc69933','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','82d04c26-ba0c-4e62-9f79-eb0f980024e5',4,6,1,'2026-01-24 18:15:32','2026-01-24 18:15:32',NULL),
('5474d8c1-3697-4103-a226-3bf34893e44a','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','82d04c26-ba0c-4e62-9f79-eb0f980024e5',5,5,1,'2026-01-24 17:17:55','2026-01-24 17:17:55',NULL),
('5af171d8-e01a-4ca6-9bcb-2743f7f8e053','30548357-bb60-11f0-8be0-d0008dc32c8f','e8725c90-e3f0-4f54-8b5f-83214fedabbc',6,3,1,'2026-01-28 15:39:21','2026-01-28 15:39:21',NULL),
('5bc972c6-b3fa-4659-926d-600e4373ecd1','30548357-bb60-11f0-8be0-d0008dc32c8f','82d04c26-ba0c-4e62-9f79-eb0f980024e5',2,1,1,'2026-01-24 15:16:37','2026-01-24 15:16:37',NULL),
('620273ea-7d9c-4e68-b283-bfce48d9a01d','30548357-bb60-11f0-8be0-d0008dc32c8f','82d04c26-ba0c-4e62-9f79-eb0f980024e5',1,8,1,'2026-01-24 15:09:20','2026-01-24 15:09:20',NULL),
('6255b922-9aba-4e99-98a4-0d8128249368','30548357-bb60-11f0-8be0-d0008dc32c8f','ccf7b1c3-d440-4452-b78a-dbdf49ca8e57',5,1,1,'2026-01-24 15:28:09','2026-01-24 15:28:09',NULL),
('6849203e-11f1-446f-8b4a-a4fb9699b047','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','7da73b69-f93b-11f0-8ce0-93ce4d178a72',3,5,1,'2026-01-24 15:45:42','2026-01-24 15:45:42',NULL),
('6b01b00a-3f0c-41cc-803e-84278f5e2bb0','30548357-bb60-11f0-8be0-d0008dc32c8f','47bcdeda-afef-42bf-8b6b-780f29e15d6f',1,3,1,'2026-01-24 15:07:29','2026-01-24 15:07:29',NULL),
('6d2f3249-da84-4691-980e-93b82c0e63f3','30548357-bb60-11f0-8be0-d0008dc32c8f','12cacf7b-c4a0-43b0-989d-748baf2ddf83',3,9,1,'2026-01-24 15:27:01','2026-01-24 15:27:01',NULL),
('6d3f6959-54e7-4747-9f77-6f35103caf87','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','47bcdeda-afef-42bf-8b6b-780f29e15d6f',5,7,1,'2026-01-24 17:17:58','2026-01-24 17:17:58',NULL),
('7068ee60-6e19-48b1-9ef6-b6d0163654ce','30548357-bb60-11f0-8be0-d0008dc32c8f','e8725c90-e3f0-4f54-8b5f-83214fedabbc',5,6,1,'2026-01-24 15:28:19','2026-01-24 15:28:19',NULL),
('70e64a92-3d09-4095-bef3-8b607373d767','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','7d14a4fb-8739-45d2-a981-26fcbe9d7877',3,4,1,'2026-01-24 15:41:28','2026-01-24 15:41:28',NULL),
('71df3aac-aa8c-4d5c-b036-1cdb4134bff4','30548357-bb60-11f0-8be0-d0008dc32c8f','47bcdeda-afef-42bf-8b6b-780f29e15d6f',1,4,1,'2026-01-24 15:07:30','2026-01-24 15:07:30',NULL),
('84ec3eae-5cd0-4e0b-bc39-1b53bb686646','30548357-bb60-11f0-8be0-d0008dc32c8f','82d04c26-ba0c-4e62-9f79-eb0f980024e5',6,1,1,'2026-01-28 15:39:16','2026-01-28 15:39:16',NULL),
('87fdc6ae-41e0-4cfc-ba0b-f855577ecfcd','30548357-bb60-11f0-8be0-d0008dc32c8f','82d04c26-ba0c-4e62-9f79-eb0f980024e5',1,5,1,'2026-01-24 15:23:21','2026-01-24 15:23:21',NULL),
('886362c0-8fa5-4e32-853f-f4b3a8018fe3','30548357-bb60-11f0-8be0-d0008dc32c8f','ccf7b1c3-d440-4452-b78a-dbdf49ca8e57',2,8,1,'2026-01-24 15:16:48','2026-01-24 15:16:48',NULL),
('89c56d92-3302-47a2-b391-85d2c8041987','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','82d04c26-ba0c-4e62-9f79-eb0f980024e5',4,5,1,'2026-01-24 18:15:31','2026-01-24 18:15:31',NULL),
('8ba5234f-6be8-4c55-ae69-cf60932c5702','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','7d14a4fb-8739-45d2-a981-26fcbe9d7877',4,4,1,'2026-01-24 18:15:29','2026-01-24 18:15:29',NULL),
('8c84dedd-d0df-430f-8ffa-4758a044169f','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','47bcdeda-afef-42bf-8b6b-780f29e15d6f',4,7,1,'2026-03-04 21:23:59','2026-03-04 21:23:59',NULL),
('8c9dd353-1010-40c5-88b8-32bf4c01dce3','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','7d14a4fb-8739-45d2-a981-26fcbe9d7877',4,3,1,'2026-01-24 18:15:28','2026-01-24 18:15:28',NULL),
('93883a6c-c68f-4e08-b3f5-46b79fba3518','30548357-bb60-11f0-8be0-d0008dc32c8f','82d04c26-ba0c-4e62-9f79-eb0f980024e5',1,1,1,'2026-01-24 15:06:24','2026-01-24 15:06:24',NULL),
('96bb04d6-8a49-40f6-90be-ca1ecb8c6f12','6d4ce003-c233-11f0-97b8-7f5632f63d4c','47bcdeda-afef-42bf-8b6b-780f29e15d6f',6,5,1,'2026-05-16 00:22:27','2026-05-16 00:22:27',NULL),
('98308793-3fc2-46cd-94d0-306ce003ca1f','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','269fd7de-c53b-45e4-9b8c-3d94b2b1ba21',2,4,1,'2026-01-24 15:41:03','2026-01-24 15:41:03',NULL),
('9844787f-fcfe-4638-a5ed-38be1f257ae5','30548357-bb60-11f0-8be0-d0008dc32c8f','82d04c26-ba0c-4e62-9f79-eb0f980024e5',5,8,1,'2026-01-24 15:28:23','2026-01-24 15:28:23',NULL),
('9c860efe-fac7-43e5-a4fb-f9bd9b9dbf07','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','269fd7de-c53b-45e4-9b8c-3d94b2b1ba21',4,8,1,'2026-01-24 18:15:35','2026-01-24 18:15:35',NULL),
('9e9149ec-a32d-4f13-9b26-1e2037a608a2','30548357-bb60-11f0-8be0-d0008dc32c8f','269fd7de-c53b-45e4-9b8c-3d94b2b1ba21',5,5,1,'2026-01-24 15:28:17','2026-01-24 15:28:17',NULL),
('a00fa4ff-10a3-4580-9f2b-565f7a7c1d70','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','7d14a4fb-8739-45d2-a981-26fcbe9d7877',2,9,1,'2026-01-24 15:41:17','2026-01-24 15:41:17',NULL),
('a0cad70a-1cb2-4737-ab4f-c06982ac6ffa','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','ccf7b1c3-d440-4452-b78a-dbdf49ca8e57',6,7,1,'2026-01-24 15:53:47','2026-01-24 15:53:47',NULL),
('a519dccd-508f-45d3-bea3-97372c1912df','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','ccf7b1c3-d440-4452-b78a-dbdf49ca8e57',3,2,1,'2026-01-24 15:41:25','2026-01-24 15:41:25',NULL),
('a8b3e871-b983-4a90-a54c-ea6c79f088be','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','7da73b69-f93b-11f0-8ce0-93ce4d178a72',1,3,1,'2026-01-24 15:40:43','2026-01-24 15:40:43',NULL),
('a975d53d-7588-4dab-934f-d58e339efe81','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','269fd7de-c53b-45e4-9b8c-3d94b2b1ba21',5,2,1,'2026-01-24 17:17:51','2026-01-24 17:17:51',NULL),
('aada17a1-6961-49ef-b93d-2451eb3a8462','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','7da73b69-f93b-11f0-8ce0-93ce4d178a72',2,1,1,'2026-01-24 15:40:59','2026-01-24 15:40:59',NULL),
('abb68281-fd97-4bee-b666-b80276b2a3cf','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','47bcdeda-afef-42bf-8b6b-780f29e15d6f',6,4,1,'2026-01-24 15:53:42','2026-01-24 15:53:42',NULL),
('ad4b352b-37a8-4044-9ae5-c947c56a6e4b','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','47bcdeda-afef-42bf-8b6b-780f29e15d6f',2,7,1,'2026-01-24 15:41:12','2026-01-24 15:41:12',NULL),
('ae4296c9-b5bb-4172-b43a-c061b92c0101','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','82d04c26-ba0c-4e62-9f79-eb0f980024e5',6,3,1,'2026-01-24 15:53:40','2026-01-24 15:53:40',NULL),
('b12f4979-061d-4f14-b790-aa67e9bc0e21','30548357-bb60-11f0-8be0-d0008dc32c8f','ccf7b1c3-d440-4452-b78a-dbdf49ca8e57',2,9,1,'2026-01-24 15:16:50','2026-01-24 15:16:50',NULL),
('b18886cb-bc67-4c65-b073-c107c85b8c2b','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','8cca993f-6a1c-4a75-b92c-bc280f001deb',1,6,1,'2026-01-24 15:40:48','2026-01-24 15:40:48',NULL),
('b2c9069b-648d-4a36-8323-a0f2e0a51aec','30548357-bb60-11f0-8be0-d0008dc32c8f','82d04c26-ba0c-4e62-9f79-eb0f980024e5',2,6,1,'2026-01-24 15:16:45','2026-01-24 15:16:45',NULL),
('b74c6e4a-4688-4144-93ef-955e6c78a801','30548357-bb60-11f0-8be0-d0008dc32c8f','e8725c90-e3f0-4f54-8b5f-83214fedabbc',5,7,1,'2026-01-24 15:28:21','2026-01-24 15:28:21',NULL),
('b80ae762-42b7-44eb-8bd4-3dbdefef8e51','30548357-bb60-11f0-8be0-d0008dc32c8f','269fd7de-c53b-45e4-9b8c-3d94b2b1ba21',3,4,1,'2026-01-24 15:26:49','2026-01-24 15:26:49',NULL),
('bc74be1e-bef6-4dbe-a3c9-687fcc6694df','30548357-bb60-11f0-8be0-d0008dc32c8f','47bcdeda-afef-42bf-8b6b-780f29e15d6f',2,4,1,'2026-01-24 15:16:41','2026-01-24 15:16:41',NULL),
('c34ad355-9cde-4bc5-8821-e359bc6bc665','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','269fd7de-c53b-45e4-9b8c-3d94b2b1ba21',5,1,1,'2026-01-24 17:17:49','2026-01-24 17:17:49',NULL),
('c3aeaeee-6cc4-491c-acec-adab65d22815','30548357-bb60-11f0-8be0-d0008dc32c8f','7d14a4fb-8739-45d2-a981-26fcbe9d7877',5,2,1,'2026-01-24 15:28:11','2026-01-24 15:28:11',NULL),
('c6c9d22d-5a6c-4643-9797-b442d561be70','30548357-bb60-11f0-8be0-d0008dc32c8f','e8725c90-e3f0-4f54-8b5f-83214fedabbc',4,2,1,'2026-01-24 15:27:32','2026-01-24 15:27:32',NULL),
('c8b22a5a-5e96-48e7-8d86-fc70d0085fa8','30548357-bb60-11f0-8be0-d0008dc32c8f','82d04c26-ba0c-4e62-9f79-eb0f980024e5',1,9,1,'2026-01-24 15:09:21','2026-01-24 15:09:21',NULL),
('cfaf4f45-3cc6-4268-98a5-4ec7dce82a1c','30548357-bb60-11f0-8be0-d0008dc32c8f','82d04c26-ba0c-4e62-9f79-eb0f980024e5',2,2,1,'2026-04-20 17:35:58','2026-04-20 17:35:58',NULL),
('d4c01d7b-eb19-47a3-b425-034d8cdf3464','30548357-bb60-11f0-8be0-d0008dc32c8f','269fd7de-c53b-45e4-9b8c-3d94b2b1ba21',4,7,1,'2026-01-24 15:27:43','2026-01-24 15:27:43',NULL),
('d7561317-61e0-446d-bc74-334dad0924c0','30548357-bb60-11f0-8be0-d0008dc32c8f','82d04c26-ba0c-4e62-9f79-eb0f980024e5',0,1,1,'2026-05-03 11:30:33','2026-05-03 11:30:33',NULL),
('d95052b0-5772-46b1-877d-ecb0d0d025ce','30548357-bb60-11f0-8be0-d0008dc32c8f','47bcdeda-afef-42bf-8b6b-780f29e15d6f',4,9,1,'2026-01-24 15:27:46','2026-01-24 15:27:46',NULL),
('da1d733c-a7a1-4be2-b9c0-d6263d8442ea','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','e8725c90-e3f0-4f54-8b5f-83214fedabbc',2,2,1,'2026-01-24 15:41:00','2026-01-24 15:41:00',NULL),
('e0b2eccb-f53c-4d19-8b52-4f7773fb96ad','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','82d04c26-ba0c-4e62-9f79-eb0f980024e5',1,2,1,'2026-01-24 15:40:41','2026-01-24 15:40:41',NULL),
('e11fd4bc-7146-43a3-bf84-bf6aec188c4b','30548357-bb60-11f0-8be0-d0008dc32c8f','ccf7b1c3-d440-4452-b78a-dbdf49ca8e57',1,6,1,'2026-01-24 15:09:18','2026-01-24 15:09:18',NULL),
('e2d732c4-695d-487c-b443-1d4f50fb158d','30548357-bb60-11f0-8be0-d0008dc32c8f','ccf7b1c3-d440-4452-b78a-dbdf49ca8e57',3,5,1,'2026-01-24 15:26:53','2026-01-24 15:26:53',NULL),
('e30a8d8f-f357-426f-87b7-bdaba127a330','30548357-bb60-11f0-8be0-d0008dc32c8f','82d04c26-ba0c-4e62-9f79-eb0f980024e5',5,9,1,'2026-01-24 15:28:24','2026-01-24 15:28:24',NULL),
('e48df2df-5c87-477f-b984-ab1e21d5ca8b','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','ccf7b1c3-d440-4452-b78a-dbdf49ca8e57',3,6,1,'2026-01-24 15:45:44','2026-01-24 15:45:44',NULL),
('e504dae1-7bbd-4be8-a751-58b4e83870c7','30548357-bb60-11f0-8be0-d0008dc32c8f','47bcdeda-afef-42bf-8b6b-780f29e15d6f',4,8,1,'2026-01-24 15:27:45','2026-01-24 15:27:45',NULL),
('e8428849-5484-4383-a808-4a0aadbf4d4f','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','ccf7b1c3-d440-4452-b78a-dbdf49ca8e57',3,1,1,'2026-01-24 15:41:23','2026-01-24 15:41:23',NULL),
('eb00d42c-1b7f-4ab9-a54b-f911138fd2bf','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','8cca993f-6a1c-4a75-b92c-bc280f001deb',1,5,1,'2026-01-24 15:40:47','2026-01-24 15:40:47',NULL),
('eb3e0ce0-1084-41d0-8925-abf16a4696a9','30548357-bb60-11f0-8be0-d0008dc32c8f','269fd7de-c53b-45e4-9b8c-3d94b2b1ba21',1,7,1,'2026-01-24 15:09:19','2026-01-24 15:09:19',NULL),
('edee63dc-e0d6-4753-b43d-c6b3ca78e650','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','82d04c26-ba0c-4e62-9f79-eb0f980024e5',2,5,1,'2026-01-24 15:41:08','2026-01-24 15:41:08',NULL),
('ee196ed0-cdd5-4c48-a186-9102ce22564a','30548357-bb60-11f0-8be0-d0008dc32c8f','8cca993f-6a1c-4a75-b92c-bc280f001deb',4,5,1,'2026-01-24 15:27:39','2026-01-24 15:27:39',NULL),
('ef41fdc0-78c5-412d-831e-e4e8bfd50ce6','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','12cacf7b-c4a0-43b0-989d-748baf2ddf83',1,8,1,'2026-01-24 15:40:53','2026-01-24 15:40:53',NULL),
('f34856d3-3c02-41cb-9190-cc80a66cebb5','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','ccf7b1c3-d440-4452-b78a-dbdf49ca8e57',3,7,1,'2026-01-24 15:45:46','2026-01-24 15:45:46',NULL),
('f3c5c2f9-36be-4bad-8f87-3ac0af6cedfa','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','e8725c90-e3f0-4f54-8b5f-83214fedabbc',4,1,1,'2026-01-24 18:15:24','2026-01-24 18:15:24',NULL),
('f7f312e7-cac5-4cfd-ba8b-774beeec13c2','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','8cca993f-6a1c-4a75-b92c-bc280f001deb',6,9,1,'2026-01-24 15:53:51','2026-01-24 15:53:51',NULL),
('f93934f9-8870-4cb5-a29c-6253fb6cfa51','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','269fd7de-c53b-45e4-9b8c-3d94b2b1ba21',6,1,1,'2026-01-24 15:53:38','2026-01-24 15:53:38',NULL),
('fb15591d-d19e-4305-859d-b17fe8973b94','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','82d04c26-ba0c-4e62-9f79-eb0f980024e5',2,3,1,'2026-01-24 15:41:02','2026-01-24 15:41:02',NULL),
('fb8223b7-e889-4954-b175-5b2aff0c93a2','30548357-bb60-11f0-8be0-d0008dc32c8f','47bcdeda-afef-42bf-8b6b-780f29e15d6f',2,3,1,'2026-04-20 17:36:51','2026-04-20 17:36:51',NULL),
('fb97f1d6-e1c9-4c74-b28e-aa9ca0e6398c','30548357-bb60-11f0-8be0-d0008dc32c8f','82d04c26-ba0c-4e62-9f79-eb0f980024e5',6,2,1,'2026-01-28 15:39:18','2026-01-28 15:39:18',NULL),
('fd4cdcfe-6374-4bbb-92a2-67fbc32b2019','30548357-bb60-11f0-8be0-d0008dc32c8f','12cacf7b-c4a0-43b0-989d-748baf2ddf83',5,3,1,'2026-01-24 15:28:12','2026-01-24 15:28:12',NULL),
('fdc95c61-794b-436f-9ba4-cec719d56302','30548357-bb60-11f0-8be0-d0008dc32c8f','269fd7de-c53b-45e4-9b8c-3d94b2b1ba21',3,3,1,'2026-01-24 15:26:46','2026-01-24 15:26:46',NULL),
('fe80bd25-5d14-4f56-aa8d-3c49f7146c06','30548357-bb60-11f0-8be0-d0008dc32c8f','e8725c90-e3f0-4f54-8b5f-83214fedabbc',6,4,1,'2026-01-31 15:58:47','2026-01-31 15:58:47',NULL);
/*!40000 ALTER TABLE `course_schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_teachers`
--

DROP TABLE IF EXISTS `course_teachers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_teachers` (
  `course_id` varchar(36) NOT NULL,
  `class_id` varchar(36) NOT NULL,
  `teacher_id` varchar(36) NOT NULL,
  PRIMARY KEY (`course_id`,`class_id`),
  KEY `course_id` (`course_id`),
  KEY `class_id` (`class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_teachers`
--

LOCK TABLES `course_teachers` WRITE;
/*!40000 ALTER TABLE `course_teachers` DISABLE KEYS */;
INSERT INTO `course_teachers` VALUES
('12cacf7b-c4a0-43b0-989d-748baf2ddf83','30548357-bb60-11f0-8be0-d0008dc32c8f','9310f36c-bcb1-11f0-8ff6-9efd1c949119'),
('12cacf7b-c4a0-43b0-989d-748baf2ddf83','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','9310f36c-bcb1-11f0-8ff6-9efd1c949119'),
('269fd7de-c53b-45e4-9b8c-3d94b2b1ba21','30548357-bb60-11f0-8be0-d0008dc32c8f','9310ee0e-bcb1-11f0-8ff6-9efd1c949119'),
('269fd7de-c53b-45e4-9b8c-3d94b2b1ba21','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','9310ee0e-bcb1-11f0-8ff6-9efd1c949119'),
('269fd7de-c53b-45e4-9b8c-3d94b2b1ba21','6684dbce-bb60-11f0-8be0-d0008dc32c8f','9a779851-8f0e-4f35-9ea0-8a46f06c2848'),
('47bcdeda-afef-42bf-8b6b-780f29e15d6f','30548357-bb60-11f0-8be0-d0008dc32c8f','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4'),
('47bcdeda-afef-42bf-8b6b-780f29e15d6f','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','9310ee0e-bcb1-11f0-8ff6-9efd1c949119'),
('47bcdeda-afef-42bf-8b6b-780f29e15d6f','6d4ce003-c233-11f0-97b8-7f5632f63d4c','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4'),
('7d14a4fb-8739-45d2-a981-26fcbe9d7877','30548357-bb60-11f0-8be0-d0008dc32c8f','3ef85676-bcb2-11f0-8ff6-9efd1c949119'),
('7d14a4fb-8739-45d2-a981-26fcbe9d7877','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','9310f2a9-bcb1-11f0-8ff6-9efd1c949119'),
('7da73b69-f93b-11f0-8ce0-93ce4d178a72','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','9a779851-8f0e-4f35-9ea0-8a46f06c2848'),
('82d04c26-ba0c-4e62-9f79-eb0f980024e5','30548357-bb60-11f0-8be0-d0008dc32c8f','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4'),
('82d04c26-ba0c-4e62-9f79-eb0f980024e5','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4'),
('82d04c26-ba0c-4e62-9f79-eb0f980024e5','6d4ce003-c233-11f0-97b8-7f5632f63d4c','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4'),
('8cca993f-6a1c-4a75-b92c-bc280f001deb','30548357-bb60-11f0-8be0-d0008dc32c8f','9310ee0e-bcb1-11f0-8ff6-9efd1c949119'),
('8cca993f-6a1c-4a75-b92c-bc280f001deb','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','369e38d2-fb66-4f00-8e6b-2967c8db4aba'),
('ccf7b1c3-d440-4452-b78a-dbdf49ca8e57','30548357-bb60-11f0-8be0-d0008dc32c8f','54da51f0-e8e4-4a59-ba18-44191322c965'),
('ccf7b1c3-d440-4452-b78a-dbdf49ca8e57','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','369e38d2-fb66-4f00-8e6b-2967c8db4aba'),
('e8725c90-e3f0-4f54-8b5f-83214fedabbc','30548357-bb60-11f0-8be0-d0008dc32c8f','9310f2a9-bcb1-11f0-8ff6-9efd1c949119'),
('e8725c90-e3f0-4f54-8b5f-83214fedabbc','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','9310f36c-bcb1-11f0-8ff6-9efd1c949119'),
('e8725c90-e3f0-4f54-8b5f-83214fedabbc','6684dbce-bb60-11f0-8be0-d0008dc32c8f','369e38d2-fb66-4f00-8e6b-2967c8db4aba');
/*!40000 ALTER TABLE `course_teachers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_topics`
--

DROP TABLE IF EXISTS `course_topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_topics` (
  `id` varchar(36) NOT NULL,
  `teacher_id` varchar(36) NOT NULL,
  `course_id` varchar(36) NOT NULL,
  `year_id` varchar(36) NOT NULL,
  `level` int(11) NOT NULL,
  `text` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_topics`
--

LOCK TABLES `course_topics` WRITE;
/*!40000 ALTER TABLE `course_topics` DISABLE KEYS */;
INSERT INTO `course_topics` VALUES
('09f547c4-1987-11f1-8ba8-61d509ac4659','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','82d04c26-ba0c-4e62-9f79-eb0f980024e5','c02187d2-bfd2-11f0-8d7c-cdee4485d186',7,'Topik ke 1','2026-03-06 18:05:20','2026-03-06 18:05:20',NULL),
('13c71b90-a619-4cd1-b79c-4d759351624a','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','82d04c26-ba0c-4e62-9f79-eb0f980024e5','c02187d2-bfd2-11f0-8d7c-cdee4485d186',7,'XXX','2026-06-14 03:01:18','2026-06-14 03:01:18',NULL),
('15fb7e6e-1987-11f1-8ba8-61d509ac4659','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','82d04c26-ba0c-4e62-9f79-eb0f980024e5','c02187d2-bfd2-11f0-8d7c-cdee4485d186',7,'Topik ke 2','2026-03-06 18:05:20','2026-03-06 18:05:20',NULL),
('182b2eec-ddb6-4251-88d8-9601edbd0483','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','82d04c26-ba0c-4e62-9f79-eb0f980024e5','c02187d2-bfd2-11f0-8d7c-cdee4485d186',7,'POPO','2026-06-15 22:32:09','2026-06-15 22:32:09',NULL),
('1cc42195-1987-11f1-8ba8-61d509ac4659','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','82d04c26-ba0c-4e62-9f79-eb0f980024e5','c02187d2-bfd2-11f0-8d7c-cdee4485d186',7,'Topik ke 3','2026-03-06 18:05:20','2026-03-06 18:05:20',NULL),
('38c8727a-3b0c-4fbf-afee-0a5074f8049c','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','47bcdeda-afef-42bf-8b6b-780f29e15d6f','c02187d2-bfd2-11f0-8d7c-cdee4485d186',8,'Kenapa aja','2026-05-16 01:27:35','2026-05-16 01:27:35',NULL),
('644aa305-7c86-4013-a370-b89ff8bddae7','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','82d04c26-ba0c-4e62-9f79-eb0f980024e5','c02187d2-bfd2-11f0-8d7c-cdee4485d186',7,'ZZZ','2026-06-14 14:40:18','2026-06-14 14:40:18',NULL),
('70c6aa4b-f794-43c7-a040-88d8f1dbd2f1','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','47bcdeda-afef-42bf-8b6b-780f29e15d6f','c02187d2-bfd2-11f0-8d7c-cdee4485d186',7,'asa','2026-04-20 16:25:57','2026-04-20 16:25:57',NULL),
('86724d36-a613-4090-9ff7-fb5788bdab94','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','47bcdeda-afef-42bf-8b6b-780f29e15d6f','c02187d2-bfd2-11f0-8d7c-cdee4485d186',7,'Kokombar 2','2026-05-16 01:09:50','2026-05-16 01:09:50',NULL),
('960648e7-3c3a-4f56-a383-f3e6b83b9fc4','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','47bcdeda-afef-42bf-8b6b-780f29e15d6f','c02187d2-bfd2-11f0-8d7c-cdee4485d186',7,'sdf','2026-05-16 01:07:01','2026-05-16 01:07:01',NULL),
('f12bd612-f9ed-493a-8354-7769708c4332','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','82d04c26-ba0c-4e62-9f79-eb0f980024e5','c02187d2-bfd2-11f0-8d7c-cdee4485d186',8,'tpik ismail','2026-05-03 16:27:10','2026-05-03 16:27:10',NULL),
('f8b357cd-a6c0-4090-8ba1-0ae9cbcba9ff','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','82d04c26-ba0c-4e62-9f79-eb0f980024e5','c02187d2-bfd2-11f0-8d7c-cdee4485d186',7,'Topki ke 4asd','2026-03-13 21:28:16','2026-03-13 21:28:16',NULL);
/*!40000 ALTER TABLE `course_topics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses` (
  `id` varchar(36) NOT NULL,
  `school_id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES
('12cacf7b-c4a0-43b0-989d-748baf2ddf83','582e4596-bb5b-11f0-8be0-d0008dc32c8f','Matematika','','2026-01-21 22:51:44','2026-01-21 22:51:44',NULL),
('269fd7de-c53b-45e4-9b8c-3d94b2b1ba21','582e4596-bb5b-11f0-8be0-d0008dc32c8f','IPA','','2026-01-21 22:51:57','2026-01-21 22:51:57',NULL),
('47bcdeda-afef-42bf-8b6b-780f29e15d6f','582e4596-bb5b-11f0-8be0-d0008dc32c8f','Bahasa Inggris','','2026-01-21 22:51:39','2026-01-21 22:51:39',NULL),
('7d14a4fb-8739-45d2-a981-26fcbe9d7877','582e4596-bb5b-11f0-8be0-d0008dc32c8f','Sejarah Islam','','2026-01-21 22:52:27','2026-01-21 22:52:27',NULL),
('7da73b69-f93b-11f0-8ce0-93ce4d178a72','','Tahfidz',NULL,'2026-01-24 15:43:55','2026-01-24 15:43:55',NULL),
('82d04c26-ba0c-4e62-9f79-eb0f980024e5','582e4596-bb5b-11f0-8be0-d0008dc32c8f','Bahasa Indonesia','','2026-01-21 22:51:30','2026-01-21 22:51:30',NULL),
('8cca993f-6a1c-4a75-b92c-bc280f001deb','582e4596-bb5b-11f0-8be0-d0008dc32c8f','Sosiologi','','2026-01-21 22:56:41','2026-01-21 22:56:41',NULL),
('ccf7b1c3-d440-4452-b78a-dbdf49ca8e57','582e4596-bb5b-11f0-8be0-d0008dc32c8f','Kewarganegaraan','','2026-01-21 22:57:16','2026-01-21 22:57:16',NULL),
('e8725c90-e3f0-4f54-8b5f-83214fedabbc','582e4596-bb5b-11f0-8be0-d0008dc32c8f','IPS','','2026-01-21 22:52:00','2026-01-21 22:52:00',NULL);
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delegates`
--

DROP TABLE IF EXISTS `delegates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `delegates` (
  `id` varchar(36) NOT NULL,
  `subject_id` varchar(36) NOT NULL,
  `object_id` varchar(36) NOT NULL,
  `reason` mediumtext NOT NULL,
  `halaqoh_id` varchar(36) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delegates`
--

LOCK TABLES `delegates` WRITE;
/*!40000 ALTER TABLE `delegates` DISABLE KEYS */;
INSERT INTO `delegates` VALUES
('146ee0fa-9984-4d50-b1ea-5cf9194d79ae','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','369e38d2-fb66-4f00-8e6b-2967c8db4aba','yuyu','79711f34-ae89-4dfe-9cc3-f4462e902c0b','2026-07-04 14:10:41','2026-07-04 14:10:41',NULL);
/*!40000 ALTER TABLE `delegates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donation_payments`
--

DROP TABLE IF EXISTS `donation_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `donation_payments` (
  `id` varchar(36) NOT NULL,
  `donation_id` varchar(36) NOT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `amount` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `prayer` text NOT NULL,
  `status` enum('Pending','Paid','Failed') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donation_payments`
--

LOCK TABLES `donation_payments` WRITE;
/*!40000 ALTER TABLE `donation_payments` DISABLE KEYS */;
INSERT INTO `donation_payments` VALUES
('09e84a41-d5ec-43bf-8ce2-15b1aa86e784','fe9ee1f6-6bea-4505-b658-77cf8ee62138','5b81ce5e-cce5-11f0-8f97-aa3b281802c1',25000,'2026-05-12 00:33:47','as','Paid','2026-05-12 00:33:47','2026-05-12 00:33:47',NULL),
('1ae23548-6e7e-41ee-9090-af21983772dc','cae2d68a-9027-4590-b787-e02ffcc9853b','5b81ce5e-cce5-11f0-8f97-aa3b281802c1',25000,'2026-02-03 23:55:55','','Paid','2026-02-03 23:55:55','2026-02-03 23:55:55',NULL),
('43ec079a-d3ba-45ac-995f-22c9de33a1d8','df7dbe34-5cbf-4d1d-a3f7-f5a607865fa3',NULL,10000,'2026-02-07 23:43:21','Semoga berkah dunia dan akhirat','Paid','2026-02-07 23:43:21','2026-02-07 23:43:21',NULL),
('4d9101be-99cb-4118-b86e-45d5be525a61','df7dbe34-5cbf-4d1d-a3f7-f5a607865fa3','5b81ce5e-cce5-11f0-8f97-aa3b281802c1',500000,'2026-02-03 15:25:50','Saya turut prihatin. Semoga donasinya banyak terkumpul','Paid','2026-02-03 15:25:50','2026-02-03 15:25:50',NULL),
('5eb37980-1483-4121-aa3e-e8b490a0c181','cae2d68a-9027-4590-b787-e02ffcc9853b','5b81ce5e-cce5-11f0-8f97-aa3b281802c1',100000,'2026-02-03 23:54:27','','Paid','2026-02-03 23:54:27','2026-02-03 23:54:27',NULL),
('87b958c4-fc5a-4238-893c-ddec59a9603c','cae2d68a-9027-4590-b787-e02ffcc9853b','5b81ce5e-cce5-11f0-8f97-aa3b281802c1',50000,'2026-02-03 23:24:06','','Paid','2026-02-03 23:24:06','2026-02-03 23:24:06',NULL),
('8bd14f89-00f8-11f1-8d2c-b67b46eed86e','fe9ee1f6-6bea-4505-b658-77cf8ee62138',NULL,250000,'2026-02-03 12:04:52','','Paid','2026-02-03 12:04:52','2026-02-03 12:04:52',NULL),
('8f0f9c55-61dc-43a1-b58e-1dfbc8338e4c','cae2d68a-9027-4590-b787-e02ffcc9853b','7296ff26-bca0-11f0-8ff6-9efd1c949119',25000,'2026-05-03 13:00:20','Amin','Paid','2026-05-03 13:00:20','2026-05-03 13:00:20',NULL),
('a27febd5-1bdc-4c8c-bd95-0ca48815a0d6','cae2d68a-9027-4590-b787-e02ffcc9853b','5b81ce5e-cce5-11f0-8f97-aa3b281802c1',1000000,'2026-02-07 14:31:52','','Paid','2026-02-07 14:31:52','2026-02-07 14:31:52',NULL),
('b459f327-47de-43b2-8e6c-07b9a717c011','df7dbe34-5cbf-4d1d-a3f7-f5a607865fa3','5b81ce5e-cce5-11f0-8f97-aa3b281802c1',100000,'2026-02-03 23:56:43','Semoga donasi segera terkumpul','Paid','2026-02-03 23:56:43','2026-02-03 23:56:43',NULL),
('ca6d6dde-5b4f-449c-9e0d-60c5ecfa9b82','cae2d68a-9027-4590-b787-e02ffcc9853b','5b81ce5e-cce5-11f0-8f97-aa3b281802c1',25000,'2026-02-07 14:32:20','Semoga donasi segera terkumpul','Paid','2026-02-07 14:32:20','2026-02-07 14:32:20',NULL),
('df844708-c277-43a6-aceb-6e5aff8f268b','ff1d04fd-0dc0-4c3c-a9ec-25c2b57908f2',NULL,1000000,'2026-02-03 15:23:42','Saya keren kan','Paid','2026-02-03 15:23:42','2026-02-03 15:23:42',NULL),
('e9f331cf-86d5-4c4c-a89e-c5ba4d35a657','ff1d04fd-0dc0-4c3c-a9ec-25c2b57908f2','5b81ce5e-cce5-11f0-8f97-aa3b281802c1',50000,'2026-02-03 15:16:13','Aduh kasihan sekali ya...','Paid','2026-02-03 15:16:13','2026-02-03 15:16:13',NULL),
('f393aef3-00f6-11f1-8d2c-b67b46eed86e','ff1d04fd-0dc0-4c3c-a9ec-25c2b57908f2','5b81ce5e-cce5-11f0-8f97-aa3b281802c1',200000,'2026-02-03 11:53:27','Semoga lancar','Paid','2026-02-03 11:53:27','2026-02-03 11:53:27',NULL);
/*!40000 ALTER TABLE `donation_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donations`
--

DROP TABLE IF EXISTS `donations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `donations` (
  `id` varchar(36) NOT NULL,
  `school_id` varchar(36) DEFAULT NULL,
  `kind` enum('Donasi','Wakaf','Infaq') NOT NULL,
  `title` text NOT NULL,
  `description` text NOT NULL,
  `target_amount` int(11) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donations`
--

LOCK TABLES `donations` WRITE;
/*!40000 ALTER TABLE `donations` DISABLE KEYS */;
INSERT INTO `donations` VALUES
('3a06d9f6-2fc6-40c8-bab5-ce78fffdbb9d','582e4596-bb5b-11f0-8be0-d0008dc32c8f','Wakaf','Tutu Aja','WK',45000000,NULL,NULL,1,'2026-02-03 12:13:46','2026-02-03 12:13:46',NULL),
('cae2d68a-9027-4590-b787-e02ffcc9853b',NULL,'Donasi','Donasi Untuk Semua','Semuanya bisa',NULL,NULL,NULL,1,'2026-02-03 23:21:24','2026-02-03 23:21:24',NULL),
('df7dbe34-5cbf-4d1d-a3f7-f5a607865fa3','582e4596-bb5b-11f0-8be0-d0008dc32c8f','Donasi','Donasi Banjir Sumatera','Bencana demi bencana kembali menguji negeri ini.\nDari longsor hingga banjir bandang, dari erupsi gunung hingga kerusakan yang menyapu pemukiman, semuanya meninggalkan kepedihan yang tak mudah terobati.\n\nDi tengah situasi yang menggetarkan hati ini, HIMALS4 hadir untuk menunjukkan kepedulian.\n\nMelalui bantuan yang kita ulurkan, mereka tidak lagi merasa sendiri menghadapi kesulitan. Setiap kebaikan, doa, dan setiap perhatian yang kita berikan dapat menjadi cahaya di tengah kegelapan yang mereka hadapi.\n\nKini saatnya kita bergerak bersama—mengulurkan tangan untuk pemulihan, memberikan harapan baru bagi.\n\nTunaikan sedekah terbaikmu untuk bantu mereka yang terdampak bencana sekarang!',NULL,NULL,'2026-02-09',1,'2026-02-03 12:14:56','2026-02-03 12:14:56',NULL),
('fe9ee1f6-6bea-4505-b658-77cf8ee62138','582e4596-bb5b-11f0-8be0-d0008dc32c8f','Infaq','Membuat Masjid','DDD',5000000,NULL,NULL,1,'2026-02-03 12:04:09','2026-02-03 12:04:09',NULL),
('ff1d04fd-0dc0-4c3c-a9ec-25c2b57908f2','582e4596-bb5b-11f0-8be0-d0008dc32c8f','Donasi','Nymbang saya yang lagi bokek ya gais sekali lagi','Pada April 1975, BATAN dan Departemen Pekerjaan Umum membentuk sebuah komisi untuk memulai proses pemilihan lokasi tapak PLTN yang bernama Komisi Persiapan Pembangunan PLTN (KP2PLTN). Komisi tersebut terdiri dari BATAN, Departemen Pekerjaan Umum, Departemen Pertahanan dan Keamanan, Departemen Dalam Negeri, Departemen Pendidikan dan Kebudayaan, dan PLN.[16] Pemilihan tersebut menghasilkan 5 dari 14 lokasi yang diusulkan. Lima lokasi tersebut adalah Tanjung Pujut (Banten), Parigi (Jawa Barat), Lasem (Jawa Tengah), Muria (Jawa Tengah), dan Situbondo (Jawa Timur).[17]\n\nAntara bulan Juli hingga September 1975, diadakan sebuah survei untuk menentukan lokasi tapak terbaik dari kelima lokasi tersebut. Hasilnya berupa dua lokasi, yaitu Keling di Muria dan Sluke di Lasem.[17] Kemudian, BATAN mengadakan studi kelayakan terhadap kedua lokasi tersebut yang dibantu oleh firma teknik nuklir asal Italia, NIRA.[18] Hasil studi tersebut kemudian keluar pada tahun 1982, yang menyimpulkan bahwa Ujungwatu di Keling (kini bagian dari Donorojo) adalah calon lokasi tapak terbaik.[17]\n\nPada tahun 1991, diadakan perjanjian antara Kementerian Keuangan dan BATAN dengan perusahaan konsultasi energi asal Jepang, NEWJEC Inc.[19] Perjanjian ini pada dasarnya mengontrak NEWJEC selama empat tahun setengah untuk melakukan analisis dan evaluasi terhadap lokasi tapak. Lokasi yang sebelumnya hanya Ujungwatu diperbarui menjadi enam lokasi, yaitu Ujungwatu, Ujung Bantungan, Ujung Grenggengan, Ujung Lemahabang, Ujung Bayuran, dan Ujung Piring. Pilihan akhirnya jatuh di Ujung Lemahabang (ULA), sebuah dukuh di Balong, Kecamatan Kembang, Kabupaten Jepara.[20][21][22] Pada 1993, NEWJEC mengeluarkan sebuah laporan yang berjudul Feasibility Study of the First Nuclear Power Plants at Muria Peninsula Region. Laporan ini memproyeksikan penawaran dan permintaan kebutuhan energi nuklir serta menyarankan Pemerintah Indonesia untuk membangun 12 reaktor berkekuatan 600 Megawatt.[18] Pemilihan tapak akhirnya selesai pada bulan Mei 1996,[23] dan rencananya akan mulai dibangun pada tahun 1997, tetapi tertunda karena krisis finansial Asia 1997.[24]',NULL,NULL,NULL,1,'2026-02-02 07:07:57','2026-02-02 07:07:57',NULL);
/*!40000 ALTER TABLE `donations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fcm_tokens`
--

DROP TABLE IF EXISTS `fcm_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fcm_tokens` (
  `user_id` varchar(36) NOT NULL,
  `fcm_token` varchar(512) NOT NULL,
  PRIMARY KEY (`user_id`,`fcm_token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fcm_tokens`
--

LOCK TABLES `fcm_tokens` WRITE;
/*!40000 ALTER TABLE `fcm_tokens` DISABLE KEYS */;
INSERT INTO `fcm_tokens` VALUES
('2211617a-d055-11f0-8de5-e8758f708443','cq9wuwaoT8yIjx2BRJIjYS:APA91bHy5L8PrWjk-xxBK2JNG5_R_3kQmjiqsjYigOeNBFJM2yYOj-KFJmM1a5w_qY9pt_L7nAZohxEsY5eA9AvfjHhF6rbi8Y8HDqbdH1qjpGiSPcWBWyk'),
('5b81ce5e-cce5-11f0-8f97-aa3b281802c1','d89bmCCeBkNUPveUH1cXE7:APA91bEUtZabFI_CMMD0ViWucc8swRY3NRHLSJGJ17z7IghOn1BiYBM8qtfRJuX3e1Cek4y3t7seG--3zMSFbA5am2-TRpOrpGv2w9ehILAN65k7bJcolhY'),
('5b81ce5e-cce5-11f0-8f97-aa3b281802c1','d9uumwxN88VI2omPCbbl1V:APA91bGcSk1C3CiLTr8FG1GEn5yTfVa78P2KV26hKLUaEaK3tAUH1ngAI662tKV_ZhlY36NI2wBEn6dcJ-Bof1ZhddeHWTpUPXL2gSqPnwf_20r3j_jtM2c'),
('5b81ce5e-cce5-11f0-8f97-aa3b281802c1','dfZIWV5L4Goidn0EFNI0sT:APA91bF8Td4UKAMQpnFkLpv_LdLY1l244iFI-3ndoA1phNfRfsTm8fLdPQQ8mgU7KMeYoTtz0Qt-fI3aFu2Gpc4t41Vf4UgDcqjw1za5SjoV_eNMJ2mquOs'),
('5b81ce5e-cce5-11f0-8f97-aa3b281802c1','dLFS6oFiMc5JO5Q9FsMKiW:APA91bElFGWkeG9X2BHFEfHN1DDWTmMM7Von9mPWgJX9ctKs81NMzIpkIwfUPCMth0AW382VZbZBwf1s5mpfBQGFX9qlXWpnuyuGX1TN-5XYUpujPWNL93E'),
('5b81ce5e-cce5-11f0-8f97-aa3b281802c1','dLFS6oFiMc5JO5Q9FsMKiW:APA91bEpsVAPTcWDo13nKUQ2fKpWOu12tDcZayLE6t7M1fP95HNlncrZyXiJQzYRbeBLkORNeyKUwcL7cor9A4oFTVWIvK2vK6oBOXolZkNNahzxf4KG1Bk'),
('5b81ce5e-cce5-11f0-8f97-aa3b281802c1','dLFS6oFiMc5JO5Q9FsMKiW:APA91bEY09JFgYrwt7-EJeHG68sAEx_IvESZxNw7kW0RA8vzgd3I6trYfzSiGerqnQ4gnMrDb2yjuewEXAeV_xQPEVoHrCbV33sodSHpwsCuQiUEtTNP4mQ'),
('5b81ce5e-cce5-11f0-8f97-aa3b281802c1','dLFS6oFiMc5JO5Q9FsMKiW:APA91bEZGhaytcQYZ-Pvb50gGh94NEva-8J_nULp_Alceu9tBvwlIbAyGJVksIfrfNih7-dk2I0h2Aed0lnJAOPjKJ-VU7Zs7unhQkTTC_F4HmAO5IgSy1U'),
('5b81ce5e-cce5-11f0-8f97-aa3b281802c1','dLFS6oFiMc5JO5Q9FsMKiW:APA91bF7ico6nSZ8G-5ZDxNtBVwaltU0yt4Eq0j8lo1gCucmybdmnKe1G91nN04LtmGG_a9ONP_MvBNFcanB1V0rZmIMydkQUNiI1syXTOqyiRiLzWojDtc'),
('5b81ce5e-cce5-11f0-8f97-aa3b281802c1','dLFS6oFiMc5JO5Q9FsMKiW:APA91bFQDO7XZdU7NWC2QEFW8yxpg50lrVq383EcbSs9j2d6uQmSE-Ljgs-gOrWbu7VlwNzFB8KDOfiPvomE3x2GUL2gBhD9JUb-lnAkG25VUrQ_seuP5o4'),
('5b81ce5e-cce5-11f0-8f97-aa3b281802c1','dLFS6oFiMc5JO5Q9FsMKiW:APA91bGMNtgzvoFxHb4quNhioU85A42jouYZRFL5sDRa8e-B6VZwq2Y6Py0OVhIO-tEs-QbJk5qAjNV7TIkOOdBEZTyhao-qD_TyPMYoWmtPIfpSh4NRMck'),
('7296ff26-bca0-11f0-8ff6-9efd1c949119','d-7vHOE-R2Uk8sX9zUZ4ZH:APA91bGP5qN9Bgv0QMGKvViaDlrRahtnrpna1Gnov9N79FqQh1rp0OXkF6z4HAezukkyTAtTTwBLCRdJQL6UUQhWhh_X271p85JYZ0DCBvJwsfNa2s1dm7g'),
('7296ff26-bca0-11f0-8ff6-9efd1c949119','d89bmCCeBkNUPveUH1cXE7:APA91bHGNr9iPBQg7dDUpKAPeKAZmWi_GbnTB-wa5rb2T8MZQm97GLN7LSQFOY8VT4rYDEqe_PTfWmTASHOsew-zbsjgAlhBiQB80sn8xklZBrqSM5SGdWU'),
('7296ff26-bca0-11f0-8ff6-9efd1c949119','dfZIWV5L4Goidn0EFNI0sT:APA91bF_V1eCTMgWc_lQzMF1SsNgRYYjiLnh5I4_Urh5IMoGGA6zE7CD5Bc6novC0E-vb7Qgaopv7ojxgzw7NmvtO-ioW7-5Bco4LUIJpcC8M7qAYN5hHho'),
('7296ff26-bca0-11f0-8ff6-9efd1c949119','dfZIWV5L4Goidn0EFNI0sT:APA91bFFy9ByqcGUOQSPAGsCzliQLIgjbt_KIjP6gdsqrbnLQkh4widCLmVvkvpf_b0tNVVlcYT8HqMoe5Sm2nawVM7vVweHvnNiJUYCDA7aqArOJF33zVY'),
('7296ff26-bca0-11f0-8ff6-9efd1c949119','dfZIWV5L4Goidn0EFNI0sT:APA91bG0yTuYLsFySiBvwIcpl5u_9iHa8fOHv_MMjmzknV4FclyVj_XeIEhT_3CRara-GoB2eYcF-dz_aL2KY9QqHZ_h1EJ6oZ2rSGcMbe_3J8y09VSJ_E8'),
('7296ff26-bca0-11f0-8ff6-9efd1c949119','dfZIWV5L4Goidn0EFNI0sT:APA91bGgTPKDlWmZQ1rNrTNscMQgiHpqNd_03tpV0lKmsb3jThgVMZ0nUGfYjBLmodiebVHzTvkQjO_8we0FldEquLleWRd2SDwMPr0DpP0lGJcOrwAuV68'),
('7296ff26-bca0-11f0-8ff6-9efd1c949119','fKRbEuUmS6OkrXfASy30-R:APA91bF0prOqsKcen3Z_CZ6DX_PFAxqJtIJzXsA6uaruAIqHivUHOM69OD6lpp9kuBl9YqNehevsFfhw0hhKWG0PbNu93EcIYdEs8ys2UqxxU40pAPu2_nU');
/*!40000 ALTER TABLE `fcm_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `galleries`
--

DROP TABLE IF EXISTS `galleries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `galleries` (
  `id` varchar(36) NOT NULL,
  `owner_id` varchar(36) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `galleries`
--

LOCK TABLES `galleries` WRITE;
/*!40000 ALTER TABLE `galleries` DISABLE KEYS */;
INSERT INTO `galleries` VALUES
('06f8121f-d6de-4327-b88a-30f1dc359295','fd239790-b99b-40ac-9674-c5aac3a3ca1d','news_fd12b687-46f7-496b-b1b0-b046b51afdf5.png',NULL),
('13596ae3-7c84-4ba6-8529-1443b270ee53','fe9ee1f6-6bea-4505-b658-77cf8ee62138','dona_e9dc4dd8-7747-47a2-b512-ebd6911e6cf5.jpeg',NULL),
('3c4b1d89-a6ce-4089-8998-f9a573f95ccf','582e4596-bb5b-11f0-8be0-d0008dc32c8f','school_img_4a8b2f7e-ecd5-407f-b991-079cb39269b6.jpeg',NULL),
('41eda008-f6dc-42b3-b34f-6e118ed8de6b','fab1679b-0e9b-4a32-8f5e-ba1d1ba3b688','news_faafeee3-4b9f-4c65-8976-522e505999a1.jpeg',NULL),
('512030c1-365e-4678-98cf-f261a66d68ee','ff1d04fd-0dc0-4c3c-a9ec-25c2b57908f2','dona_6c150cc2-d17f-43e8-8802-dc00f25fb5e1.jpeg',NULL),
('520733b6-68e4-44e9-a7ba-3d81ffeb5f64','6a9ed6fc-5f5a-4a3a-9350-eccdc5332f8c','news_6a1c3914-c306-4330-9c68-c570fabab44d.png',NULL),
('673417f7-ef34-4bb1-901c-e34f4e9f6ceb','7a38cc56-e62d-45a1-b74a-5200c4665edf','news_328828ba-f8cb-4794-a244-3a511dd6c320.jpeg',NULL),
('79512a21-837f-4299-94fb-c11beb2fd374','ff1d04fd-0dc0-4c3c-a9ec-25c2b57908f2','dona_d71f1348-79fd-460e-8f0c-8714efb39247.jpeg',NULL),
('7fcbec23-b317-418d-accd-b07da9c0a7ef','582e4596-bb5b-11f0-8be0-d0008dc32c8f','school_img_a1d184f8-02b3-4448-959f-ad788cd53863.png',NULL),
('8b91e5bd-fc15-4821-b8da-1226385d36e5','001b68e4-2ef9-42a4-b296-b9a893ab2fab','news_e363f3bd-34f3-4f70-8cb6-575d135a284f.jpeg',NULL),
('9a63119d-c852-430d-be48-566a70da2bd8','c5a21979-94f6-4746-8924-e05628e1bd7a','news_3d3d2f77-4e90-4226-bdda-a91c74036f96.jpeg',NULL),
('ba042c08-a98c-427f-944e-e4e1bef4b5a7','0bb34fde-b252-47fc-8a09-1d6dc0001505','news_972b09fd-5490-49bf-b353-5158716f4d7c.jpeg',NULL),
('c7d584e8-792b-416a-a65b-e8406c1e8ff4','3a06d9f6-2fc6-40c8-bab5-ce78fffdbb9d','dona_8a7c2572-947a-4fe3-aa02-36ca4e2b9297.jpeg',NULL),
('ce7b3e4d-7499-4d0f-bac5-f0ee8e1a96ff','df7dbe34-5cbf-4d1d-a3f7-f5a607865fa3','dona_f01b46e8-ca39-49ea-8c4f-d197c82f7e50.jpeg',NULL),
('cf3c52c6-5751-4dd1-b89f-b5f632f8e07d','cae2d68a-9027-4590-b787-e02ffcc9853b','dona_878ae6c1-1b58-4e45-9e57-b0a10ce05805.jpeg',NULL),
('d44f70f6-7bc5-48be-944d-b2522331b535','0ddeef31-8510-4e7b-9141-b9e1698b4e89','teat_c75b4799-da19-4354-9853-c99fdf4e8510.jpeg',NULL),
('e30ba02c-12af-4dbd-b976-2592286e96fd','582e4596-bb5b-11f0-8be0-d0008dc32c8f','school_img_91ac368d-c7b4-417d-afe1-605619e2e6ee.jpeg',NULL),
('e4b94473-ece1-4984-8e09-11bdd362a675','fab1679b-0e9b-4a32-8f5e-ba1d1ba3b688','news_d8f3a874-0749-4d26-95d1-d5ab9fe6ffd9.jpeg',NULL),
('f1e112d9-8ccd-4f9c-950a-511797bfc118','df7dbe34-5cbf-4d1d-a3f7-f5a607865fa3','dona_c54a1c40-b35c-4e40-ad34-a34995ffb5b6.jpeg',NULL),
('f51b3c18-8463-4215-8a76-507d3fa611c5','df7dbe34-5cbf-4d1d-a3f7-f5a607865fa3','dona_c328f708-d07f-43af-939e-b664cffcb532.jpeg',NULL),
('f6e82e77-06b9-43f0-81bb-4df27968622b','bb40b62d-bb40-42e5-98ed-8167665a0273','news_8cad75c1-ca34-44be-97d0-4286c62f8504.jpeg',NULL);
/*!40000 ALTER TABLE `galleries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `halaqoh_students`
--

DROP TABLE IF EXISTS `halaqoh_students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `halaqoh_students` (
  `halaqoh_id` varchar(36) NOT NULL,
  `student_id` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `halaqoh_students`
--

LOCK TABLES `halaqoh_students` WRITE;
/*!40000 ALTER TABLE `halaqoh_students` DISABLE KEYS */;
INSERT INTO `halaqoh_students` VALUES
('13471ea9-4a66-47e4-8043-dc575dd8d716','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119'),
('13471ea9-4a66-47e4-8043-dc575dd8d716','508a76f9-4bad-4fa4-a2a0-b49dbb52e92f'),
('13471ea9-4a66-47e4-8043-dc575dd8d716','cdc43038-bcb3-11f0-8ff6-9efd1c949119'),
('13471ea9-4a66-47e4-8043-dc575dd8d716','bcaf2469-4320-4f0b-a8ee-585a8f9d5747'),
('13471ea9-4a66-47e4-8043-dc575dd8d716','83458f40-9fea-4bb3-8cad-786a5115082b'),
('166044ae-3a65-487c-8af5-8ca6bc5bb24a','9ce766ec-7fab-4fc2-becf-9a03a430ca70'),
('166044ae-3a65-487c-8af5-8ca6bc5bb24a','181eed5e-bc92-11f0-8ff6-9efd1c949119'),
('166044ae-3a65-487c-8af5-8ca6bc5bb24a','b31b930f-74e4-48ca-9b60-b2fe6a5ffc38'),
('79711f34-ae89-4dfe-9cc3-f4462e902c0b','3c60f715-d997-11f0-8cda-5bb67e5632f8'),
('13471ea9-4a66-47e4-8043-dc575dd8d716','598f3241-bc5f-11f0-8b9c-41333d9a4eb4'),
('13471ea9-4a66-47e4-8043-dc575dd8d716','2bea7bf8-e0a0-4381-9fce-e3ebd436ce8a'),
('79711f34-ae89-4dfe-9cc3-f4462e902c0b','25cbd15f-7be5-444a-b3ce-4d365523ad7d'),
('166044ae-3a65-487c-8af5-8ca6bc5bb24a','b149abd8-87a1-404d-b6ca-e639d7d13e36'),
('63494cbb-8bc7-4dde-b72b-6959b56207e2','687360ac-ce0d-4b3e-a035-bb27f7ccfc77');
/*!40000 ALTER TABLE `halaqoh_students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `halaqohs`
--

DROP TABLE IF EXISTS `halaqohs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `halaqohs` (
  `id` varchar(36) NOT NULL,
  `school_id` varchar(36) NOT NULL,
  `year_id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `teacher_id` varchar(36) DEFAULT NULL,
  `teacher2_id` varchar(36) DEFAULT NULL,
  `teacher3_id` varchar(36) DEFAULT NULL,
  `teacher4_id` varchar(36) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `halaqohs`
--

LOCK TABLES `halaqohs` WRITE;
/*!40000 ALTER TABLE `halaqohs` DISABLE KEYS */;
INSERT INTO `halaqohs` VALUES
('13471ea9-4a66-47e4-8043-dc575dd8d716','582e4596-bb5b-11f0-8be0-d0008dc32c8f','c02187d2-bfd2-11f0-8d7c-cdee4485d186','H Satu','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4',NULL,NULL,NULL,'2026-06-28 10:41:31','2026-06-28 10:41:31',NULL),
('166044ae-3a65-487c-8af5-8ca6bc5bb24a','582e4596-bb5b-11f0-8be0-d0008dc32c8f','c02187d2-bfd2-11f0-8d7c-cdee4485d186','H Tiga',NULL,'9310ee0e-bcb1-11f0-8ff6-9efd1c949119',NULL,NULL,'2026-06-29 13:20:05','2026-06-29 13:20:05',NULL),
('63494cbb-8bc7-4dde-b72b-6959b56207e2','0005ed5c-2ef5-e011-9fee-6124ccb9e3de','c02187d2-bfd2-11f0-8d7c-cdee4485d186','1A','46b7836e-3e2e-4330-831e-d078cf7ef838',NULL,NULL,NULL,'2026-07-09 00:58:22','2026-07-09 00:58:22',NULL),
('79711f34-ae89-4dfe-9cc3-f4462e902c0b','582e4596-bb5b-11f0-8be0-d0008dc32c8f','c02187d2-bfd2-11f0-8d7c-cdee4485d186','H Dua','80434d97-77d3-4eb9-8e42-1ccc618e7cdf','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4',NULL,NULL,'2026-06-28 10:52:53','2026-06-28 10:52:53',NULL);
/*!40000 ALTER TABLE `halaqohs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `likes` (
  `id` varchar(36) NOT NULL,
  `owner_id` varchar(36) NOT NULL,
  `user_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES
('0688fd22-7a55-4cc1-afbb-7cccb34c2f12','7a38cc56-e62d-45a1-b74a-5200c4665edf','7296ff26-bca0-11f0-8ff6-9efd1c949119'),
('21cf7948-ef1b-456b-a55e-3ad985df26ec','6a9ed6fc-5f5a-4a3a-9350-eccdc5332f8c','7296ff26-bca0-11f0-8ff6-9efd1c949119'),
('5b4c4e79-72a7-4a1a-a98d-8c3bf569ae81','4d9101be-99cb-4118-b86e-45d5be525a61','5b81ce5e-cce5-11f0-8f97-aa3b281802c1'),
('6cb36933-1d75-4e3b-ae95-afaabd2db7b1','b459f327-47de-43b2-8e6c-07b9a717c011','5b81ce5e-cce5-11f0-8f97-aa3b281802c1'),
('76ef3671-acbe-4abe-bd6c-c5dae152f771','7a38cc56-e62d-45a1-b74a-5200c4665edf','5b81ce5e-cce5-11f0-8f97-aa3b281802c1'),
('776283b7-75c7-43f4-ac51-b63749ae8cd3','ca6d6dde-5b4f-449c-9e0d-60c5ecfa9b82','5b81ce5e-cce5-11f0-8f97-aa3b281802c1'),
('883e8f50-20a4-48d5-99d3-e097c0ef6d67','fd239790-b99b-40ac-9674-c5aac3a3ca1d','5b81ce5e-cce5-11f0-8f97-aa3b281802c1'),
('8dee88b4-3e95-4059-889d-862a24f41438','09e84a41-d5ec-43bf-8ce2-15b1aa86e784','7296ff26-bca0-11f0-8ff6-9efd1c949119'),
('97ecfed5-0cdf-4866-9d4b-5041b76a8684','fab1679b-0e9b-4a32-8f5e-ba1d1ba3b688','5b81ce5e-cce5-11f0-8f97-aa3b281802c1'),
('9f647232-c023-4906-b449-536ab49ad217','bb40b62d-bb40-42e5-98ed-8167665a0273','7296ff26-bca0-11f0-8ff6-9efd1c949119'),
('a11f6ccb-f762-4177-bc94-2831d681a7c7','bb40b62d-bb40-42e5-98ed-8167665a0273','5b81ce5e-cce5-11f0-8f97-aa3b281802c1'),
('c0b79c39-dafc-4aa0-92b9-7eaaeb70f24d','e9f331cf-86d5-4c4c-a89e-c5ba4d35a657','5b81ce5e-cce5-11f0-8f97-aa3b281802c1'),
('cbffba0e-e25b-4979-b5e3-174e7776e3b8','df844708-c277-43a6-aceb-6e5aff8f268b','5b81ce5e-cce5-11f0-8f97-aa3b281802c1'),
('d007d156-305e-43d0-9777-b9213b871be1','6a9ed6fc-5f5a-4a3a-9350-eccdc5332f8c','5b81ce5e-cce5-11f0-8f97-aa3b281802c1'),
('e0a7f3c3-07af-44b4-bcce-2e21b9cc11f2','43ec079a-d3ba-45ac-995f-22c9de33a1d8','5b81ce5e-cce5-11f0-8f97-aa3b281802c1'),
('e2a22ce5-dd7e-47d4-b874-2f41de1915e3','c5a21979-94f6-4746-8924-e05628e1bd7a','5b81ce5e-cce5-11f0-8f97-aa3b281802c1'),
('f09c0590-f3ad-434b-9a5f-15c36cf0e0a5','fab1679b-0e9b-4a32-8f5e-ba1d1ba3b688','7296ff26-bca0-11f0-8ff6-9efd1c949119');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logs` (
  `id` varchar(36) NOT NULL,
  `name` varchar(50) NOT NULL,
  `ref_id` varchar(36) DEFAULT NULL,
  `data` text NOT NULL,
  `level` enum('info','warning','error') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
INSERT INTO `logs` VALUES
('180c97ac-542b-4d17-80e9-4ff8a3ee4df5','midtrans_notification',NULL,'{\"va_numbers\":[{\"va_number\":\"9880103066798800\",\"bank\":\"bni\"}],\"transaction_time\":\"2026-05-12 04:32:21\",\"transaction_status\":\"pending\",\"transaction_id\":\"c9e269e1-789e-4067-8d98-739a8c83bc55\",\"status_message\":\"midtrans payment notification\",\"status_code\":\"201\",\"signature_key\":\"f3005b48f3232ab51691d501fc9574fc2ac1f0b237166ad2dde9972f698b5fc76919456ad921d55a3b45939c7a2cec4393a21be49674f666b2389e187f784134\",\"payment_type\":\"bank_transfer\",\"payment_amounts\":[],\"order_id\":\"THF202605120014\",\"merchant_id\":\"M341601030\",\"gross_amount\":\"374500.00\",\"fraud_status\":\"accept\",\"expiry_time\":\"2026-05-13 04:32:21\",\"customer_details\":{},\"currency\":\"IDR\"}','info','2026-05-11 21:33:26','2026-05-11 21:33:26',NULL),
('19fb156a-eeee-40ef-a7ef-1d8d501ee778','midtrans_cancel',NULL,'{\"transaction_id\":\"THF202605140001\",\"response\":{\"status_code\":\"412\",\"status_message\":\"Transaction status cannot be updated.\",\"id\":\"56f2bfe1-f080-4720-a762-65d28082d480\"}}','error','2026-05-14 17:41:02','2026-05-14 17:41:02',NULL),
('2dab70aa-592f-4d14-9f22-93bbf9323fbe','midtrans_notification',NULL,'{\"va_numbers\":[{\"va_number\":\"010307481207023533\",\"bank\":\"bri\"}],\"transaction_time\":\"2026-05-12 04:59:53\",\"transaction_status\":\"pending\",\"transaction_id\":\"4e78b97e-2e58-460e-8ae8-227a56cf276e\",\"status_message\":\"midtrans payment notification\",\"status_code\":\"201\",\"signature_key\":\"d643e633be15d6853d98dd6aa7812541bc5441d12b88c99cebecd386c1e5bf4f643f38b8d9480824d2f001ffe306120cb61283b019b55c8f0ce907251a4e6b62\",\"payment_type\":\"bank_transfer\",\"payment_amounts\":[],\"order_id\":\"THF202605120015\",\"merchant_id\":\"M341601030\",\"gross_amount\":\"374500.00\",\"fraud_status\":\"accept\",\"expiry_time\":\"2026-05-13 04:59:53\",\"customer_details\":{},\"currency\":\"IDR\"}','info','2026-05-11 21:59:54','2026-05-11 21:59:54',NULL),
('415a07cc-aa33-45c6-8247-094cc19a04c6','midtrans_notification',NULL,'{\"transaction_time\":\"2026-05-12 07:32:54\",\"transaction_status\":\"settlement\",\"transaction_id\":\"49acc816-aa56-4225-b630-f58f63d8031a\",\"status_message\":\"midtrans payment notification\",\"status_code\":\"200\",\"signature_key\":\"609952ebbff8acbd9090eaca005cfdf73304a1d625bb780bf05ff69c1a787e1c7ef7157f9906a4cc355595e1202ffc8db3fc7f93e015ccb2a23fc50acccc6282\",\"shopeepay_reference_number\":\"268049857110856123\",\"settlement_time\":\"2026-05-12 07:32:59\",\"reference_id\":\"A120260512003254roBotP2DjvID-1\",\"payment_type\":\"shopeepay\",\"order_id\":\"THF202605120020\",\"merchant_id\":\"M341601030\",\"gross_amount\":\"77500.00\",\"fraud_status\":\"accept\",\"expiry_time\":\"2026-05-12 07:47:54\",\"customer_details\":{},\"currency\":\"IDR\"}','info','2026-05-12 00:32:59','2026-05-12 00:32:59',NULL),
('42460612-a827-4b6e-a9f9-70508a8831cd','midtrans_notification',NULL,'{\"transaction_time\":\"2026-05-12 07:15:38\",\"transaction_status\":\"pending\",\"transaction_id\":\"78c770b0-4d05-4f9d-b6af-1462961104c1\",\"status_message\":\"midtrans payment notification\",\"status_code\":\"201\",\"signature_key\":\"41e314a844d9e1f2cfc79eb18b7d9950fc9162db9d830cfe1e9013ae62a89f47a66028005a83cdf1c6f99c8ef655cffde3b185703c81ed6a39df4b3d04395489\",\"pop_id\":\"5021c097-e8b0-49c7-af22-67fddefba061\",\"payment_type\":\"gopay\",\"order_id\":\"THF202605120008\",\"merchant_id\":\"M341601030\",\"gross_amount\":\"372000.00\",\"fraud_status\":\"accept\",\"expiry_time\":\"2026-05-12 07:30:38\",\"customer_details\":{},\"currency\":\"IDR\"}','info','2026-05-12 00:15:39','2026-05-12 00:15:39',NULL),
('49d802f2-44e1-45bb-9710-3b1d3cfeebc4','midtrans_notification',NULL,'{\"transaction_time\":\"2026-05-12 07:15:38\",\"transaction_status\":\"expire\",\"transaction_id\":\"78c770b0-4d05-4f9d-b6af-1462961104c1\",\"status_message\":\"midtrans payment notification\",\"status_code\":\"202\",\"signature_key\":\"327bf2bb79b7e921387d285a1d2d56f9778ee3809c096974602559c03a916277ef94110d85639e558efc82485bf4c52a7dd23ff16e153b6c1c5afe5f0af4dbbc\",\"pop_id\":\"5021c097-e8b0-49c7-af22-67fddefba061\",\"payment_type\":\"gopay\",\"order_id\":\"THF202605120008\",\"merchant_id\":\"M341601030\",\"gross_amount\":\"372000.00\",\"fraud_status\":\"accept\",\"expiry_time\":\"2026-05-12 07:30:38\",\"customer_details\":{},\"currency\":\"IDR\"}','info','2026-05-12 00:33:59','2026-05-12 00:33:59',NULL),
('5a1c8048-2a4d-4f40-ac43-f1bf85c3734f','midtrans_notification',NULL,'{\"va_numbers\":[{\"va_number\":\"9880103080877542\",\"bank\":\"bni\"}],\"transaction_time\":\"2026-05-12 05:02:09\",\"transaction_status\":\"settlement\",\"transaction_id\":\"a1eec82e-ec28-420d-af80-4ddf35b52b7a\",\"status_message\":\"midtrans payment notification\",\"status_code\":\"200\",\"signature_key\":\"f66fc041a98987b3fbcf8344ba11507233465c650525e24e36a2e4cdcf14e2b7427b6ffdad096aa1622431eebc1235699c5ebdfcda89b932300865b2b0acbd82\",\"settlement_time\":\"2026-05-12 05:02:27\",\"payment_type\":\"bank_transfer\",\"payment_amounts\":[{\"paid_at\":\"2026-05-12 05:02:27\",\"amount\":\"374500.00\"}],\"order_id\":\"THF202605120016\",\"merchant_id\":\"M341601030\",\"gross_amount\":\"374500.00\",\"fraud_status\":\"accept\",\"expiry_time\":\"2026-05-13 05:02:09\",\"customer_details\":{},\"currency\":\"IDR\"}','info','2026-05-11 22:02:28','2026-05-11 22:02:28',NULL),
('5fceb1fc-763a-467c-b537-6d16b132f279','midtrans_notification',NULL,'{\"va_numbers\":[{\"va_number\":\"01030621634473584\",\"bank\":\"bsi\"}],\"transaction_time\":\"2026-05-12 05:03:08\",\"transaction_status\":\"settlement\",\"transaction_id\":\"b27cbd35-15b9-4dff-abff-5f4b7f1ecfe7\",\"status_message\":\"midtrans payment notification\",\"status_code\":\"200\",\"signature_key\":\"958d20ce16b377ef9d72a853923d82376f29378306ad5d1de48f42e6af020a5cd53d057b2d634f33d9ae497a147c3c9ab4fb64a738df4d6ebae728d920f0d00a\",\"settlement_time\":\"2026-05-12 05:03:22\",\"payment_type\":\"bank_transfer\",\"payment_amounts\":[],\"order_id\":\"THF202605120017\",\"merchant_id\":\"M341601030\",\"gross_amount\":\"374500.00\",\"fraud_status\":\"accept\",\"expiry_time\":\"2026-05-13 05:03:08\",\"customer_details\":{},\"currency\":\"IDR\"}','info','2026-05-11 22:03:23','2026-05-11 22:03:23',NULL),
('64901bf5-e563-4f24-bc00-231fa4fd2826','midtrans_notification',NULL,'{\"transaction_time\":\"2026-05-12 07:33:43\",\"transaction_status\":\"settlement\",\"transaction_id\":\"93db17fa-5497-4f0a-8803-973ba540a186\",\"status_message\":\"midtrans payment notification\",\"status_code\":\"200\",\"signature_key\":\"707ba150db0bd8ad784751fa37b1bd9e67e648e635427a6598f38a8134b0b37c227341824cf4425feb4b2410031c64bbdd483c66413b7174176146aadfb48101\",\"shopeepay_reference_number\":\"229964121326548297\",\"settlement_time\":\"2026-05-12 07:33:46\",\"reference_id\":\"A120260512003343rWnzzD1rrmID-1\",\"payment_type\":\"shopeepay\",\"order_id\":\"THF202605120021\",\"merchant_id\":\"M341601030\",\"gross_amount\":\"77500.00\",\"fraud_status\":\"accept\",\"expiry_time\":\"2026-05-12 07:48:43\",\"customer_details\":{},\"currency\":\"IDR\"}','info','2026-05-12 00:33:47','2026-05-12 00:33:47',NULL),
('679832d4-1376-4d4f-8d48-7ec40e1ccc03','midtrans_cancel',NULL,'{\"transaction_id\":\"THF202605140001\",\"response\":{\"status_code\":\"412\",\"status_message\":\"Transaction status cannot be updated.\",\"id\":\"e7c4c845-8ed6-421a-8cfa-a5de19ead2a3\"}}','error','2026-05-14 17:42:01','2026-05-14 17:42:01',NULL),
('81c187b6-6957-4c46-b88f-2a2c80c1dc22','midtrans_notification',NULL,'{\"va_numbers\":[{\"va_number\":\"010304250831608950\",\"bank\":\"bri\"}],\"transaction_time\":\"2026-05-12 05:14:37\",\"transaction_status\":\"pending\",\"transaction_id\":\"cb785cb6-5e97-45ce-9ef4-ce1bcd2f61cf\",\"status_message\":\"midtrans payment notification\",\"status_code\":\"201\",\"signature_key\":\"7982bd0754d4cb80e4e12ef207e4524d1af7b401cb11523075ed56f9c33c81008701d9af663add0fa94cbc8c68f5297f5fbe5b1fabb60001877e9ac026b61ea7\",\"payment_type\":\"bank_transfer\",\"payment_amounts\":[],\"order_id\":\"THF202605120018\",\"merchant_id\":\"M341601030\",\"gross_amount\":\"124500.00\",\"fraud_status\":\"accept\",\"expiry_time\":\"2026-05-13 05:14:37\",\"customer_details\":{},\"currency\":\"IDR\"}','info','2026-05-11 22:14:39','2026-05-11 22:14:39',NULL),
('9e16a162-c455-496f-b31e-3c1ea3997f2b','midtrans_notification',NULL,'{\"transaction_time\":\"2026-05-12 07:32:54\",\"transaction_status\":\"pending\",\"transaction_id\":\"49acc816-aa56-4225-b630-f58f63d8031a\",\"status_message\":\"midtrans payment notification\",\"status_code\":\"201\",\"signature_key\":\"a3ab58641a844d787733fcd34d98bb401c3f0b71fffad23b4b4a9c61c11b8daea8c9702ecadb78723e612b7a41c3ae6d4647934d058e80ca4bd06cd614e3b901\",\"reference_id\":\"A120260512003254roBotP2DjvID-1\",\"payment_type\":\"shopeepay\",\"order_id\":\"THF202605120020\",\"merchant_id\":\"M341601030\",\"gross_amount\":\"77500.00\",\"fraud_status\":\"accept\",\"expiry_time\":\"2026-05-12 07:47:54\",\"customer_details\":{},\"currency\":\"IDR\"}','info','2026-05-12 00:32:55','2026-05-12 00:32:55',NULL),
('9f80b616-635e-445c-bd0c-a25c239d9eae','midtrans_notification',NULL,'{\"transaction_time\":\"2026-05-12 05:17:09\",\"transaction_status\":\"settlement\",\"transaction_id\":\"2b6b8aba-c737-4cbe-8d31-7d949297f48e\",\"status_message\":\"midtrans payment notification\",\"status_code\":\"200\",\"signature_key\":\"3f93c36e20324c1b5ba19e16c9cad176dfb4484d7c7745d78ab70d6d7c63c52be8868402a38aab50dc94ea987e855f033c91ceddeb6db3375aae9a56920ff309\",\"shopeepay_reference_number\":\"642479779391711767\",\"settlement_time\":\"2026-05-12 05:17:14\",\"reference_id\":\"A120260511221709luxyBZv5XEID-1\",\"payment_type\":\"shopeepay\",\"order_id\":\"THF202605120019\",\"merchant_id\":\"M341601030\",\"gross_amount\":\"2325000.00\",\"fraud_status\":\"accept\",\"expiry_time\":\"2026-05-12 05:32:09\",\"customer_details\":{},\"currency\":\"IDR\"}','info','2026-05-11 22:17:14','2026-05-11 22:17:14',NULL),
('b2627feb-71d4-487f-af4e-6ccd1fb2ccd7','midtrans_notification',NULL,'{\"va_numbers\":[{\"va_number\":\"9880103080877542\",\"bank\":\"bni\"}],\"transaction_time\":\"2026-05-12 05:02:09\",\"transaction_status\":\"pending\",\"transaction_id\":\"a1eec82e-ec28-420d-af80-4ddf35b52b7a\",\"status_message\":\"midtrans payment notification\",\"status_code\":\"201\",\"signature_key\":\"a78e6a89a3e7d7513bf485b47871a235bd923a9734fcb7c3f4cf6392fb4fdd6b982f90d36d34de7edbdc3b4c2a67401f28f2e1e85b921f49e5ce8138bc04394d\",\"payment_type\":\"bank_transfer\",\"payment_amounts\":[],\"order_id\":\"THF202605120016\",\"merchant_id\":\"M341601030\",\"gross_amount\":\"374500.00\",\"fraud_status\":\"accept\",\"expiry_time\":\"2026-05-13 05:02:09\",\"customer_details\":{},\"currency\":\"IDR\"}','info','2026-05-11 22:02:10','2026-05-11 22:02:10',NULL),
('b84b7dc1-8fbf-4915-9cdf-98a987cbf851','midtrans_notification',NULL,'{\"va_numbers\":[{\"va_number\":\"01030621634473584\",\"bank\":\"bsi\"}],\"transaction_time\":\"2026-05-12 05:03:08\",\"transaction_status\":\"pending\",\"transaction_id\":\"b27cbd35-15b9-4dff-abff-5f4b7f1ecfe7\",\"status_message\":\"midtrans payment notification\",\"status_code\":\"201\",\"signature_key\":\"6a7a0877420b4f1049623b3ed66b0afb6a72f162e5ddcd5dfe7d86adbdb33a54276f045210c9d757ef0a7ad43d9aa17728e5fb7954fb3b61a7ec4cb0f5161ac3\",\"payment_type\":\"bank_transfer\",\"payment_amounts\":[],\"order_id\":\"THF202605120017\",\"merchant_id\":\"M341601030\",\"gross_amount\":\"374500.00\",\"fraud_status\":\"accept\",\"expiry_time\":\"2026-05-13 05:03:08\",\"customer_details\":{},\"currency\":\"IDR\"}','info','2026-05-11 22:03:08','2026-05-11 22:03:08',NULL),
('bf97b797-a7c2-45df-9d4c-fdd2a328ac59','midtrans_notification',NULL,'{\"va_numbers\":[{\"va_number\":\"010302743661832184\",\"bank\":\"bri\"}],\"transaction_time\":\"2026-05-12 04:30:58\",\"transaction_status\":\"settlement\",\"transaction_id\":\"9007a896-5b67-416e-be97-38cdc14bcc02\",\"status_message\":\"midtrans payment notification\",\"status_code\":\"200\",\"signature_key\":\"4ce61b3db79562fcda3534b382dffaf725de7640965accb075b682cabc7aacf551035f5c9d3e499e7b1d9c89a8798f1f97d12e89c579a11d1f2beb24749174fa\",\"settlement_time\":\"2026-05-12 04:31:40\",\"payment_type\":\"bank_transfer\",\"payment_amounts\":[],\"order_id\":\"THF202605120013\",\"merchant_id\":\"M341601030\",\"gross_amount\":\"374500.00\",\"fraud_status\":\"accept\",\"expiry_time\":\"2026-05-13 04:30:58\",\"customer_details\":{},\"currency\":\"IDR\"}','info','2026-05-11 21:33:12','2026-05-11 21:33:12',NULL),
('c490bc55-d386-4464-9155-110e66847885','midtrans_notification',NULL,'{\"transaction_time\":\"2026-05-12 05:17:09\",\"transaction_status\":\"pending\",\"transaction_id\":\"2b6b8aba-c737-4cbe-8d31-7d949297f48e\",\"status_message\":\"midtrans payment notification\",\"status_code\":\"201\",\"signature_key\":\"2e441454ebed34a1ca9449f62f61f2c76f297c4597f0db25cb79c7ff4443b83ff442488f0f370049e59896cfd50bfb2133f7fb139009313835863fefee83f268\",\"reference_id\":\"A120260511221709luxyBZv5XEID-1\",\"payment_type\":\"shopeepay\",\"order_id\":\"THF202605120019\",\"merchant_id\":\"M341601030\",\"gross_amount\":\"2325000.00\",\"fraud_status\":\"accept\",\"expiry_time\":\"2026-05-12 05:32:09\",\"customer_details\":{},\"currency\":\"IDR\"}','info','2026-05-11 22:17:09','2026-05-11 22:17:09',NULL),
('da69bc02-2226-4803-870b-dbf8fd1d2cf7','midtrans_notification',NULL,'{\"transaction_time\":\"2026-05-12 06:41:27\",\"transaction_status\":\"expire\",\"transaction_id\":\"86312b27-e13e-447a-a54b-8ab951a88012\",\"status_message\":\"midtrans payment notification\",\"status_code\":\"202\",\"signature_key\":\"cd80744ecc01985fbd0f085e8cc29cf261f2560dc9ca4ce49e37266104f67d8058ae177ee1d333a7a2b5ae71506c15b092e8b61ac12e9498831ed5bb29ea1e1b\",\"pop_id\":\"5021c097-e8b0-49c7-af22-67fddefba061\",\"payment_type\":\"gopay\",\"order_id\":\"THF202605120007\",\"merchant_id\":\"M341601030\",\"gross_amount\":\"372000.00\",\"fraud_status\":\"accept\",\"expiry_time\":\"2026-05-12 06:56:27\",\"customer_details\":{},\"currency\":\"IDR\"}','info','2026-05-11 23:57:28','2026-05-11 23:57:28',NULL),
('eec39cec-7836-47c3-8530-8e4e3fd920b8','midtrans_notification',NULL,'{\"va_numbers\":[{\"va_number\":\"010304250831608950\",\"bank\":\"bri\"}],\"transaction_time\":\"2026-05-12 05:14:37\",\"transaction_status\":\"settlement\",\"transaction_id\":\"cb785cb6-5e97-45ce-9ef4-ce1bcd2f61cf\",\"status_message\":\"midtrans payment notification\",\"status_code\":\"200\",\"signature_key\":\"af0f100c5750cecf1cbb65dfba88314b7c170a02a9e070c88575feae66dd5ff69a92618db79cde2566f5671d570c184089340e864dab312f4f51f4a1dbe6464e\",\"settlement_time\":\"2026-05-12 05:15:12\",\"payment_type\":\"bank_transfer\",\"payment_amounts\":[],\"order_id\":\"THF202605120018\",\"merchant_id\":\"M341601030\",\"gross_amount\":\"124500.00\",\"fraud_status\":\"accept\",\"expiry_time\":\"2026-05-13 05:14:37\",\"customer_details\":{},\"currency\":\"IDR\"}','info','2026-05-11 22:15:13','2026-05-11 22:15:13',NULL),
('f2aee141-e2bc-4296-9016-c37cb5aac222','midtrans_notification',NULL,'{\"va_numbers\":[{\"va_number\":\"010307481207023533\",\"bank\":\"bri\"}],\"transaction_time\":\"2026-05-12 04:59:53\",\"transaction_status\":\"settlement\",\"transaction_id\":\"4e78b97e-2e58-460e-8ae8-227a56cf276e\",\"status_message\":\"midtrans payment notification\",\"status_code\":\"200\",\"signature_key\":\"5faf5b26594f8c7693cfd4c649b2fb516ea121ef40b2c0340d6dbac10553f842e358b6d14efe3207cf53ad6554cc413c1f03bf4e83f457da78fbcd3a63d8a967\",\"settlement_time\":\"2026-05-12 05:00:29\",\"payment_type\":\"bank_transfer\",\"payment_amounts\":[],\"order_id\":\"THF202605120015\",\"merchant_id\":\"M341601030\",\"gross_amount\":\"374500.00\",\"fraud_status\":\"accept\",\"expiry_time\":\"2026-05-13 04:59:53\",\"customer_details\":{},\"currency\":\"IDR\"}','info','2026-05-11 22:00:30','2026-05-11 22:00:30',NULL),
('f54c1490-50c3-4fdb-907b-f5808abca1e6','midtrans_notification',NULL,'{\"va_numbers\":[{\"va_number\":\"9880103066798800\",\"bank\":\"bni\"}],\"transaction_time\":\"2026-05-12 04:32:21\",\"transaction_status\":\"settlement\",\"transaction_id\":\"c9e269e1-789e-4067-8d98-739a8c83bc55\",\"status_message\":\"midtrans payment notification\",\"status_code\":\"200\",\"signature_key\":\"66d4570dec0e940759c3fca896bc538f970896bcb10bb54586015cae23590adf7b412a64e8a3327e8aa5275904bc8e20d90d56035a1ae8d0db4b00dbeb7b7aa7\",\"settlement_time\":\"2026-05-12 04:41:57\",\"payment_type\":\"bank_transfer\",\"payment_amounts\":[{\"paid_at\":\"2026-05-12 04:41:57\",\"amount\":\"374500.00\"}],\"order_id\":\"THF202605120014\",\"merchant_id\":\"M341601030\",\"gross_amount\":\"374500.00\",\"fraud_status\":\"accept\",\"expiry_time\":\"2026-05-13 04:32:21\",\"customer_details\":{},\"currency\":\"IDR\"}','info','2026-05-11 21:41:58','2026-05-11 21:41:58',NULL),
('ff5440c3-592f-4d00-ac05-71807c095232','midtrans_notification',NULL,'{\"transaction_time\":\"2026-05-12 07:33:43\",\"transaction_status\":\"pending\",\"transaction_id\":\"93db17fa-5497-4f0a-8803-973ba540a186\",\"status_message\":\"midtrans payment notification\",\"status_code\":\"201\",\"signature_key\":\"b1f826f89c2acc53e194feb6f560ec6318d294bb158e8321d5c2cbfaddd32c3a3c50cede069ea427cea24f977070414ec91d2dde524447517e7919962988c1c2\",\"reference_id\":\"A120260512003343rWnzzD1rrmID-1\",\"payment_type\":\"shopeepay\",\"order_id\":\"THF202605120021\",\"merchant_id\":\"M341601030\",\"gross_amount\":\"77500.00\",\"fraud_status\":\"accept\",\"expiry_time\":\"2026-05-12 07:48:43\",\"customer_details\":{},\"currency\":\"IDR\"}','info','2026-05-12 00:33:44','2026-05-12 00:33:44',NULL);
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=176 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES
(15,'1769688344794_init',1),
(16,'1769689448432_create_courses',1),
(18,'1769701217735_create_school_backup',2),
(21,'1769705960416_create_school_subscription',3),
(24,'1769899061508_create_donation',4),
(25,'1770012247389_create_gallery',5),
(26,'1770012358905_edit_donation_gallery',5),
(27,'1770153736133_create_like',6),
(28,'1770154924820_edit_donation_payment',7),
(29,'1770183433618_edit_school_add_admin_phone',8),
(30,'1770214581692_create_app_setting',9),
(32,'1770357490548_create_raport',10),
(35,'1770412910468_create_news',11),
(36,'1770413662416_create_comments',11),
(37,'1770551643382_edit_comment_add_date',12),
(39,'1770643585908_edit_news_add_enable_comment',13),
(42,'1771447533603_edit_school_add_logo',14),
(53,'1772643569726_edit_class_per_year',15),
(60,'1772819587929_create_attendance',16),
(61,'1772819996646_create_course_topic',16),
(70,'1777630828627_edit_class_student',17),
(71,'1777750843575_create_teacher_attendance',18),
(73,'1777993245788_create_teacher_permits',19),
(74,'1778080100444_edit_school_add_desc',20),
(75,'1778115878439_create_academic_calendar',21),
(88,'1778195282410_create_payment_transaction',22),
(90,'1778534427603_create_log',23),
(91,'1778782268187_edit_payment_transaction_add_success_date',24),
(92,'1778977930334_edit_target_tahfidz_remove_semester',25),
(93,'1778978724950_edit_school_add_origin',26),
(94,'1779004205793_edit_teacher_drop_nip_unique',27),
(97,'1779091443927_edit_tahfidz_remove_semester',28),
(98,'1779125823886_edit_target_tahfidz_add_type',29),
(99,'1779339364084_edit_target_tahfidz_add_student',30),
(100,'1779376093485_edit_user_change_verified',31),
(102,'1779484968822_create_activity',32),
(103,'1779699226176_create_bill_discounts',33),
(105,'1780295526497_edit_tahfidz_target_multiple_types',34),
(106,'1780317999483_edit_bill_discount_to_bill_detail',35),
(108,'1780457167290_edit_school_subscription_edit_feature',36),
(111,'1781096234725_create_user_roles',37),
(113,'1781149411912_edit_teacher_add_flags',38),
(114,'1781150577894_edit_user_add_roles',39),
(129,'1781248262044_edit_user_role_add_member_id',40),
(130,'1781264916563_edit_user_role_remove_id',40),
(131,'1781268431901_edit_teacher_parent_remove_user_id',41),
(132,'1781278017709_edit_user_role_add_roles',42),
(133,'1781303347969_edit_user_role_add_is_active',43),
(135,'1781356786580_edit_school_subscription_add_excluded_menus',44),
(148,'1781587021021_create_student_assessment',45),
(149,'1781859514925_create_tilawahs',45),
(160,'1781943117342_create_contract_preparation',46),
(161,'1781960158329_edit_school_subscription_change_json',46),
(162,'1781960240730_edit_activity_change_json',46),
(163,'1782014386366_edit_tilawah_add_time',47),
(165,'1782016894347_edit_tilawah_add_image_and_note',48),
(166,'1782463803455_create_halaqoh',49),
(167,'1783078842691_edit_tahfidz_target_add_halaqoh',50),
(168,'1783095695662_edit_school_add_tagline',51),
(170,'1783168931791_edit_delegation_to_halaqoh',52),
(171,'1783174639705_edit_class_student_remove_tahfidz',53),
(173,'1783224440100_edit_tahfidz_target_switch_to_halaqoh',54),
(174,'1784217452390_create_tahfidz_proposal',55),
(175,'1784268010766_edit_school_add_associate',56);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news` (
  `id` varchar(36) NOT NULL,
  `school_id` varchar(36) DEFAULT NULL,
  `title` varchar(512) NOT NULL,
  `content` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `allow_comment` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` VALUES
('6a9ed6fc-5f5a-4a3a-9350-eccdc5332f8c','582e4596-bb5b-11f0-8be0-d0008dc32c8f','Semua Tak Sama, Tak Pernah Sama','Dalam benakku lama tertanam\nSejuta bayangan dirimu\nRedup terasa cahaya hati\nMengingat apa yang telah kau berikan\n\n[Interlude]\n\n[Verse 2: Fadly]\nWaktu berjalan lambat mengiring\nDalam titian takdir hidupku\nCukup sudah aku tertahan\nDalam persimpangan masa silamku\n\n[Pre-Chorus: Fadly]\nCoba tuk melawan getir yang terus kukecap\nMeresap ke dalam relung sukmaku\nCoba tuk singkirkan aroma nafas tubuhmu\nMengalir mengisi laju darahku\n\n[Chorus: Fadly]\nSemua tak sama, tak pernah sama\nApa yang kusentuh, apa yang kukecup\nSehangat pelukmu, selembut belaimu\nTak ada satupun yang mampu menjadi sepertimu\n\n[Verse 3: Fadly]\nApalah arti hidupku ini\nMemapahku dalam ketiadaan\nS\'galanya luruh lemah tak bertumpu\nHanya bersandar pada dirimu\nKu tak bisa (sungguh) tak bisa\nMengganti dirimu dengan dirinya\n\n[Pre-Chorus: Fadly]\nCoba tuk melawan getir yang terus kukecap\nMeresap ke dalam relung sukmaku\nCoba tuk singkirkan aroma nafas tubuhmu\nMengalir mengisi laju darahku\n\n[Chorus: Fadly]\nSemua tak sama, tak pernah sama\nApa yang kusentuh, apa yang kukecup\nSehangat pelukmu, selembut belaimu\nTak ada satupun yang mampu menjadi sepertimu\n\n[Instrumental]\n\n[Chorus: Fadly]\nSemua tak sama, tak pernah sama\nApa yang kusentuh, apa yang kukecup\nSehangat pelukmu, selembut belaimu\nTak ada satupun yang mampu menjadi sepertimu\n\n[Outro: Piyu]\nSampai kapan kau terus bertahan?\nSampai kapan kau tetap tenggelam?\nSampai kapan kau mesti terlepas?\nBuka mata dan hatimu\nRelakan semua','2026-05-07 12:31:49',1,'2026-05-07 12:31:49','2026-05-07 12:31:49',NULL),
('7a38cc56-e62d-45a1-b74a-5200c4665edf',NULL,'Kaulah yang Bisa Mengerti Aku','asd','2026-02-07 16:48:05',1,'2026-02-07 16:48:05','2026-02-07 16:48:05',NULL),
('bb40b62d-bb40-42e5-98ed-8167665a0273','582e4596-bb5b-11f0-8be0-d0008dc32c8f','Ini Sangat Rahasia','RHS','2026-02-09 13:32:30',1,'2026-02-09 13:32:30','2026-02-09 13:32:30',NULL),
('c5a21979-94f6-4746-8924-e05628e1bd7a','582e4596-bb5b-11f0-8be0-d0008dc32c8f','Apa yang Ada di Hatimu? Di Hatiku Ada Kamu Selalu','JAKARTA: Presiden Prabowo Subianto menyerukan gerakan nasional penggantian atap rumah berbahan seng menjadi genteng berbahan tanah liat atau gentengisasi. \n\nProgram ini digagas sebagai upaya memperindah wajah Indonesia sekaligus menciptakan lingkungan permukiman yang lebih sejuk dan layak huni\n\nGagasan tersebut disampaikan Prabowo saat membuka Rapat Koordinasi Nasional (Rakornas) Pemerintah Pusat dan Daerah di Sentul, Kabupaten Bogor, Jawa Barat, Senin (2/2). \n\nKepala Negara menilai penggunaan atap seng masih mendominasi rumah-rumah di Indonesia, mulai dari kota hingga desa.\n\nMenurut Prabowo, masifnya penggunaan atap seng telah menurunkan kualitas lingkungan permukiman. Selain dinilai kurang indah secara visual, atap seng juga berdampak pada kenyamanan penghuni karena mudah panas dan rentan berkarat.\n\n“Saya ingin semua atap Indonesia pakai genteng. Jadi nanti ini gerakannya adalah gerakan, proyeknya adalah proyek gentengisasi seluruh Indonesia,” ucap Presiden dalam pidatonya yang disiarkan langsung di Youtube Kementerian Dalam Negeri.','2026-02-07 16:20:57',1,'2026-02-07 16:20:57','2026-02-07 16:20:57',NULL),
('fab1679b-0e9b-4a32-8f5e-ba1d1ba3b688','582e4596-bb5b-11f0-8be0-d0008dc32c8f','Siapa yang Bisa Bersamaku','“Jadi nanti Koperasi Merah Putih akan kita lengkapi dengan pabrik genteng. Genteng itu bahan bakunya dari tanah, dan dicampur dengan beberapa zat limbah lainnya, bisa ringan dan kuat,” terang Prabowo.\n\nPresiden juga mengungkap adanya kajian akademisi yang menyebutkan limbah abu batu bara berpotensi dimanfaatkan sebagai campuran bahan genteng.\n\n“Saya dapat laporan dari profesor-profesor kita, limbah abu batu bara bisa dicampur dengan tanah dan menjadi bahan genteng yang baik,” ungkapnya','2026-02-07 16:47:13',1,'2026-02-07 16:47:13','2026-02-07 16:47:13',NULL),
('fd239790-b99b-40ac-9674-c5aac3a3ca1d','582e4596-bb5b-11f0-8be0-d0008dc32c8f','Ert','Gunung Muria adalah sebuah gunung bertipe stratovolcano,[4] yang terletak di pantai utara Jawa Tengah, sekitar 66 kilometer di timur laut Kota Semarang.[5] Gunung ini termasuk ke dalam wilayah Kota Jepara di sisi barat, wilayah Kota Kudus di sisi selatan, dan wilayah Kota Pati di sisi timur.[6] Gunung ini memiliki ketinggian 1606 mdpl, tetapi sumber lain menyebutkan bahwa tingginya 1625 mdpl.[7][8]\n\nGunung ini pernah menjadi pulau tersendiri, dipisahkan dari Pulau Jawa oleh Selat Muria.[9] Selat ini menjadi salah satu jalur perdagangan rempah-rempah yang menghubungkan Timur Tengah dengan Maluku dan mungkin dilalui oleh Tomé Pires dalam perjalanannya di Jawa.[10] Selat ini tertutup pada suatu waktu antara abad ke-17 hingga ke-18.[11]\n\nPada 1970-an, sisi utara gunung ini dipilih oleh Badan Tenaga Nuklir Nasional (BATAN) sebagai lokasi pembangunan pembangkit listrik tenaga nuklir dengan alasan risiko bencana alamnya yang kecil jika dibandingkan dengan wilayah-wilayah lain di Jawa dan Bali.[12] Namun, gempa bumi yang beberapa kali mengguncang di sekitar gunung sejak tahun 2010-an membuat rencana pembangunan tersebut dibatalkan.\n\nErupsi di gunung ini terakhir kali terjadi pada sekitar 160 SM.[7]\n\nGunung Muria merupakan salah satu gunung di Jawa yang berhubungan dengan zona subduksi berumur Miosen, bukan zona subduksi yang aktif (seperti Gunung Merapi atau Gunung Kelud), dengan Zona Wadati–Benioff sedalam sekitar 400 kilometer.[13] Meskipun demikian, aktivitas magmatik setidaknya diketahui masih ada di bawah gunung pada tahun 2000.[14]\n\nGunung Muria memiliki sejarah yang sama dengan Gunung Genuk (gunung kecil yang berada di Donorojo, di utara Muria), terutama dalam pembentukan bentang alam Semenanjung Muria. Keduanya menghasilkan lava koheren baik kubah lava dan sumbat lava maupun maar yang terdapat di kaki gunung dan daratan.[3] Selain itu, dijumpai pula breksi gunung api, lapili, dan tuf yang banyak mengeliling sekitar gunung. Namun, densitasnya hanya mencapai 2.4 gr/cm3 sehingga tidak terlalu besar jika dibandingkan dengan persebaran batuan yang lain.[15]','2026-02-08 01:21:29',1,'2026-02-08 01:21:29','2026-02-08 01:21:29',NULL);
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parent_students`
--

DROP TABLE IF EXISTS `parent_students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parent_students` (
  `parent_id` varchar(36) NOT NULL,
  `student_id` varchar(36) NOT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`parent_id`,`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parent_students`
--

LOCK TABLES `parent_students` WRITE;
/*!40000 ALTER TABLE `parent_students` DISABLE KEYS */;
INSERT INTO `parent_students` VALUES
('682146f2-4507-4f45-aa4e-882279eeb195','598f3241-bc5f-11f0-8b9c-41333d9a4eb4',0),
('682146f2-4507-4f45-aa4e-882279eeb195','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4',0),
('682146f2-4507-4f45-aa4e-882279eeb195','7c923100-bc5f-11f0-8b9c-41333d9a4eb4',0),
('682146f2-4507-4f45-aa4e-882279eeb195','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119',1),
('69757bfc-5e42-4e36-adcb-c2a410b9de85','687360ac-ce0d-4b3e-a035-bb27f7ccfc77',1),
('94db24a5-371b-46d7-9957-a643f0d99191','83458f40-9fea-4bb3-8cad-786a5115082b',1),
('9b3b38b7-1229-4741-a01b-63498b85b955','3c60f715-d997-11f0-8cda-5bb67e5632f8',1);
/*!40000 ALTER TABLE `parent_students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parents`
--

DROP TABLE IF EXISTS `parents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parents` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sex` enum('M','F') DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parents`
--

LOCK TABLES `parents` WRITE;
/*!40000 ALTER TABLE `parents` DISABLE KEYS */;
INSERT INTO `parents` VALUES
('682146f2-4507-4f45-aa4e-882279eeb195','Rala Syifa',NULL,NULL,'prof_f2540de1-2d04-48c6-af0a-600c5d99e6c9.png','081111222333','Jl Nangka No 8','2025-12-24 12:23:19','2025-12-24 12:23:19',NULL),
('69757bfc-5e42-4e36-adcb-c2a410b9de85','wali_bopkri@me.com',NULL,NULL,NULL,NULL,NULL,'2026-07-09 01:13:03','2026-07-09 01:13:03',NULL),
('94db24a5-371b-46d7-9957-a643f0d99191','mt dua',NULL,NULL,NULL,NULL,NULL,'2026-06-25 10:43:17','2026-06-25 10:43:17',NULL),
('9b3b38b7-1229-4741-a01b-63498b85b955','Bintang Kejora',NULL,NULL,NULL,'','','2026-06-12 12:48:33','2026-06-12 12:48:33',NULL);
/*!40000 ALTER TABLE `parents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_transaction_bill_details`
--

DROP TABLE IF EXISTS `payment_transaction_bill_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_transaction_bill_details` (
  `id` varchar(36) NOT NULL,
  `payment_transaction_id` varchar(36) NOT NULL,
  `bill_detail_id` varchar(36) NOT NULL,
  `month` int(11) DEFAULT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_transaction_bill_details`
--

LOCK TABLES `payment_transaction_bill_details` WRITE;
/*!40000 ALTER TABLE `payment_transaction_bill_details` DISABLE KEYS */;
INSERT INTO `payment_transaction_bill_details` VALUES
('0d851902-aca8-4aca-b5a4-62bad9e90cd3','341e5713-0edb-4f48-bbab-3ee8c9a68e7f','3bf512e9-192d-48be-8e5f-5a801973f42a',4,250000),
('0de70202-28ce-46e5-82e9-074b151cd9d6','f1e72257-f407-40bd-8e6e-2f895ea28cde','4fe7f210-0737-49ea-845c-52a09e570ce8',NULL,120000),
('113f119b-d51d-41a4-b908-32810840e8e8','c8dd114d-71c5-430b-a5be-4c895834d385','3bf512e9-192d-48be-8e5f-5a801973f42a',4,250000),
('12a2ce6f-85a1-4d43-ae1c-72f9ba4dc817','5784ddfd-cdec-4adb-98c4-c32220afd0a7','4fe7f210-0737-49ea-845c-52a09e570ce8',NULL,120000),
('14aa4542-a690-4da5-95d7-1500f00c7a10','9a04d0a3-205a-49d1-998d-d436c9a2b764','3bf512e9-192d-48be-8e5f-5a801973f42a',4,250000),
('14fa6d0e-32c9-431a-8acc-b712101105ac','a4c1f11e-4867-416b-b5ff-3abc4c65f54c','4fe7f210-0737-49ea-845c-52a09e570ce8',NULL,120000),
('22f8afa6-3225-4089-ab0e-3d07efb2f20c','f5aa0fb8-a7d5-4900-a281-b045bac51d5c','3bf512e9-192d-48be-8e5f-5a801973f42a',4,250000),
('25a8179f-284d-43ec-8552-2a5e4b62cf4a','9f5309f2-19fb-4936-be14-859e27ba9dbf','3bf512e9-192d-48be-8e5f-5a801973f42a',4,250000),
('28bf9a00-5dbe-41ff-8de1-f9bbcd44f53a','4eeb30a6-68d4-45f5-9b0d-addd10191e97','3bf512e9-192d-48be-8e5f-5a801973f42a',2,250000),
('343355fc-0e38-405f-a178-af04884ef0f6','45dfe49b-3f8f-4aa2-9605-c2d1f7a6c92e','4fe7f210-0737-49ea-845c-52a09e570ce8',NULL,120000),
('36521504-7f5b-428e-9b0a-a4cbe5f09fbd','2d0f3dbd-14f3-4a84-8fdb-7c532a5f20e0','3bf512e9-192d-48be-8e5f-5a801973f42a',4,250000),
('36ac1a48-fe80-4f6c-a51a-34646e38d027','c8dd114d-71c5-430b-a5be-4c895834d385','4fe7f210-0737-49ea-845c-52a09e570ce8',NULL,120000),
('37eecd7b-b2a6-4ed7-8ff0-f5155792f657','0919a49f-c577-48d1-beba-762ffc6a7569','edd24ce0-63bd-4679-b2fa-6290c6775d2c',NULL,45000),
('508ac26a-8ad7-4584-a40c-f09b6bb056c0','c62d6660-a55b-425c-b291-c719e470d36e','4fe7f210-0737-49ea-845c-52a09e570ce8',NULL,120000),
('50a5ffb4-107e-421d-b504-b51c130e405f','12638178-a131-43a3-b23c-66ef775bd0b2','4fe7f210-0737-49ea-845c-52a09e570ce8',NULL,120000),
('5b06106e-79a4-4727-a595-675db377661b','45dfe49b-3f8f-4aa2-9605-c2d1f7a6c92e','3bf512e9-192d-48be-8e5f-5a801973f42a',4,250000),
('5dfc913f-9360-42d8-9f23-121b8252dc3a','e98c8633-6cec-44c4-b1c0-1b7ed7a67d20','3bf512e9-192d-48be-8e5f-5a801973f42a',12,250000),
('6f9f2672-6ef5-43ff-b34d-a170b1d6a9c9','3d862d67-4800-42e9-b27d-4b41f709f625','4fe7f210-0737-49ea-845c-52a09e570ce8',NULL,120000),
('84a16125-ad5c-4747-9366-c1c7ec1a0fb3','9f5309f2-19fb-4936-be14-859e27ba9dbf','4fe7f210-0737-49ea-845c-52a09e570ce8',NULL,120000),
('87b12be6-9d3c-4e11-b6ac-fdd315a28e70','2669664c-ffa7-48ed-b750-cbd0a8c60815','3bf512e9-192d-48be-8e5f-5a801973f42a',4,250000),
('882822e1-d4d9-437a-b65b-e57030160f05','84651293-9bdf-436f-b8e9-120b0e33173b','3bf512e9-192d-48be-8e5f-5a801973f42a',4,250000),
('8b70ad4e-e1df-4780-a122-2e1766f36b08','87d58d61-5fdf-4b52-82b8-281e8c2b0755','3bf512e9-192d-48be-8e5f-5a801973f42a',4,250000),
('99e7578c-695f-4a76-8178-1fff19df5836','e98c8633-6cec-44c4-b1c0-1b7ed7a67d20','3bf512e9-192d-48be-8e5f-5a801973f42a',11,250000),
('abc6bbd4-63be-4d92-b9c5-32890e142a5f','01d355fc-05fd-49d7-bff8-d12ee51adcc4','4fe7f210-0737-49ea-845c-52a09e570ce8',NULL,120000),
('b22c9782-68f2-40ed-a56f-8dab4dc19b2b','12638178-a131-43a3-b23c-66ef775bd0b2','3bf512e9-192d-48be-8e5f-5a801973f42a',4,250000),
('b3e1f18b-f032-4c34-b7d7-7ad2690bf1ca','2669664c-ffa7-48ed-b750-cbd0a8c60815','4fe7f210-0737-49ea-845c-52a09e570ce8',NULL,120000),
('b814d1fd-6978-43d1-8f16-6f58290b5ce4','4eeb30a6-68d4-45f5-9b0d-addd10191e97','edd24ce0-63bd-4679-b2fa-6290c6775d2c',NULL,45000),
('bb238281-cda5-4a8e-9411-b5e368b3a64b','c62d6660-a55b-425c-b291-c719e470d36e','3bf512e9-192d-48be-8e5f-5a801973f42a',4,250000),
('c50985ee-d86a-4cdd-9d6d-93077ae69fc7','e98c8633-6cec-44c4-b1c0-1b7ed7a67d20','3bf512e9-192d-48be-8e5f-5a801973f42a',1,250000),
('cec1120a-d4d0-4a2d-bbc0-913d9dff07b5','9765ec57-e3d2-4350-a9e2-36c0a9698418','3bf512e9-192d-48be-8e5f-5a801973f42a',4,250000),
('d061ef54-f81e-47bf-be52-153ef5c38acb','f5aa0fb8-a7d5-4900-a281-b045bac51d5c','4fe7f210-0737-49ea-845c-52a09e570ce8',NULL,120000),
('d5c10fe5-8661-4dd9-b723-d84ed2da9ef3','9a04d0a3-205a-49d1-998d-d436c9a2b764','4fe7f210-0737-49ea-845c-52a09e570ce8',NULL,120000),
('d641b5e8-faa7-4906-87da-19c508b25f30','2d0f3dbd-14f3-4a84-8fdb-7c532a5f20e0','4fe7f210-0737-49ea-845c-52a09e570ce8',NULL,120000),
('e4da3ee8-ad96-4395-a69d-530a09473db6','f1e72257-f407-40bd-8e6e-2f895ea28cde','3bf512e9-192d-48be-8e5f-5a801973f42a',4,250000),
('e72ab653-dbe2-4b4c-b109-1a24161b33ea','b72a2add-7b22-4d15-b633-58559848e08b','4fe7f210-0737-49ea-845c-52a09e570ce8',NULL,120000),
('e752d541-259e-4333-af01-f81203d375fa','87d58d61-5fdf-4b52-82b8-281e8c2b0755','4fe7f210-0737-49ea-845c-52a09e570ce8',NULL,120000),
('ecc54eb2-450d-4a4a-b31a-5f80878207cd','3d862d67-4800-42e9-b27d-4b41f709f625','3bf512e9-192d-48be-8e5f-5a801973f42a',4,250000),
('ed1bcdd6-319f-488d-96eb-a2d5e478b0c0','5784ddfd-cdec-4adb-98c4-c32220afd0a7','3bf512e9-192d-48be-8e5f-5a801973f42a',4,250000),
('edbdb8cc-e56e-4967-8a39-129266fc69fb','84651293-9bdf-436f-b8e9-120b0e33173b','4fe7f210-0737-49ea-845c-52a09e570ce8',NULL,120000),
('eef74104-328b-4e81-a5b4-36cb5f17d719','9765ec57-e3d2-4350-a9e2-36c0a9698418','4fe7f210-0737-49ea-845c-52a09e570ce8',NULL,120000),
('f0010bb4-b229-4895-91e5-6553582b182d','341e5713-0edb-4f48-bbab-3ee8c9a68e7f','4fe7f210-0737-49ea-845c-52a09e570ce8',NULL,120000);
/*!40000 ALTER TABLE `payment_transaction_bill_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_transaction_donation_details`
--

DROP TABLE IF EXISTS `payment_transaction_donation_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_transaction_donation_details` (
  `id` varchar(36) NOT NULL,
  `payment_transaction_id` varchar(36) NOT NULL,
  `donation_id` varchar(36) NOT NULL,
  `prayer` text NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_transaction_donation_details`
--

LOCK TABLES `payment_transaction_donation_details` WRITE;
/*!40000 ALTER TABLE `payment_transaction_donation_details` DISABLE KEYS */;
INSERT INTO `payment_transaction_donation_details` VALUES
('08c76cf6-59eb-4a64-94d7-93b06e33f047','dc21f4ca-2f52-4233-94e2-3336137f91d3','3a06d9f6-2fc6-40c8-bab5-ce78fffdbb9d','',50000),
('5ae617de-4ff7-4194-b70e-d3759c164015','527c0b3b-32e3-4873-a94d-9e5ad6677758','fe9ee1f6-6bea-4505-b658-77cf8ee62138','Halo',25000),
('ee716650-1644-4d49-aeff-9cd9fa0d3fc2','49017e7b-2073-4534-b8ed-ac8ac81e5b53','fe9ee1f6-6bea-4505-b658-77cf8ee62138','as',25000);
/*!40000 ALTER TABLE `payment_transaction_donation_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_transactions`
--

DROP TABLE IF EXISTS `payment_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_transactions` (
  `id` varchar(36) NOT NULL,
  `transaction_id` varchar(15) NOT NULL,
  `student_id` varchar(36) NOT NULL,
  `total` int(11) NOT NULL,
  `admin_fee` int(11) NOT NULL,
  `payment_method` varchar(20) NOT NULL,
  `kind` enum('Bill','Donation') NOT NULL,
  `status` enum('Pending','Paid','Failed') NOT NULL,
  `info` text NOT NULL,
  `method` text NOT NULL,
  `expiry_time` datetime NOT NULL,
  `created_by` varchar(36) NOT NULL,
  `paid_date` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_transactions`
--

LOCK TABLES `payment_transactions` WRITE;
/*!40000 ALTER TABLE `payment_transactions` DISABLE KEYS */;
INSERT INTO `payment_transactions` VALUES
('01d355fc-05fd-49d7-bff8-d12ee51adcc4','THF202605130001','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4',120000,252000,'shopeepay','Bill','Failed','{\"kind\":\"link\",\"link\":\"https://simulator.sandbox.midtrans.com/shopeepay/payment-pin?referenceId=A120260512211527fqLTV5aFBCID-1\"}','{\"id\":\"shopeepay\",\"type\":\"wallet\",\"midtrans_payment_type\":\"shopeepay\",\"title\":\"Shopeepay\",\"description\":\"Shopeepay\",\"admin_fee\":{\"kind\":\"percent\",\"value\":2.1},\"image\":\"__$$HOST$$__/images/ic-shopeepay.svg\"}','2026-05-13 04:30:27','5b81ce5e-cce5-11f0-8f97-aa3b281802c1',NULL,'2026-05-12 21:15:28','2026-05-12 21:15:28',NULL),
('0919a49f-c577-48d1-beba-762ffc6a7569','THF202605150002','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4',45000,945,'shopeepay','Bill','Paid','{\"kind\":\"link\",\"link\":\"https://simulator.sandbox.midtrans.com/shopeepay/payment-pin?referenceId=A120260514181505jL2o0CmxXFID-1\"}','{\"id\":\"shopeepay\",\"type\":\"wallet\",\"midtrans_payment_type\":\"shopeepay\",\"title\":\"Shopeepay\",\"description\":\"Shopeepay\",\"admin_fee\":{\"kind\":\"percent\",\"value\":2.1},\"image\":\"__$$HOST$$__/images/ic-shopeepay.svg\"}','2026-05-15 01:30:05','5b81ce5e-cce5-11f0-8f97-aa3b281802c1','2026-05-15 01:18:06','2026-05-14 18:15:06','2026-05-14 18:15:06',NULL),
('2d0f3dbd-14f3-4a84-8fdb-7c532a5f20e0','THF202605120015','598f3241-bc5f-11f0-8b9c-41333d9a4eb4',370000,4500,'bri','Bill','Failed','{\"kind\":\"va\",\"va\":\"010307481207023533\"}','{\"id\":\"bri\",\"type\":\"va\",\"midtrans_payment_type\":\"bank_transfer\",\"title\":\"BRI\",\"description\":\"BRI Virtual Account\",\"admin_fee\":4500,\"image\":\"__$$HOST$$__/images/ic-bri.svg\"}','2026-05-13 04:59:53','5b81ce5e-cce5-11f0-8f97-aa3b281802c1',NULL,'2026-05-11 21:59:53','2026-05-11 21:59:53',NULL),
('49017e7b-2073-4534-b8ed-ac8ac81e5b53','THF202605120021','',25000,52500,'shopeepay','Donation','Paid','{\"kind\":\"link\",\"link\":\"https://simulator.sandbox.midtrans.com/shopeepay/payment-pin?referenceId=A120260512003343rWnzzD1rrmID-1\"}','{\"id\":\"shopeepay\",\"type\":\"wallet\",\"midtrans_payment_type\":\"shopeepay\",\"title\":\"Shopeepay\",\"description\":\"Shopeepay\",\"admin_fee\":{\"kind\":\"percent\",\"value\":2.1},\"image\":\"__$$HOST$$__/images/ic-shopeepay.svg\"}','2026-05-12 07:48:43','5b81ce5e-cce5-11f0-8f97-aa3b281802c1','2026-05-12 07:33:43','2026-05-12 00:33:43','2026-05-12 00:33:43',NULL),
('4eeb30a6-68d4-45f5-9b0d-addd10191e97','THF202605150001','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4',295000,6195,'shopeepay','Bill','Failed','{\"kind\":\"link\",\"link\":\"https://simulator.sandbox.midtrans.com/shopeepay/payment-pin?referenceId=A1202605141739163hyLhibnFTID-1\"}','{\"id\":\"shopeepay\",\"type\":\"wallet\",\"midtrans_payment_type\":\"shopeepay\",\"title\":\"Shopeepay\",\"description\":\"Shopeepay\",\"admin_fee\":{\"kind\":\"percent\",\"value\":2.1},\"image\":\"__$$HOST$$__/images/ic-shopeepay.svg\"}','2026-05-15 00:54:16','5b81ce5e-cce5-11f0-8f97-aa3b281802c1',NULL,'2026-05-14 17:39:16','2026-05-14 17:39:16',NULL),
('527c0b3b-32e3-4873-a94d-9e5ad6677758','THF202605120020','',25000,52500,'shopeepay','Donation','Failed','{\"kind\":\"link\",\"link\":\"https://simulator.sandbox.midtrans.com/shopeepay/payment-pin?referenceId=A120260512003254roBotP2DjvID-1\"}','{\"id\":\"shopeepay\",\"type\":\"wallet\",\"midtrans_payment_type\":\"shopeepay\",\"title\":\"Shopeepay\",\"description\":\"Shopeepay\",\"admin_fee\":{\"kind\":\"percent\",\"value\":2.1},\"image\":\"__$$HOST$$__/images/ic-shopeepay.svg\"}','2026-05-12 07:47:54','5b81ce5e-cce5-11f0-8f97-aa3b281802c1',NULL,'2026-05-12 00:32:54','2026-05-12 00:32:54',NULL),
('9a04d0a3-205a-49d1-998d-d436c9a2b764','THF202605120016','598f3241-bc5f-11f0-8b9c-41333d9a4eb4',370000,4500,'bni','Bill','Failed','{\"kind\":\"va\",\"va\":\"9880103080877542\"}','{\"id\":\"bni\",\"type\":\"va\",\"midtrans_payment_type\":\"bank_transfer\",\"title\":\"BNI\",\"description\":\"BNI Virtual Account\",\"admin_fee\":4500,\"image\":\"__$$HOST$$__/images/ic-bni.svg\"}','2026-05-13 05:02:09','5b81ce5e-cce5-11f0-8f97-aa3b281802c1',NULL,'2026-05-11 22:02:10','2026-05-11 22:02:10',NULL),
('9f5309f2-19fb-4936-be14-859e27ba9dbf','THF202605120017','598f3241-bc5f-11f0-8b9c-41333d9a4eb4',370000,4500,'bsi','Bill','Paid','{\"kind\":\"va\",\"va\":\"01030621634473584\"}','{\"id\":\"bsi\",\"type\":\"va\",\"midtrans_payment_type\":\"bank_transfer\",\"title\":\"BSI\",\"description\":\"BSI Virtual Account\",\"admin_fee\":4500,\"image\":\"__$$HOST$$__/images/ic-bsi.svg\"}','2026-05-13 05:03:08','5b81ce5e-cce5-11f0-8f97-aa3b281802c1','2026-05-12 05:03:08','2026-05-11 22:03:08','2026-05-11 22:03:08',NULL),
('a4c1f11e-4867-416b-b5ff-3abc4c65f54c','THF202605130011','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4',120000,2520,'shopeepay','Bill','Failed','{\"kind\":\"link\",\"link\":\"https://simulator.sandbox.midtrans.com/shopeepay/payment-pin?referenceId=A120260512212253cfU5TIs5U1ID-1\"}','{\"id\":\"shopeepay\",\"type\":\"wallet\",\"midtrans_payment_type\":\"shopeepay\",\"title\":\"Shopeepay\",\"description\":\"Shopeepay\",\"admin_fee\":{\"kind\":\"percent\",\"value\":2.1},\"image\":\"__$$HOST$$__/images/ic-shopeepay.svg\"}','2026-05-16 04:37:53','5b81ce5e-cce5-11f0-8f97-aa3b281802c1',NULL,'2026-05-12 21:22:53','2026-05-12 21:22:53',NULL),
('b72a2add-7b22-4d15-b633-58559848e08b','THF202605120018','598f3241-bc5f-11f0-8b9c-41333d9a4eb4',120000,4500,'bri','Bill','Failed','{\"kind\":\"va\",\"va\":\"010304250831608950\"}','{\"id\":\"bri\",\"type\":\"va\",\"midtrans_payment_type\":\"bank_transfer\",\"title\":\"BRI\",\"description\":\"BRI Virtual Account\",\"admin_fee\":4500,\"image\":\"__$$HOST$$__/images/ic-bri.svg\"}','2026-05-16 05:14:37','5b81ce5e-cce5-11f0-8f97-aa3b281802c1',NULL,'2026-05-11 22:14:38','2026-05-11 22:14:38',NULL),
('dc21f4ca-2f52-4233-94e2-3336137f91d3','THF202605140001','',50000,400,'qris','Donation','Failed','{\"kind\":\"qr\",\"qr\":\"https://merchants-app.sbx.midtrans.com/v4/qris/gopay/A120260514154658kBWI0o4dY2ID/qr-code\"}','{\"id\":\"qris\",\"type\":\"wallet\",\"midtrans_payment_type\":\"qris\",\"title\":\"QRIS\",\"description\":\"Scan QR Code\",\"admin_fee\":{\"kind\":\"percent\",\"value\":0.8},\"image\":\"__$$HOST$$__/images/ic-qris.png\"}','2026-05-16 23:01:58','5b81ce5e-cce5-11f0-8f97-aa3b281802c1',NULL,'2026-05-14 15:46:58','2026-05-14 15:46:58',NULL),
('e98c8633-6cec-44c4-b1c0-1b7ed7a67d20','THF202605120019','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4',750000,1575000,'shopeepay','Bill','Paid','{\"kind\":\"link\",\"link\":\"https://simulator.sandbox.midtrans.com/shopeepay/payment-pin?referenceId=A120260511221709luxyBZv5XEID-1\"}','{\"id\":\"shopeepay\",\"type\":\"wallet\",\"midtrans_payment_type\":\"shopeepay\",\"title\":\"Shopeepay\",\"description\":\"Shopeepay\",\"admin_fee\":{\"kind\":\"percent\",\"value\":2.1},\"image\":\"__$$HOST$$__/images/ic-shopeepay.svg\"}','2026-05-12 05:32:09','5b81ce5e-cce5-11f0-8f97-aa3b281802c1','2026-05-12 05:17:09','2026-05-11 22:17:09','2026-05-11 22:17:09',NULL);
/*!40000 ALTER TABLE `payment_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments` (
  `id` varchar(36) NOT NULL,
  `bill_detail_id` varchar(36) NOT NULL,
  `month` int(11) DEFAULT NULL,
  `student_id` varchar(36) NOT NULL,
  `date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_payment_bill_detail` (`bill_detail_id`),
  CONSTRAINT `FK_payment_bill_detail` FOREIGN KEY (`bill_detail_id`) REFERENCES `bill_details` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES
('06a5b172-4e1b-4a75-bd73-99b28a77004e','3bf512e9-192d-48be-8e5f-5a801973f42a',12,'683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','2026-05-12','2026-05-11 22:17:14','2026-05-11 22:17:14',NULL),
('199ee3fa-febd-4a5b-bd5c-91e0ec61164d','3bf512e9-192d-48be-8e5f-5a801973f42a',11,'598f3241-bc5f-11f0-8b9c-41333d9a4eb4','2026-01-13','2026-01-13 14:31:08','2026-01-13 14:31:08',NULL),
('1ae702fa-ec5b-481c-823d-05ed727887a0','3bf512e9-192d-48be-8e5f-5a801973f42a',8,'683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','2026-01-12','2026-01-12 11:07:34','2026-01-12 11:07:34',NULL),
('34e68d18-2663-4ee2-af3f-64dfa3b25311','3bf512e9-192d-48be-8e5f-5a801973f42a',9,'cdc42a1e-bcb3-11f0-8ff6-9efd1c949119','2026-02-02','2026-02-01 23:08:21','2026-02-01 23:08:21',NULL),
('3a0e8222-82c9-48cc-9a2c-5704163ca34a','3bf512e9-192d-48be-8e5f-5a801973f42a',11,'683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','2026-05-12','2026-05-11 22:17:14','2026-05-11 22:17:14',NULL),
('47871e3a-a5cb-486c-88e9-ac138533e73a','3bf512e9-192d-48be-8e5f-5a801973f42a',7,'cdc42a1e-bcb3-11f0-8ff6-9efd1c949119','2026-02-02','2026-02-01 23:08:15','2026-02-01 23:08:15',NULL),
('4e48571d-9dec-46c7-8d7d-6376afedd701','3bf512e9-192d-48be-8e5f-5a801973f42a',10,'598f3241-bc5f-11f0-8b9c-41333d9a4eb4','2026-01-12','2026-01-12 15:31:01','2026-01-12 15:31:01',NULL),
('596fc0da-09ae-4b3f-abc2-1c93257d77fc','3bf512e9-192d-48be-8e5f-5a801973f42a',7,'683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','2026-01-12','2026-01-12 06:08:00','2026-01-12 06:08:00',NULL),
('72b3b58e-37d7-4b15-a8e7-3534a0d711c7','3bf512e9-192d-48be-8e5f-5a801973f42a',7,'3c60f715-d997-11f0-8cda-5bb67e5632f8','2026-05-22','2026-05-22 13:24:49','2026-05-22 13:24:49',NULL),
('7a664617-0359-48f1-9796-7893fba9962d','edd24ce0-63bd-4679-b2fa-6290c6775d2c',NULL,'cdc42a1e-bcb3-11f0-8ff6-9efd1c949119','2026-02-02','2026-02-01 23:08:18','2026-02-01 23:08:18',NULL),
('84fd9432-f25e-467e-9a51-3c6c3f78531d','3bf512e9-192d-48be-8e5f-5a801973f42a',1,'598f3241-bc5f-11f0-8b9c-41333d9a4eb4','2026-02-01','2026-02-01 07:21:09','2026-02-01 07:21:09',NULL),
('9193e5db-35c8-481d-b4d2-8f055aa556dc','3bf512e9-192d-48be-8e5f-5a801973f42a',2,'598f3241-bc5f-11f0-8b9c-41333d9a4eb4','2026-02-02','2026-02-01 23:06:44','2026-02-01 23:06:44',NULL),
('95716e49-86df-4042-87fd-651f91365b55','3bf512e9-192d-48be-8e5f-5a801973f42a',12,'598f3241-bc5f-11f0-8b9c-41333d9a4eb4','2026-01-26','2026-01-25 18:15:58','2026-01-25 18:15:58',NULL),
('974851b9-d3fc-408e-bcb6-3293dbc00327','3bf512e9-192d-48be-8e5f-5a801973f42a',8,'598f3241-bc5f-11f0-8b9c-41333d9a4eb4','2026-01-12','2026-01-12 15:31:01','2026-01-12 15:31:01',NULL),
('9ca566d3-12c4-4474-9473-4981b533178b','4fe7f210-0737-49ea-845c-52a09e570ce8',NULL,'598f3241-bc5f-11f0-8b9c-41333d9a4eb4','2026-05-12','2026-05-11 22:15:13','2026-05-11 22:15:13',NULL),
('9cff4939-f87c-410f-9972-9359ca7ca50d','3bf512e9-192d-48be-8e5f-5a801973f42a',7,'cdc43038-bcb3-11f0-8ff6-9efd1c949119','2026-05-21','2026-05-21 13:50:19','2026-05-21 13:50:19',NULL),
('d1fd5a94-3b4f-4b93-9794-94c30ef8a8cf','3bf512e9-192d-48be-8e5f-5a801973f42a',10,'683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','2026-01-12','2026-01-12 11:07:34','2026-01-12 11:07:34',NULL),
('d4677ad3-de5b-409f-b31e-f47ce5f5e8fc','3bf512e9-192d-48be-8e5f-5a801973f42a',9,'598f3241-bc5f-11f0-8b9c-41333d9a4eb4','2026-01-12','2026-01-12 15:31:01','2026-01-12 15:31:01',NULL),
('d7798861-6a5e-4ba4-87fb-6c282ff247e5','3bf512e9-192d-48be-8e5f-5a801973f42a',1,'683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','2026-05-12','2026-05-11 22:17:14','2026-05-11 22:17:14',NULL),
('e4cd08ca-8f1b-4204-b315-8ded25478991','3bf512e9-192d-48be-8e5f-5a801973f42a',7,'598f3241-bc5f-11f0-8b9c-41333d9a4eb4','2026-01-01','2026-01-12 06:06:20','2026-01-12 06:06:20',NULL),
('e7b240f7-5e79-4007-aa55-bfb217b49ec5','3bf512e9-192d-48be-8e5f-5a801973f42a',8,'cdc42a1e-bcb3-11f0-8ff6-9efd1c949119','2026-02-02','2026-02-01 23:08:15','2026-02-01 23:08:15',NULL),
('e862964f-4b44-49c5-9e28-6966816b5480','3bf512e9-192d-48be-8e5f-5a801973f42a',9,'683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','2026-01-12','2026-01-12 11:07:34','2026-01-12 11:07:34',NULL),
('effa823b-b320-4e5d-a02b-b0968cfc0533','3bf512e9-192d-48be-8e5f-5a801973f42a',3,'598f3241-bc5f-11f0-8b9c-41333d9a4eb4','2026-02-02','2026-02-01 23:06:55','2026-02-01 23:06:55',NULL);
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `raports`
--

DROP TABLE IF EXISTS `raports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `raports` (
  `id` varchar(36) NOT NULL,
  `student_id` varchar(36) NOT NULL,
  `year_id` varchar(36) NOT NULL,
  `semester` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `file` varchar(512) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `raports`
--

LOCK TABLES `raports` WRITE;
/*!40000 ALTER TABLE `raports` DISABLE KEYS */;
INSERT INTO `raports` VALUES
('300a75ba-0c98-43c4-8b90-1c392b3c50b6','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186',1,'2026-02-06 12:03:20','rapo_847d581e-ad37-4bce-b942-ba02bbec74c6.pdf','2026-02-06 12:03:20','2026-02-06 12:03:20',NULL),
('3fbe4882-f631-481b-b051-a9f774eee1ad','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186',1,'2026-02-06 12:03:14','rapo_6a090303-84a8-4532-a9b6-6fcbbe8b459b.pdf','2026-02-06 12:03:14','2026-02-06 12:03:14',NULL),
('86b6f4f7-7cef-47e4-9f30-2a195e9b0fca','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186',2,'2026-02-06 13:52:57','rapo_38c5f7f5-2272-4226-a833-bd051a0fb1d8.pdf','2026-02-06 13:52:57','2026-02-06 13:52:57',NULL),
('e358aad0-441c-441a-9e36-60d025116ea0','7c923100-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186',1,'2026-02-07 23:47:49','rapo_683bade5-2a58-4529-a463-25ec30b46cdb.pdf','2026-02-07 23:47:49','2026-02-07 23:47:49',NULL);
/*!40000 ALTER TABLE `raports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_settings`
--

DROP TABLE IF EXISTS `school_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_settings` (
  `school_id` varchar(36) NOT NULL,
  `id` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`school_id`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_settings`
--

LOCK TABLES `school_settings` WRITE;
/*!40000 ALTER TABLE `school_settings` DISABLE KEYS */;
INSERT INTO `school_settings` VALUES
('582e4596-bb5b-11f0-8be0-d0008dc32c8f','course_schedule','[{\"items\":[{\"time_start\":\"07.00\",\"time_end\":\"07.40\"},{\"time_start\":\"07.40\",\"time_end\":\"08.20\"},{\"time_start\":\"08.20\",\"time_end\":\"09.00\"},{\"time_start\":\"09.00\",\"time_end\":\"09.40\"},{\"time_start\":\"09.40\",\"time_end\":\"10.00\",\"is_rest\":true,\"rest_text\":\"Istirahat\"},{\"time_start\":\"10.00\",\"time_end\":\"10.40\"},{\"time_start\":\"10.40\",\"time_end\":\"11.20\"},{\"time_start\":\"11.20\",\"time_end\":\"12.00\"},{\"time_start\":\"12.00\",\"time_end\":\"13.00\",\"is_rest\":true,\"rest_text\":\"Sholat & makan siang\"},{\"time_start\":\"13.00\",\"time_end\":\"13.40\"},{\"time_start\":\"13.40\",\"time_end\":\"14.20\"}]}]'),
('582e4596-bb5b-11f0-8be0-d0008dc32c8f','student_nickname','\"Budhak\"'),
('582e4596-bb5b-11f0-8be0-d0008dc32c8f','tahfidz_menu','[\"Ziyadah\",\"Murojaah\",\"Tahsin\"]');
/*!40000 ALTER TABLE `school_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_subscriptions`
--

DROP TABLE IF EXISTS `school_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_subscriptions` (
  `id` varchar(36) NOT NULL,
  `school_id` varchar(36) NOT NULL,
  `status` enum('Aktif','Trial','Hold','Rejected','Non Aktif','Nego') NOT NULL,
  `mode` enum('Normal','White Label') NOT NULL,
  `feature_set` enum('Basic','Premium','Enterprise') NOT NULL DEFAULT 'Basic',
  `excluded_menus` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_subscriptions`
--

LOCK TABLES `school_subscriptions` WRITE;
/*!40000 ALTER TABLE `school_subscriptions` DISABLE KEYS */;
INSERT INTO `school_subscriptions` VALUES
('1b85102b-6438-46f5-9f3a-1bdad6536f72','582e4596-bb5b-11f0-8be0-d0008dc32c8f','Aktif','Normal','Enterprise','[]'),
('6a337f78-9b01-45c0-b700-dde628ba9db5','0001ba5c-2ef5-e011-98ed-5fb2081f1870','Hold','Normal','Basic',NULL),
('79fafb5f-4b02-4fc6-a83c-d715b5f44929','0001795c-2ef5-e011-a96c-63a882fbcc5a','Aktif','Normal','Enterprise','[\"teacher_attendance\",\"teacher_permit\",\"student_attendance\",\"student_assessment\",\"activity_attendance\",\"course_topic\",\"course_schedule\",\"course_module\",\"academic_calendar\",\"student_achievement\",\"extracurricular\",\"raport\",\"offline_payment\",\"online_payment\"]'),
('9d702e5b-bff8-44e9-9a8c-8f12dbae627a','0005ca5c-2ef5-e011-9d34-3d526be72c57','Nego','Normal','Basic',NULL);
/*!40000 ALTER TABLE `school_subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_assessment_details`
--

DROP TABLE IF EXISTS `student_assessment_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_assessment_details` (
  `student_assessment_id` varchar(36) NOT NULL,
  `student_id` varchar(36) NOT NULL,
  `point` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_assessment_details`
--

LOCK TABLES `student_assessment_details` WRITE;
/*!40000 ALTER TABLE `student_assessment_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_assessment_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_assessments`
--

DROP TABLE IF EXISTS `student_assessments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_assessments` (
  `id` varchar(36) NOT NULL,
  `teacher_id` varchar(36) NOT NULL,
  `class_id` varchar(36) NOT NULL,
  `course_id` varchar(36) NOT NULL,
  `date` date NOT NULL,
  `kind` enum('Sumatif','SAS') NOT NULL,
  `tp_lm` int(11) NOT NULL,
  `course_topic_id` varchar(36) NOT NULL,
  `pass_limit` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_assessments`
--

LOCK TABLES `student_assessments` WRITE;
/*!40000 ALTER TABLE `student_assessments` DISABLE KEYS */;
INSERT INTO `student_assessments` VALUES
('18a503c2-1388-41be-9c1d-ef6675cb57f5','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','30548357-bb60-11f0-8be0-d0008dc32c8f','82d04c26-ba0c-4e62-9f79-eb0f980024e5','2026-06-18','Sumatif',1,'09f547c4-1987-11f1-8ba8-61d509ac4659',70,'2026-06-16 05:54:39','2026-06-16 05:54:39',NULL),
('f802c9e8-e352-4e68-861a-6f6dac1e4c94','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','30548357-bb60-11f0-8be0-d0008dc32c8f','82d04c26-ba0c-4e62-9f79-eb0f980024e5','2026-06-18','Sumatif',1,'f8b357cd-a6c0-4090-8ba1-0ae9cbcba9ff',65,'2026-06-18 14:44:34','2026-06-18 14:44:34',NULL);
/*!40000 ALTER TABLE `student_assessments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_attendance_details`
--

DROP TABLE IF EXISTS `student_attendance_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_attendance_details` (
  `student_attendance_id` varchar(36) NOT NULL,
  `student_id` varchar(36) NOT NULL,
  `kind` enum('Hadir','Sakit','Izin','Alpha','Telat','Haid') NOT NULL,
  PRIMARY KEY (`student_attendance_id`,`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_attendance_details`
--

LOCK TABLES `student_attendance_details` WRITE;
/*!40000 ALTER TABLE `student_attendance_details` DISABLE KEYS */;
INSERT INTO `student_attendance_details` VALUES
('017ffa2c-cdf6-4b81-8cc8-801666039ad8','181eed5e-bc92-11f0-8ff6-9efd1c949119','Hadir'),
('017ffa2c-cdf6-4b81-8cc8-801666039ad8','ade39ae6-0a74-4aa6-8469-332338c67f5a','Hadir'),
('1dd57cdb-8ad2-400f-92bd-3a80319458cd','181eed5e-bc92-11f0-8ff6-9efd1c949119','Hadir'),
('1dd57cdb-8ad2-400f-92bd-3a80319458cd','3c60f715-d997-11f0-8cda-5bb67e5632f8','Sakit'),
('1dd57cdb-8ad2-400f-92bd-3a80319458cd','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','Hadir'),
('1dd57cdb-8ad2-400f-92bd-3a80319458cd','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','Hadir'),
('1dd57cdb-8ad2-400f-92bd-3a80319458cd','bcaf2469-4320-4f0b-a8ee-585a8f9d5747','Hadir'),
('1dd57cdb-8ad2-400f-92bd-3a80319458cd','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119','Izin'),
('1dd57cdb-8ad2-400f-92bd-3a80319458cd','cdc43038-bcb3-11f0-8ff6-9efd1c949119','Hadir'),
('c01a6531-ddbe-4d1e-baa9-299417dfd4f2','181eed5e-bc92-11f0-8ff6-9efd1c949119','Haid'),
('c01a6531-ddbe-4d1e-baa9-299417dfd4f2','ade39ae6-0a74-4aa6-8469-332338c67f5a','Hadir'),
('efca6b8a-b35c-4c8b-b538-bc06f2e6aa34','181eed5e-bc92-11f0-8ff6-9efd1c949119','Hadir'),
('efca6b8a-b35c-4c8b-b538-bc06f2e6aa34','3c60f715-d997-11f0-8cda-5bb67e5632f8','Hadir'),
('efca6b8a-b35c-4c8b-b538-bc06f2e6aa34','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','Hadir'),
('efca6b8a-b35c-4c8b-b538-bc06f2e6aa34','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','Hadir'),
('efca6b8a-b35c-4c8b-b538-bc06f2e6aa34','bcaf2469-4320-4f0b-a8ee-585a8f9d5747','Hadir'),
('efca6b8a-b35c-4c8b-b538-bc06f2e6aa34','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119','Hadir'),
('efca6b8a-b35c-4c8b-b538-bc06f2e6aa34','cdc43038-bcb3-11f0-8ff6-9efd1c949119','Hadir');
/*!40000 ALTER TABLE `student_attendance_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_attendances`
--

DROP TABLE IF EXISTS `student_attendances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_attendances` (
  `id` varchar(36) NOT NULL,
  `teacher_id` varchar(36) NOT NULL,
  `class_id` varchar(36) NOT NULL,
  `course_id` varchar(36) NOT NULL,
  `date` date NOT NULL,
  `slot_number` int(11) NOT NULL,
  `course_topic_id` varchar(36) NOT NULL,
  `materi` text NOT NULL,
  `photo` varchar(512) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_attendances`
--

LOCK TABLES `student_attendances` WRITE;
/*!40000 ALTER TABLE `student_attendances` DISABLE KEYS */;
INSERT INTO `student_attendances` VALUES
('017ffa2c-cdf6-4b81-8cc8-801666039ad8','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','30548357-bb60-11f0-8be0-d0008dc32c8f','82d04c26-ba0c-4e62-9f79-eb0f980024e5','2026-05-16',1,'09f547c4-1987-11f1-8ba8-61d509ac4659','MOOO','satt_455a9693-8fdb-4c9b-aa11-72e692ba1760.jpeg','2026-05-16 00:01:28','2026-05-16 00:01:28',NULL),
('1dd57cdb-8ad2-400f-92bd-3a80319458cd','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','82d04c26-ba0c-4e62-9f79-eb0f980024e5','2026-05-16',5,'09f547c4-1987-11f1-8ba8-61d509ac4659','Edit 2',NULL,'2026-03-09 17:45:44','2026-03-09 17:45:44',NULL),
('c01a6531-ddbe-4d1e-baa9-299417dfd4f2','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','30548357-bb60-11f0-8be0-d0008dc32c8f','82d04c26-ba0c-4e62-9f79-eb0f980024e5','2026-06-20',1,'09f547c4-1987-11f1-8ba8-61d509ac4659','MMM',NULL,'2026-06-20 02:29:17','2026-06-20 02:29:17',NULL),
('efca6b8a-b35c-4c8b-b538-bc06f2e6aa34','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','620f5ad2-bb60-11f0-8be0-d0008dc32c8f','47bcdeda-afef-42bf-8b6b-780f29e15d6f','2026-03-10',6,'','',NULL,'2026-03-09 17:47:19','2026-03-09 17:47:19',NULL);
/*!40000 ALTER TABLE `student_attendances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_tahfidz_progresses`
--

DROP TABLE IF EXISTS `student_tahfidz_progresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_tahfidz_progresses` (
  `id` varchar(36) NOT NULL,
  `student_id` varchar(36) NOT NULL,
  `year_id` varchar(36) NOT NULL,
  `progress` double NOT NULL,
  `avg_tajwid` double NOT NULL,
  `avg_makhroj` double NOT NULL,
  `avg_kelancaran` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_tahfidz_progresses`
--

LOCK TABLES `student_tahfidz_progresses` WRITE;
/*!40000 ALTER TABLE `student_tahfidz_progresses` DISABLE KEYS */;
INSERT INTO `student_tahfidz_progresses` VALUES
('1813650b-40ed-47ab-9071-ad635f36b72f','687360ac-ce0d-4b3e-a035-bb27f7ccfc77','c02187d2-bfd2-11f0-8d7c-cdee4485d186',1.7730496453900708,7,7,7,'2026-07-09 01:20:39','2026-07-09 01:20:39',NULL),
('43938bff-a9a8-46b0-a11c-887e1d425e29','508a76f9-4bad-4fa4-a2a0-b49dbb52e92f','c02187d2-bfd2-11f0-8d7c-cdee4485d186',11.52482269503546,7,7,7,'2026-07-04 05:53:14','2026-07-04 05:53:14',NULL),
('46c66ac8-c872-41dc-b966-7de3d3e5971c','181eed5e-bc92-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186',10.191387559808613,8,8.038461538461538,6.769230769230769,'2026-03-09 20:12:49','2026-03-09 20:12:49',NULL),
('6b1365cc-afe4-44cc-8efc-42c66eda3488','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186',6.205673758865248,7.333333333333333,7.333333333333333,7.333333333333333,'2025-12-28 12:19:28','2025-12-28 12:19:28',NULL),
('6ccfa333-d997-11f0-8cda-5bb67e5632f8','3c60f715-d997-11f0-8cda-5bb67e5632f8','c02187d2-bfd2-11f0-8d7c-cdee4485d186',5.009727626459144,8.052631578947368,7.947368421052632,5.947368421052632,'2025-12-15 09:21:23','2025-12-15 09:21:23',NULL),
('7601e2ec-4a80-4b44-a36d-d48552e0d782','cdc42669-bcb3-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186',3.0162412993039442,9,9,5,'2026-04-20 17:28:02','2026-04-20 17:28:02',NULL),
('866a9403-69fb-4eb8-91f4-df7c5a2f71a2','bcaf2469-4320-4f0b-a8ee-585a8f9d5747','c02187d2-bfd2-11f0-8d7c-cdee4485d186',3.368794326241135,9,9,5,'2026-04-20 17:03:48','2026-04-20 17:03:48',NULL),
('9e8f5f62-196e-4712-a360-3cf88583dea6','b31b930f-74e4-48ca-9b60-b2fe6a5ffc38','c02187d2-bfd2-11f0-8d7c-cdee4485d186',3.54066985645933,8,8,6,'2026-05-21 14:19:56','2026-05-21 14:19:56',NULL),
('a1b8c501-be30-4219-b039-5c46968fbdaa','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186',8.900778210116732,7.267605633802817,7.225352112676056,5.549295774647887,'2026-03-09 20:09:03','2026-03-09 20:09:03',NULL),
('aff0068e-a619-442a-8859-69a9eeea5f80','7c923100-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186',3.473132372214941,7,7,7,'2026-06-29 13:57:43','2026-06-29 13:57:43',NULL),
('b650b858-dd81-11f0-8c80-c3be70f67f99','cdc43038-bcb3-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186',18.79432624113475,7.4,7.4,7.4,'2025-12-20 08:56:02','2025-12-20 08:56:02',NULL),
('bd302c7a-d8dc-11f0-8cc6-5aaf60d1f765','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186',7.323943661971831,7.297297297297297,7.216216216216216,5.891891891891892,'2025-12-14 11:05:02','2025-12-14 11:05:02',NULL),
('dd98efca-d840-11f0-90f5-38fd4d89c951','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186',26.95035460992908,7.196969696969697,7.106060606060606,5.5606060606060606,'2025-12-13 16:29:15','2025-12-13 16:29:15',NULL),
('f05ec875-d996-11f0-8cda-5bb67e5632f8','181eed5e-bc92-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186',15.425531914893616,8.466666666666667,8.533333333333333,6.866666666666666,'2025-12-15 09:17:54','2025-12-15 09:17:54',NULL);
/*!40000 ALTER TABLE `student_tahfidz_progresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `students` (
  `id` varchar(36) NOT NULL,
  `user_id` varchar(36) DEFAULT NULL,
  `school_id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `nis` varchar(255) NOT NULL,
  `sex` enum('M','F') NOT NULL,
  `dob` date NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `parent_name` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `school_id` (`school_id`,`nis`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES
('181eed5e-bc92-11f0-8ff6-9efd1c949119',NULL,'582e4596-bb5b-11f0-8be0-d0008dc32c8f','Ramdasyah Yahya Axel Malik','10009','M','2026-01-01','prof_7dcbfedf-79cc-4d2f-a9d9-097f8d1a7b70.png','','2025-11-08 11:00:10','2025-11-08 11:00:10',NULL),
('25cbd15f-7be5-444a-b3ce-4d365523ad7d',NULL,'582e4596-bb5b-11f0-8be0-d0008dc32c8f','Melati Jusuf','444222','M','2026-07-09',NULL,'Ky','2026-07-08 11:40:09','2026-07-08 11:40:09',NULL),
('2bea7bf8-e0a0-4381-9fce-e3ebd436ce8a',NULL,'582e4596-bb5b-11f0-8be0-d0008dc32c8f','Danial Slamet','444111','F','2026-07-09',NULL,'Jx','2026-07-08 11:40:09','2026-07-08 11:40:09',NULL),
('3c60f715-d997-11f0-8cda-5bb67e5632f8',NULL,'582e4596-bb5b-11f0-8be0-d0008dc32c8f','Ladysa Khalinsyah Athani','10077','F','2025-12-15',NULL,'','2025-11-08 11:00:10','2025-11-08 11:00:10',NULL),
('40874588-f436-4d59-a9e2-48b9bebe563d',NULL,'582e4596-bb5b-11f0-8be0-d0008dc32c8f','Si Punya Banyak','123123123','M','2026-07-17',NULL,'Pasty','2026-07-17 06:18:17','2026-07-17 06:18:17',NULL),
('430a4b9f-b7e3-42ef-bea7-344bc3c648e5',NULL,'8061ca5c-2ef5-e011-ad7e-ffe7f6f833dd','Benjoel','1234','M','2026-02-11',NULL,'Mr X','2026-02-21 22:28:47','2026-02-21 22:28:47',NULL),
('508a76f9-4bad-4fa4-a2a0-b49dbb52e92f',NULL,'582e4596-bb5b-11f0-8be0-d0008dc32c8f','Foo Moes','121212','F','2001-10-10',NULL,'Marjan','2026-01-28 15:50:19','2026-01-28 15:50:19',NULL),
('598f3241-bc5f-11f0-8b9c-41333d9a4eb4',NULL,'582e4596-bb5b-11f0-8be0-d0008dc32c8f','Joe Siagara','10001','M','2025-12-01','prof_b68c545a-d909-4c47-9cb8-6731b41840c0.png','X','2025-11-08 04:56:55','2025-11-08 04:56:55',NULL),
('683cafdd-bc5f-11f0-8b9c-41333d9a4eb4',NULL,'582e4596-bb5b-11f0-8be0-d0008dc32c8f','VIcky Boeng','10002','M','2025-12-01','prof_12330d65-4636-4fd4-a89e-6fe9a76a4b88.png','','2025-11-08 04:57:20','2025-11-08 04:57:20',NULL),
('687360ac-ce0d-4b3e-a035-bb27f7ccfc77',NULL,'0005ed5c-2ef5-e011-9fee-6124ccb9e3de','Si Siswa 1','111111','M','2026-07-09',NULL,'Bu XXX','2026-07-09 00:59:22','2026-07-09 00:59:22',NULL),
('7c923100-bc5f-11f0-8b9c-41333d9a4eb4',NULL,'582e4596-bb5b-11f0-8be0-d0008dc32c8f','Fee Moe','10003','M','2025-12-01',NULL,'','2025-11-08 04:57:54','2025-11-08 04:57:54',NULL),
('83458f40-9fea-4bb3-8cad-786a5115082b',NULL,'582e4596-bb5b-11f0-8be0-d0008dc32c8f','Gendoes Suroto','212121','M','2026-06-25',NULL,'Pak Suroto','2026-06-25 10:38:24','2026-06-25 10:38:24',NULL),
('9ce766ec-7fab-4fc2-becf-9a03a430ca70',NULL,'582e4596-bb5b-11f0-8be0-d0008dc32c8f','Kemayoran','20001','M','2001-10-10',NULL,'Koo','2026-01-28 15:52:41','2026-01-28 15:52:41',NULL),
('a8262175-69d1-484b-a1d1-4e8bb30ed704',NULL,'582e4596-bb5b-11f0-8be0-d0008dc32c8f','Ganyang','909090','M','2026-07-16',NULL,'w','2026-07-13 09:54:02','2026-07-13 09:54:02',NULL),
('ade39ae6-0a74-4aa6-8469-332338c67f5a',NULL,'582e4596-bb5b-11f0-8be0-d0008dc32c8f','Praha','30001','M','2000-10-10',NULL,'Bromo','2026-01-25 12:46:43','2026-01-25 12:46:43',NULL),
('b149abd8-87a1-404d-b6ca-e639d7d13e36',NULL,'582e4596-bb5b-11f0-8be0-d0008dc32c8f','Citra Mohamad','444444','M','2026-07-09',NULL,'Xx','2026-07-08 11:40:09','2026-07-08 11:40:09',NULL),
('b31b930f-74e4-48ca-9b60-b2fe6a5ffc38',NULL,'582e4596-bb5b-11f0-8be0-d0008dc32c8f','Sindoro Sumbing','09090','M','2026-01-02',NULL,'Mustard','2026-01-25 12:16:46','2026-01-25 12:16:46',NULL),
('bcaf2469-4320-4f0b-a8ee-585a8f9d5747',NULL,'582e4596-bb5b-11f0-8be0-d0008dc32c8f','Frea Linda','300000','F','2026-07-09',NULL,'Floomy','2026-01-25 12:46:43','2026-01-25 12:46:43',NULL),
('c9746ea1-0524-4577-baf7-71f6311a4789',NULL,'582e4596-bb5b-11f0-8be0-d0008dc32c8f','Utari Daud','444333','F','2026-07-09',NULL,'Hu','2026-07-08 11:40:09','2026-07-08 11:40:09',NULL),
('cdc42669-bcb3-11f0-8ff6-9efd1c949119',NULL,'582e4596-bb5b-11f0-8be0-d0008dc32c8f','Janoko Manungging Suka Makan Permen','10010','M','2026-01-01',NULL,'Pak Pundhel','2025-11-08 15:01:28','2025-11-08 15:01:28',NULL),
('cdc42a1e-bcb3-11f0-8ff6-9efd1c949119',NULL,'582e4596-bb5b-11f0-8be0-d0008dc32c8f','Bukain Aja','10011','M','2026-01-01',NULL,'Rokumin','2025-11-08 15:01:29','2025-11-08 15:01:28',NULL),
('cdc43038-bcb3-11f0-8ff6-9efd1c949119',NULL,'582e4596-bb5b-11f0-8be0-d0008dc32c8f','Ben Torfold','10012','M','2026-01-08',NULL,'Bang Ladesh','2025-11-08 15:01:30','2025-11-08 15:01:28',NULL),
('decd6e92-8608-41c5-a1de-0a7cab1978ca',NULL,'0001795c-2ef5-e011-a96c-63a882fbcc5a','Si Satu','1','M','2026-05-14',NULL,'AAA','2026-05-16 06:44:39','2026-05-16 06:44:39',NULL),
('ebbd479d-1520-48f6-b0c8-67c1dd6a77f6',NULL,'8061ca5c-2ef5-e011-ad7e-ffe7f6f833dd','SI NIS Sama','20001','M','2001-10-10',NULL,'Markaban','2026-05-17 00:38:13','2026-05-17 00:38:13',NULL),
('fd114d2d-6cf5-4b7d-8474-99104308b6a0',NULL,'28c25337-f7f7-43cd-aeb7-e80b6e3a35f0','Si Punya Banyak','123123123','M','2026-07-17',NULL,'Pasty','2026-07-17 06:18:39','2026-07-17 06:18:39',NULL);
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tahfidz_proposals`
--

DROP TABLE IF EXISTS `tahfidz_proposals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tahfidz_proposals` (
  `id` varchar(36) NOT NULL,
  `student_id` varchar(36) NOT NULL,
  `year_id` varchar(36) NOT NULL,
  `start_surat` int(11) NOT NULL,
  `start_ayat` int(11) NOT NULL,
  `end_surat` int(11) NOT NULL,
  `end_ayat` int(11) NOT NULL,
  `count_ayat` int(11) NOT NULL,
  `note` text DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tahfidz_proposals`
--

LOCK TABLES `tahfidz_proposals` WRITE;
/*!40000 ALTER TABLE `tahfidz_proposals` DISABLE KEYS */;
/*!40000 ALTER TABLE `tahfidz_proposals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tahfidz_schedules`
--

DROP TABLE IF EXISTS `tahfidz_schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tahfidz_schedules` (
  `id` varchar(36) NOT NULL,
  `school_id` varchar(36) NOT NULL,
  `level` int(11) NOT NULL,
  `day` int(11) NOT NULL,
  `hour_start` time NOT NULL,
  `hour_end` time NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tahfidz_schedules`
--

LOCK TABLES `tahfidz_schedules` WRITE;
/*!40000 ALTER TABLE `tahfidz_schedules` DISABLE KEYS */;
INSERT INTO `tahfidz_schedules` VALUES
('0b8ace4e-c93d-11f0-915c-67eb632cb60c','582e4596-bb5b-11f0-8be0-d0008dc32c8f',10,2,'10:00:00','12:00:00','2025-11-24 13:53:59','2025-11-24 13:53:59',NULL),
('1772519d-c872-11f0-8c98-e15401092bbd','582e4596-bb5b-11f0-8be0-d0008dc32c8f',7,3,'15:00:00','14:30:00','2025-11-23 13:41:19','2025-11-23 13:41:19',NULL),
('1ebeaa70-c872-11f0-8c98-e15401092bbd','582e4596-bb5b-11f0-8be0-d0008dc32c8f',7,1,'10:00:00','12:00:00','2025-11-23 13:41:31','2025-11-23 13:41:31',NULL),
('7948b5c5-c872-11f0-8c98-e15401092bbd','582e4596-bb5b-11f0-8be0-d0008dc32c8f',8,4,'10:00:00','12:00:00','2025-11-23 13:44:03','2025-11-23 13:44:03',NULL),
('7e0296cd-c872-11f0-8c98-e15401092bbd','582e4596-bb5b-11f0-8be0-d0008dc32c8f',8,2,'10:00:00','11:00:00','2025-11-23 13:44:11','2025-11-23 13:44:11',NULL);
/*!40000 ALTER TABLE `tahfidz_schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tahfidz_targets`
--

DROP TABLE IF EXISTS `tahfidz_targets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tahfidz_targets` (
  `id` varchar(36) NOT NULL,
  `school_id` varchar(36) NOT NULL,
  `year_id` varchar(36) NOT NULL,
  `halaqoh_id` varchar(36) NOT NULL,
  `student_id` varchar(36) DEFAULT NULL,
  `tahfidz_type` text DEFAULT NULL,
  `type` enum('Juz','Surat') NOT NULL,
  `start` int(11) NOT NULL,
  `end` int(11) NOT NULL,
  `mode` enum('forward','surat_backward','ayat_backward') NOT NULL,
  `priority` int(11) NOT NULL,
  `target_count` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tahfidz_targets`
--

LOCK TABLES `tahfidz_targets` WRITE;
/*!40000 ALTER TABLE `tahfidz_targets` DISABLE KEYS */;
INSERT INTO `tahfidz_targets` VALUES
('0238a434-4633-4d46-95ca-af114a137d19','582e4596-bb5b-11f0-8be0-d0008dc32c8f','c02187d2-bfd2-11f0-8d7c-cdee4485d186','79711f34-ae89-4dfe-9cc3-f4462e902c0b',NULL,'Ziyadah','Juz',5,5,'forward',0,124,'2026-07-03 14:11:16','2026-07-03 14:11:16',NULL),
('0ae13cad-6bc6-4d0e-9767-cbc8c9f748de','0005ed5c-2ef5-e011-9fee-6124ccb9e3de','c02187d2-bfd2-11f0-8d7c-cdee4485d186','63494cbb-8bc7-4dde-b72b-6959b56207e2',NULL,'Ziyadah,Tilawah','Juz',30,30,'forward',0,564,'2026-07-09 01:20:20','2026-07-09 01:20:20',NULL),
('27aa6f51-05cb-4935-8048-76c049fa70e8','582e4596-bb5b-11f0-8be0-d0008dc32c8f','c02187d2-bfd2-11f0-8d7c-cdee4485d186','13471ea9-4a66-47e4-8043-dc575dd8d716','bcaf2469-4320-4f0b-a8ee-585a8f9d5747','Ziyadah,Tahsin','Surat',1,1,'forward',0,7,'2026-07-04 00:13:39','2026-07-04 00:13:39',NULL),
('511063b6-59e7-405e-8d75-ddbb21cbcc99','582e4596-bb5b-11f0-8be0-d0008dc32c8f','c02187d2-bfd2-11f0-8d7c-cdee4485d186','79711f34-ae89-4dfe-9cc3-f4462e902c0b','3c60f715-d997-11f0-8cda-5bb67e5632f8','Ziyadah','Juz',1,3,'forward',0,385,'2026-07-04 05:43:49','2026-07-04 05:43:49',NULL),
('7182ab75-815e-467e-9a02-7a373553f9b2','582e4596-bb5b-11f0-8be0-d0008dc32c8f','c02187d2-bfd2-11f0-8d7c-cdee4485d186','166044ae-3a65-487c-8af5-8ca6bc5bb24a','181eed5e-bc92-11f0-8ff6-9efd1c949119','Ziyadah,Tilawah','Surat',4,4,'forward',0,176,'2026-07-04 03:53:05','2026-07-04 03:53:05',NULL),
('75eca98e-83d0-4098-b76a-1450e20a4cd9','582e4596-bb5b-11f0-8be0-d0008dc32c8f','c02187d2-bfd2-11f0-8d7c-cdee4485d186','13471ea9-4a66-47e4-8043-dc575dd8d716','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119','Ziyadah,Tahsin','Juz',30,30,'surat_backward',0,564,'2026-07-04 00:13:39','2026-07-04 00:13:39',NULL),
('773e09c8-cdf4-40c0-b29c-0c1496ee41f3','582e4596-bb5b-11f0-8be0-d0008dc32c8f','c02187d2-bfd2-11f0-8d7c-cdee4485d186','166044ae-3a65-487c-8af5-8ca6bc5bb24a',NULL,'Tahsin','Juz',5,8,'forward',0,525,'2026-07-03 14:11:16','2026-07-03 14:11:16',NULL),
('985cb1a3-ffc2-4d26-9a83-8895ddffa8a2','582e4596-bb5b-11f0-8be0-d0008dc32c8f','c02187d2-bfd2-11f0-8d7c-cdee4485d186','13471ea9-4a66-47e4-8043-dc575dd8d716',NULL,'Ziyadah','Juz',1,1,'forward',2,148,'2026-07-03 13:05:23','2026-07-03 13:05:23',NULL),
('a3045ddb-ec3b-45e2-b233-ceb8ed6a0877','582e4596-bb5b-11f0-8be0-d0008dc32c8f','c02187d2-bfd2-11f0-8d7c-cdee4485d186','13471ea9-4a66-47e4-8043-dc575dd8d716','cdc43038-bcb3-11f0-8ff6-9efd1c949119','Ziyadah,Tahsin','Surat',2,2,'forward',0,286,'2026-07-04 00:13:39','2026-07-04 00:13:39',NULL),
('cbccd74a-3f97-410e-a6d5-b7b6edd2bcb4','582e4596-bb5b-11f0-8be0-d0008dc32c8f','c02187d2-bfd2-11f0-8d7c-cdee4485d186','166044ae-3a65-487c-8af5-8ca6bc5bb24a','9ce766ec-7fab-4fc2-becf-9a03a430ca70','Ziyadah,Tilawah','Surat',4,4,'forward',0,176,'2026-07-04 03:53:05','2026-07-04 03:53:05',NULL),
('e78ab609-a24c-4814-93af-c609d7885750','582e4596-bb5b-11f0-8be0-d0008dc32c8f','c02187d2-bfd2-11f0-8d7c-cdee4485d186','13471ea9-4a66-47e4-8043-dc575dd8d716','508a76f9-4bad-4fa4-a2a0-b49dbb52e92f','Ziyadah','Juz',30,30,'forward',0,564,'2026-07-04 00:13:39','2026-07-04 00:13:39',NULL);
/*!40000 ALTER TABLE `tahfidz_targets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tahfidzs`
--

DROP TABLE IF EXISTS `tahfidzs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tahfidzs` (
  `id` varchar(36) NOT NULL,
  `student_id` varchar(36) NOT NULL,
  `year_id` varchar(36) NOT NULL,
  `type` enum('Ziyadah','Murojaah','Tahsin') NOT NULL,
  `start_surat` int(11) NOT NULL,
  `start_ayat` int(11) NOT NULL,
  `end_surat` int(11) NOT NULL,
  `end_ayat` int(11) NOT NULL,
  `count_ayat` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `tajwid` int(11) NOT NULL,
  `makhroj` int(11) NOT NULL,
  `kelancaran` int(11) NOT NULL,
  `redo` tinyint(1) NOT NULL DEFAULT 0,
  `teacher_id` varchar(36) NOT NULL,
  `teacher_feedback` mediumtext DEFAULT NULL,
  `parent_feedback` mediumtext DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tahfidzs`
--

LOCK TABLES `tahfidzs` WRITE;
/*!40000 ALTER TABLE `tahfidzs` DISABLE KEYS */;
INSERT INTO `tahfidzs` VALUES
('01ed0e9d-a305-47a5-b125-1c577b321263','3c60f715-d997-11f0-8cda-5bb67e5632f8','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',109,1,109,6,6,'2026-01-28 13:36:57',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-01-28 13:36:57','2026-01-28 13:36:57',NULL),
('04c70633-db1c-11f0-90dd-db305d423542','181eed5e-bc92-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',114,4,114,4,1,'2025-12-17 07:43:03',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-17 07:43:03','2025-12-17 07:43:03',NULL),
('06241284-4640-40b2-94f5-01ac02c2d21d','3c60f715-d997-11f0-8cda-5bb67e5632f8','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',105,1,105,5,5,'2026-01-28 13:59:50',9,9,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Sudah bagus, tapi jangan berhenti menjadi lebih baik',NULL,'2026-01-28 13:59:50','2026-01-28 13:59:50',NULL),
('065623f1-dfed-4b2f-8a01-a47f051c1175','3c60f715-d997-11f0-8cda-5bb67e5632f8','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',102,1,103,3,11,'2026-06-14 03:08:34',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-06-14 03:08:34','2026-06-14 03:08:34',NULL),
('08249653-dbbe-4a3a-a4bd-97d64fb438f7','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Tahsin',2,253,2,254,2,'2026-06-14 03:07:23',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-06-14 03:07:23','2026-06-14 03:07:23',NULL),
('0846f3e1-63aa-446b-beb2-6cdb06fd72e8','3c60f715-d997-11f0-8cda-5bb67e5632f8','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',111,1,111,5,5,'2026-01-28 13:28:49',7,7,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Teruslah berlatih, karena setiap pengulangan mendekatkanmu pada sempurna',NULL,'2026-01-28 13:28:49','2026-01-28 13:28:49',NULL),
('0878e577-d941-412f-926f-0173e04477cc','181eed5e-bc92-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',108,1,107,7,10,'2026-01-28 13:30:44',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-01-28 13:30:44','2026-01-28 13:30:44',NULL),
('08fbe9e1-6cf2-4ee6-8c7d-893b525f3e3b','181eed5e-bc92-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',2,3,2,4,2,'2026-06-13 09:47:56',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-06-13 09:47:56','2026-06-13 09:47:56',NULL),
('0938f46a-4a97-4a7e-b443-7fa5648db7c8','181eed5e-bc92-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',101,1,101,11,11,'2026-02-02 13:39:37',9,9,6,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-02-02 13:39:37','2026-02-02 13:39:37',NULL),
('0a3afa0b-5347-49e8-8ee3-cda0c24b7f3d','3c60f715-d997-11f0-8cda-5bb67e5632f8','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',108,1,108,3,3,'2026-01-28 13:40:15',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','BAGUSSSSSSSSS',NULL,'2026-01-28 13:40:15','2026-01-28 13:40:15',NULL),
('0ce78ec0-e85b-40d4-8319-9e0e51f0828c','181eed5e-bc92-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Tahsin',2,1,2,3,3,'2026-06-25 22:51:43',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-06-25 22:51:43','2026-06-25 22:51:43',NULL),
('0d7c77fe-d0f2-4325-91db-62a30499df03','181eed5e-bc92-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',2,5,2,5,1,'2026-06-13 09:49:23',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-06-13 09:49:23','2026-06-13 09:49:23',NULL),
('0e2ee51a-a5a8-42d9-9398-caad89aae011','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',100,1,100,1,1,'2026-02-01 22:51:02',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-02-01 22:51:02','2026-02-01 22:51:02',NULL),
('10e4654f-1111-43e2-bef4-15efe26f4622','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',100,2,100,2,1,'2026-01-15 16:22:47',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Tetap semangat yaTingkatkan hafalanBagusTingkatkan hafalanTetap semangat yaTetap semangat yaTingkatkan hafalanTingkatkan hafalan',NULL,'2026-01-15 16:22:47','2026-01-15 16:22:47',NULL),
('10fb03c2-3575-4f47-b54f-b69c027cf772','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',101,3,101,3,1,'2025-12-28 09:43:45',5,5,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','','Baik bu','2025-12-28 09:43:45','2025-12-28 09:43:45',NULL),
('12a20cf6-2ef5-4ab8-8a72-3aff5996ec06','3c60f715-d997-11f0-8cda-5bb67e5632f8','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',114,1,114,6,6,'2026-01-28 13:19:05',7,7,3,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Tidak apa-apa salah, yang penting terus belajar dan memperbaiki',NULL,'2026-01-28 13:19:05','2026-01-28 13:19:05',NULL),
('16ac4046-d977-11f0-8cda-5bb67e5632f8','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',110,3,110,3,1,'2025-12-15 05:29:55',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','','Feed','2025-12-15 05:29:55','2025-12-15 05:29:55',NULL),
('17b0b0e6-fed5-4379-ba73-dde84da1fac5','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',103,2,103,2,1,'2025-12-27 21:55:30',5,5,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-27 21:55:30','2025-12-27 21:55:30',NULL),
('17df9332-244a-491b-8be9-4edb0db77669','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',99,1,99,8,8,'2026-05-07 17:26:14',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-05-07 17:26:14','2026-05-07 17:26:14',NULL),
('187021d5-64da-466f-a8cd-f2616d6e5da1','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',101,6,101,6,1,'2025-12-28 09:50:17',5,5,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-28 09:50:17','2025-12-28 09:50:17',NULL),
('1af26b48-b010-4d0f-9d94-256f76cd6bdb','181eed5e-bc92-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',80,29,80,29,1,'2026-07-03 06:31:07',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-07-03 06:31:07','2026-07-03 06:31:07',NULL),
('1c7027eb-53b6-4507-948c-f3409ff1d195','181eed5e-bc92-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',78,1,78,2,2,'2026-03-09 20:12:49',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-03-09 20:12:49','2026-03-09 20:12:49',NULL),
('1cd3850c-e0f3-11f0-8cf3-14525ee252f4','cdc43038-bcb3-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',112,2,112,3,2,'2025-12-24 18:05:21',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-24 18:05:21','2025-12-24 18:05:21',NULL),
('1ffc4e00-e6a9-442c-8df8-116cc67d2a62','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',99,8,99,8,1,'2026-02-01 22:10:41',9,9,5,0,'9310ee0e-bcb1-11f0-8ff6-9efd1c949119','',NULL,'2026-02-01 22:10:41','2026-02-01 22:10:41',NULL),
('20596c3c-d8dc-11f0-8cc6-5aaf60d1f765','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',111,1,111,5,5,'2025-12-14 11:00:39',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-14 11:00:39','2025-12-14 11:00:39',NULL),
('23d507e3-d977-11f0-8cda-5bb67e5632f8','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',109,1,109,1,1,'2025-12-15 05:30:17',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-15 05:30:17','2025-12-15 05:30:17',NULL),
('25a79294-c44f-4718-bb81-26508d0bb1f6','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',95,6,95,6,1,'2026-05-11 13:44:39',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-05-11 13:44:39','2026-05-11 13:44:39',NULL),
('265041f2-3057-4644-9df3-2325f7273d43','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',102,2,102,2,1,'2025-12-27 22:02:34',5,5,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-27 22:02:34','2025-12-27 22:02:34',NULL),
('266f9ac6-2092-4bc0-84b8-85a440b6537f','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',100,3,100,3,1,'2026-01-15 16:49:13',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Tidak apa-apa salah, yang penting terus belajar dan memperbaiki',NULL,'2026-01-15 16:49:13','2026-01-15 16:49:13',NULL),
('27570811-6c6d-4504-9ef4-57714604ce3a','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',95,5,95,5,1,'2026-05-11 13:41:08',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','HUHU',NULL,'2026-05-11 13:41:08','2026-05-11 13:41:08',NULL),
('29aec52d-13e5-4a51-a08a-c85848d6c00e','508a76f9-4bad-4fa4-a2a0-b49dbb52e92f','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',78,1,79,3,43,'2026-07-04 05:53:14',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-07-04 05:53:14','2026-07-04 05:53:14',NULL),
('2b17bbf7-dd7a-11f0-8c80-c3be70f67f99','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',106,1,104,2,11,'2025-12-20 08:02:02',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Catatanku','Iya bu','2025-12-20 08:02:02','2025-12-20 08:02:02',NULL),
('2c422a6f-ca63-4e39-98d3-114e96e1ab4b','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',101,8,101,8,1,'2025-12-28 09:59:34',10,9,9,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Bagus',NULL,'2025-12-28 09:59:34','2025-12-28 09:59:34',NULL),
('2c9fe7f3-a61d-4967-a568-9e9bf351d3fa','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',78,16,78,28,13,'2026-03-09 20:09:52',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-03-09 20:09:52','2026-03-09 20:09:52',NULL),
('2cc0a365-b3d7-46c6-a25e-a99b760315ab','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',101,6,101,6,1,'2025-12-28 09:49:52',5,5,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-28 09:49:52','2025-12-28 09:49:52',NULL),
('2dc3d262-426f-4953-a274-99042c85ca4e','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',102,6,102,6,1,'2025-12-27 22:09:07',5,5,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-27 22:09:07','2025-12-27 22:09:07',NULL),
('300e8e45-e031-43b9-b8b7-43b3d95fe666','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',95,1,95,4,4,'2026-05-11 13:38:02',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-05-11 13:38:02','2026-05-11 13:38:02',NULL),
('31621629-13f6-46f4-b72c-0ebf2b4c7976','3c60f715-d997-11f0-8cda-5bb67e5632f8','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',104,1,104,9,9,'2026-01-28 14:04:37',9,9,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','terus belajar.',NULL,'2026-01-28 14:04:37','2026-01-28 14:04:37',NULL),
('35babe7d-b74d-4d7b-9e24-b808ee3434f2','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',102,7,102,7,1,'2025-12-27 22:16:01',5,5,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-27 22:16:01','2025-12-27 22:16:01',NULL),
('37b967cd-761c-4030-ba13-38ec0e729c48','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',114,1,113,5,11,'2025-12-28 12:19:28',9,9,9,0,'f82def14-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-28 12:19:28','2025-12-28 12:19:28',NULL),
('3941850f-504e-47ba-82cb-0603b38e3f7e','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',99,6,99,6,1,'2026-02-01 22:00:34',9,9,5,0,'9310ee0e-bcb1-11f0-8ff6-9efd1c949119','',NULL,'2026-02-01 22:00:34','2026-02-01 22:00:34',NULL),
('3a48b107-fb82-49b8-97b8-06850f7bcca5','b31b930f-74e4-48ca-9b60-b2fe6a5ffc38','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',101,3,101,6,4,'2026-06-29 14:14:45',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-06-29 14:14:45','2026-06-29 14:14:45',NULL),
('3a558f92-e0d1-11f0-8cf3-14525ee252f4','3c60f715-d997-11f0-8cda-5bb67e5632f8','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',67,1,67,2,2,'2025-12-24 14:02:47',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Lancar',NULL,'2025-12-24 14:02:47','2025-12-24 14:02:47',NULL),
('3b900db4-4ca7-4d57-80fb-e513d92b0a84','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',100,8,100,8,1,'2026-02-01 06:29:28',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-02-01 06:29:28','2026-02-01 06:29:28',NULL),
('3d51ade1-df5f-11f0-90ed-b264de2d43ca','181eed5e-bc92-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',112,2,112,4,3,'2025-12-22 17:54:19',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-22 17:54:19','2025-12-22 17:54:19',NULL),
('3ec24bd2-dd77-11f0-8c80-c3be70f67f99','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Murojaah',114,1,114,4,4,'2025-12-20 07:41:07',7,9,9,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','catatan\n',NULL,'2025-12-20 07:41:07','2025-12-20 07:41:07',NULL),
('4124827c-e526-4d0d-8e78-77bbe52827c9','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',98,1,98,1,1,'2026-02-17 04:33:38',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-02-17 04:33:38','2026-02-17 04:33:38',NULL),
('428c716d-d998-11f0-8cda-5bb67e5632f8','3c60f715-d997-11f0-8cda-5bb67e5632f8','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',113,2,113,5,4,'2025-12-15 09:27:22',6,7,4,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Kurang lancar',NULL,'2025-12-15 09:27:22','2025-12-15 09:27:22',NULL),
('43a63e90-c995-4561-8f93-33738eff5298','181eed5e-bc92-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',102,1,102,8,8,'2026-01-28 13:56:38',9,9,6,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Tetap semangat dan tingkatkan hafalan',NULL,'2026-01-28 13:56:38','2026-01-28 13:56:38',NULL),
('44fe06d5-d869-4669-8dee-904d102ec39a','bcaf2469-4320-4f0b-a8ee-585a8f9d5747','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',78,1,78,19,19,'2026-04-20 17:03:48',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-04-20 17:03:48','2026-04-20 17:03:48',NULL),
('45126b3b-f5c5-4ea2-9e52-2e123c851b47','3c60f715-d997-11f0-8cda-5bb67e5632f8','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',106,1,106,4,4,'2026-01-28 13:48:38',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-01-28 13:48:38','2026-01-28 13:48:38',NULL),
('4af79d18-e0cd-11f0-8cf3-14525ee252f4','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',104,5,104,7,3,'2025-12-24 13:34:37',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Okey','Alhamdulillah','2025-12-24 13:34:37','2025-12-24 13:34:37',NULL),
('4ef70e52-8e5e-41ff-b924-3a6b23bec642','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',102,1,102,1,1,'2025-12-27 21:58:38',5,5,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-27 21:58:38','2025-12-27 21:58:38',NULL),
('500f8d0c-a344-4e78-ba3a-49197400a2ec','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',101,4,101,4,1,'2025-12-28 09:46:57',5,5,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-28 09:46:57','2025-12-28 09:46:57',NULL),
('50e851a7-8a1d-4979-8a69-f5399d22c6bc','181eed5e-bc92-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',80,32,80,32,1,'2026-07-03 08:20:53',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-07-03 08:20:53','2026-07-03 08:20:53',NULL),
('51cd419b-5fae-4b83-b04b-8edababd1125','181eed5e-bc92-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',109,1,109,6,6,'2026-01-28 13:25:35',9,9,8,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Tetap semangat dan tingkatkan hafalan',NULL,'2026-01-28 13:25:35','2026-01-28 13:25:35',NULL),
('5351d6ae-d8dc-11f0-8cc6-5aaf60d1f765','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',110,1,110,1,1,'2025-12-14 11:02:05',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-14 11:02:05','2025-12-14 11:02:05',NULL),
('5521f03d-c547-4352-8418-f27d114bba56','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',99,3,99,3,1,'2026-05-15 18:24:02',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-05-13 14:24:02','2026-05-13 14:24:02',NULL),
('559be606-bc8f-4a25-af89-de9bd2deca16','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',101,2,101,2,1,'2025-12-28 07:30:28',5,5,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-28 07:30:28','2025-12-28 07:30:28',NULL),
('57062f84-aff5-473d-9ec4-df1ac9f263b5','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',100,9,100,9,1,'2026-05-13 14:17:41',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Teruslah berlatih, karena setiap pengulangan mendekatkanmu pada sempurna',NULL,'2026-05-13 14:17:41','2026-05-13 14:17:41',NULL),
('57b3093e-d9aa-11f0-8cc9-95d775c4780d','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',109,3,109,3,1,'2025-12-15 11:36:48',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','','Catatan wali','2025-12-15 11:36:48','2025-12-15 11:36:48',NULL),
('591db77b-e0cd-11f0-8cf3-14525ee252f4','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',102,4,102,7,4,'2025-12-24 13:35:01',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Tes tulis',NULL,'2025-12-24 13:35:01','2025-12-24 13:35:01',NULL),
('5c693c42-e5bb-4bc4-93ea-1869e3055ffd','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',101,7,101,7,1,'2025-12-28 09:53:24',5,5,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-28 09:53:24','2025-12-28 09:53:24',NULL),
('5ed2cfce-d59f-4df3-91d9-87d1839aebfd','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',100,1,100,1,1,'2025-12-31 11:23:11',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','sdsd🥲','Okey','2025-12-31 11:23:11','2025-12-31 11:23:11',NULL),
('5f89092f-cadb-11f0-8e17-69f79e311aee','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',114,4,114,6,3,'2025-11-26 15:19:59',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-11-26 15:19:59','2025-11-26 15:19:59',NULL),
('61aca935-99c6-4739-aff1-be3a17d12ecc','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',99,7,99,7,1,'2026-02-01 22:08:56',9,9,5,0,'9310ee0e-bcb1-11f0-8ff6-9efd1c949119','',NULL,'2026-02-01 22:08:56','2026-02-01 22:08:56',NULL),
('646cdd19-629d-4815-a952-da6b81c5a57a','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',96,1,96,16,16,'2026-05-11 13:35:55',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Hayo hayo',NULL,'2026-05-11 13:35:55','2026-05-11 13:35:55',NULL),
('6484ca85-3447-434a-ae62-13218678641c','181eed5e-bc92-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',102,1,102,8,8,'2026-05-07 17:23:09',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-05-07 17:23:09','2026-05-07 17:23:09',NULL),
('64b66c60-e165-4613-9b0f-7812cac98423','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',98,8,98,8,1,'2026-05-09 00:59:42',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-05-09 00:59:42','2026-05-09 00:59:42',NULL),
('65fb2bb2-5417-48a3-8736-a814880e1827','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',100,8,100,8,1,'2026-05-13 14:10:52',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Sudah bagus, tapi jangan berhenti menjadi lebih baik',NULL,'2026-05-13 14:10:52','2026-05-13 14:10:52',NULL),
('6abd06bc-6786-4f10-ae23-5d68759ec110','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',99,2,99,2,1,'2026-02-01 21:45:42',9,9,5,0,'9310ee0e-bcb1-11f0-8ff6-9efd1c949119','',NULL,'2026-02-01 21:45:42','2026-02-01 21:45:42',NULL),
('6cce1cfb-d997-11f0-8cda-5bb67e5632f8','3c60f715-d997-11f0-8cda-5bb67e5632f8','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',114,1,114,6,6,'2025-12-15 09:21:23',7,6,9,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Ayo semangat kalin...','Semoga lebih lancar ya...','2025-12-15 09:21:23','2025-12-15 09:21:23',NULL),
('71f3b923-a651-43c0-88aa-a0b1d485631e','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',102,3,102,3,1,'2025-12-27 22:03:26',5,5,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-27 22:03:26','2025-12-27 22:03:26',NULL),
('7222d429-00e8-4bc4-986a-11bfddd43413','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',0,0,0,0,0,'2026-01-15 06:21:24',7,7,7,1,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','','Baik bu guru','2026-01-15 06:21:24','2026-01-15 06:21:24',NULL),
('73be2c29-4a94-493c-96a6-c1e280ea0990','181eed5e-bc92-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',80,33,80,33,1,'2026-07-03 08:24:10',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-07-03 08:24:10','2026-07-03 08:24:10',NULL),
('75077289-b421-49dc-a85c-4ff28166adfd','181eed5e-bc92-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',110,3,110,3,1,'2026-01-28 13:22:14',9,9,9,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Teruslah berlatih, karena setiap pengulangan mendekatkanmu pada sempurna',NULL,'2026-01-28 13:22:14','2026-01-28 13:22:14',NULL),
('752b7be9-d8dd-11f0-8cc6-5aaf60d1f765','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',109,1,109,6,6,'2025-12-14 11:10:11',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-14 11:10:11','2025-12-14 11:10:11',NULL),
('761a9f38-d9ae-11f0-8cc9-95d775c4780d','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',109,4,109,4,1,'2025-12-15 12:06:17',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','','yuyu','2025-12-15 12:06:17','2025-12-15 12:06:17',NULL),
('76c5a0da-5155-4f8d-9f0f-0eec2c770066','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',100,3,100,3,1,'2026-05-13 01:36:58',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Hayo hayo',NULL,'2026-05-13 01:36:58','2026-05-13 01:36:58',NULL),
('77a05261-df5e-11f0-90ed-b264de2d43ca','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',104,3,104,4,2,'2025-12-22 17:48:47',7,5,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Lebih bagus lagi ya','Maaf ya bu, semoga lebih bagus lagi','2025-12-22 17:48:47','2025-12-22 17:48:47',NULL),
('780df6c7-cadf-11f0-8e17-69f79e311aee','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',113,1,112,2,7,'2025-11-26 15:49:18',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-11-26 15:49:18','2025-11-26 15:49:18',NULL),
('78597bbf-31d0-4d09-9a42-6e09b4656da4','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',101,8,101,8,1,'2025-12-28 09:58:49',5,5,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-28 09:58:49','2025-12-28 09:58:49',NULL),
('7944d314-3397-4428-ba29-bf413f90a5d0','181eed5e-bc92-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Tahsin',2,4,2,5,2,'2026-06-25 22:52:41',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-06-25 22:52:41','2026-06-25 22:52:41',NULL),
('7ab0d260-9be1-4d92-a1e3-2d5d29a48350','3c60f715-d997-11f0-8cda-5bb67e5632f8','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',102,1,102,8,8,'2026-01-29 11:55:32',8,6,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Tetap semangat dan tingkatkan hafalan',NULL,'2026-01-29 11:55:32','2026-01-29 11:55:32',NULL),
('7b1a4087-4bf8-4915-b7ad-615efafd6d8f','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',96,17,96,19,3,'2026-05-11 13:36:58',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-05-11 13:36:58','2026-05-11 13:36:58',NULL),
('7b2e47f2-537a-43d6-82be-21c2885514fb','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',101,9,101,11,3,'2025-12-29 12:47:56',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Alhamdulillah ',NULL,'2025-12-29 12:47:56','2025-12-29 12:47:56',NULL),
('7b79595a-ddde-439e-b381-9cb4afa5b0c9','3c60f715-d997-11f0-8cda-5bb67e5632f8','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',113,1,113,5,5,'2026-01-28 13:20:51',9,9,6,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Sudah bagus, tapi jangan berhenti menjadi lebih baik',NULL,'2026-01-28 13:20:51','2026-01-28 13:20:51',NULL),
('7bb61a27-1265-4a13-8a71-e88a1f4c9f47','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',78,3,78,15,13,'2026-03-09 20:09:18',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-03-09 20:09:18','2026-03-09 20:09:18',NULL),
('7be2101a-dfc0-461b-93f3-de2b05a8d687','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',100,4,100,5,2,'2026-01-15 20:54:15',9,9,5,1,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Tidak apa-apa salah, yang penting terus belajar dan memperbaiki',NULL,'2026-01-15 20:54:15','2026-01-15 20:54:15',NULL),
('7dc4f6d7-dd81-11f0-8c80-c3be70f67f99','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',104,1,102,1,13,'2025-12-20 08:54:27',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','baru',NULL,'2025-12-20 08:54:27','2025-12-20 08:54:27',NULL),
('7dea8afe-8266-47b7-b699-1042b655d47a','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',101,7,101,7,1,'2025-12-28 09:53:03',5,5,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-28 09:53:03','2025-12-28 09:53:03',NULL),
('7f69f38a-b011-4709-9917-c9498bf3c2dc','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',113,1,113,3,3,'2026-07-16 15:01:37',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-07-16 15:01:37','2026-07-16 15:01:37',NULL),
('7f9d8a87-299c-43c5-8496-18df7d56ca80','181eed5e-bc92-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',78,1,80,27,113,'2026-06-30 14:58:08',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-06-30 14:58:08','2026-06-30 14:58:08',NULL),
('811d4813-8996-43ca-bec8-b057956831ea','7c923100-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',78,1,79,13,53,'2026-06-29 13:57:43',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-06-29 13:57:43','2026-06-29 13:57:43',NULL),
('83c7d062-a192-4e26-981f-78bea544295f','b31b930f-74e4-48ca-9b60-b2fe6a5ffc38','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',114,1,112,4,15,'2026-05-21 14:19:56',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-05-21 14:19:56','2026-05-21 14:19:56',NULL),
('84a5551b-ba28-459c-87b8-9d575c4221c8','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',101,3,101,3,1,'2025-12-28 09:38:57',5,5,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','','Feedba','2025-12-28 09:38:57','2025-12-28 09:38:57',NULL),
('8515c618-c2d4-11f0-8f58-37f83b3a7495','cdc43038-bcb3-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',0,0,0,0,0,'2025-11-16 10:10:47',7,7,7,1,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-11-16 10:10:47','2025-11-16 10:10:47',NULL),
('85c3d0bb-d997-11f0-8cda-5bb67e5632f8','3c60f715-d997-11f0-8cda-5bb67e5632f8','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',113,1,113,1,1,'2025-12-15 09:22:05',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Dikit aja',NULL,'2025-12-15 09:22:05','2025-12-15 09:22:05',NULL),
('86835526-7265-4b64-ae6c-f7356db2a89b','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',100,6,100,6,1,'2026-05-13 14:00:08',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-05-13 14:00:08','2026-05-13 14:00:08',NULL),
('871ba523-bab9-45a0-8da4-1dc89820f77a','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',101,2,101,2,1,'2025-12-28 09:40:48',5,5,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','xx',NULL,'2025-12-28 09:40:48','2025-12-28 09:40:48',NULL),
('87387d81-102a-4e99-9e98-80b9b5203921','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',101,1,101,1,1,'2025-12-27 23:26:15',5,5,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-27 23:26:15','2025-12-27 23:26:15',NULL),
('88676818-214f-4032-ba28-73a2fa4cb08e','508a76f9-4bad-4fa4-a2a0-b49dbb52e92f','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',79,4,79,12,9,'2026-07-04 05:57:18',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-07-04 05:57:18','2026-07-04 05:57:18',NULL),
('89396335-dd71-11f0-8c80-c3be70f67f99','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',109,5,109,5,1,'2025-12-20 07:00:15',7,5,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Catatannya','Yuyu','2025-12-20 07:00:15','2025-12-20 07:00:15',NULL),
('894c42ba-e489-40fb-afb9-9eaa86333be6','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',97,1,97,5,5,'2026-05-11 13:33:15',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-05-11 13:33:15','2026-05-11 13:33:15',NULL),
('8c70773f-d8da-11f0-8cc6-5aaf60d1f765','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',113,1,113,2,2,'2025-12-14 10:49:21',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-14 10:49:21','2025-12-14 10:49:21',NULL),
('8db7cee7-e3c4-4493-b443-ae10ef3afe74','3c60f715-d997-11f0-8cda-5bb67e5632f8','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',101,1,101,11,11,'2026-02-02 13:34:39',9,9,3,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Lelah itu wajar, tapi menyerah bukan pilihan',NULL,'2026-02-02 13:34:39','2026-02-02 13:34:39',NULL),
('8e0bccd8-0413-47c4-a542-9b3927a538d2','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',111,1,111,5,5,'2025-12-29 10:28:55',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-29 10:28:55','2025-12-29 10:28:55',NULL),
('8eff7170-ac15-419c-bd79-cfa190d4b2a2','508a76f9-4bad-4fa4-a2a0-b49dbb52e92f','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',79,13,79,25,13,'2026-07-04 05:58:46',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-07-04 05:58:46','2026-07-04 05:58:46',NULL),
('9073b355-7942-4584-9452-c098330909fe','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Tahsin',114,1,114,1,1,'2026-02-01 06:32:39',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-02-01 06:32:39','2026-02-01 06:32:39',NULL),
('90b84b00-d20e-11f0-9116-8377c8874adf','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',110,1,110,2,2,'2025-12-05 12:14:03',5,5,6,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Okey',NULL,'2025-12-05 12:14:03','2025-12-05 12:14:03',NULL),
('92207772-40f6-4af6-b83f-6e0da37479dd','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',99,4,113,5,89,'2026-06-26 08:18:41',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-06-26 08:18:41','2026-06-26 08:18:41',NULL),
('927a58fb-f937-42cf-8258-bf557577492d','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',99,4,99,4,1,'2026-02-01 21:58:23',9,9,5,0,'9310ee0e-bcb1-11f0-8ff6-9efd1c949119','',NULL,'2026-02-01 21:58:23','2026-02-01 21:58:23',NULL),
('93c388b0-ad7a-4669-9261-8bc3a5495a65','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',102,8,102,8,1,'2025-12-27 21:49:12',5,5,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','','Tyui','2025-12-27 21:49:12','2025-12-27 21:49:12',NULL),
('95408f55-cabf-11f0-8e17-69f79e311aee','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',114,1,114,3,3,'2025-11-26 12:01:04',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-11-26 12:01:04','2025-11-26 12:01:04',NULL),
('95f00d5a-95d1-4acc-a7fa-67b06a32d529','b31b930f-74e4-48ca-9b60-b2fe6a5ffc38','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',111,1,104,9,42,'2026-05-21 14:20:21',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-05-21 14:20:21','2026-05-21 14:20:21',NULL),
('975d6692-e149-43e3-8228-64f8a8b21908','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',102,5,102,5,1,'2025-12-27 22:07:16',5,5,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-27 22:07:16','2025-12-27 22:07:16',NULL),
('98e6319d-e65e-4932-99e4-23016014b50c','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',99,3,99,3,1,'2026-02-01 21:49:02',9,9,5,0,'9310ee0e-bcb1-11f0-8ff6-9efd1c949119','',NULL,'2026-02-01 21:49:02','2026-02-01 21:49:02',NULL),
('98f34305-3a78-47b4-9f57-71514c64adc0','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',98,7,98,8,2,'2026-03-31 23:11:52',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-03-31 23:11:52','2026-03-31 23:11:52',NULL),
('99a64ec3-d8dc-11f0-8cc6-5aaf60d1f765','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',110,2,110,2,1,'2025-12-14 11:04:03',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-14 11:04:03','2025-12-14 11:04:03',NULL),
('9b33ef4b-e966-403a-a742-2af5a236f5c3','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',101,4,101,4,1,'2025-12-28 09:46:34',5,5,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-28 09:46:34','2025-12-28 09:46:34',NULL),
('9e03008f-0e87-425a-b311-a8e035450319','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',99,1,99,1,1,'2026-05-13 14:22:26',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-05-13 14:22:26','2026-05-13 14:22:26',NULL),
('9ecc98a3-d210-11f0-9116-8377c8874adf','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',114,1,114,6,6,'2025-12-05 12:28:46',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-05 12:28:46','2025-12-05 12:28:46',NULL),
('9f76513a-dedf-4c5c-9d55-4b9c079001b4','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',104,8,104,9,2,'2025-12-27 21:50:13',5,5,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-27 21:50:13','2025-12-27 21:50:13',NULL),
('9ff6888a-2d08-4ca2-9aa5-7854e1e7106a','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',99,1,99,1,1,'2026-02-01 21:39:28',9,9,5,0,'9310ee0e-bcb1-11f0-8ff6-9efd1c949119','',NULL,'2026-02-01 21:39:28','2026-02-01 21:39:28',NULL),
('a0e0b95a-0169-4a63-b4ea-c4d38352673c','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',100,6,100,6,1,'2026-01-31 17:32:41',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Sudah bagus, tapi jangan berhenti menjadi lebih baik','gg','2026-01-31 17:32:41','2026-01-31 17:32:41',NULL),
('a5368d59-4cb4-48c2-8153-bcc98acc6e15','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',112,1,112,4,4,'2025-12-28 21:59:47',5,5,5,0,'f82def14-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-28 21:59:47','2025-12-28 21:59:47',NULL),
('a6272c71-e0de-11f0-8cf3-14525ee252f4','181eed5e-bc92-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',111,1,111,5,5,'2025-12-24 15:38:52',9,9,9,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-24 15:38:52','2025-12-24 15:38:52',NULL),
('aae8d9f5-05cd-4656-9347-551e9461ca6c','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',101,5,101,5,1,'2025-12-28 09:48:28',5,5,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-28 09:48:28','2025-12-28 09:48:28',NULL),
('ab025de5-d8db-11f0-8cc6-5aaf60d1f765','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',112,1,112,4,4,'2025-12-14 10:57:22',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-14 10:57:22','2025-12-14 10:57:22',NULL),
('ab287fb9-4771-4db0-8ad0-1f0ec15eb529','181eed5e-bc92-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',80,28,80,28,1,'2026-07-03 06:29:51',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-07-03 06:29:51','2026-07-03 06:29:51',NULL),
('aca70857-9c60-452a-8b0f-a5f5b1069853','3c60f715-d997-11f0-8cda-5bb67e5632f8','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',103,1,103,3,3,'2026-01-29 11:52:07',9,9,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Sudah bagus, tapi jangan berhenti menjadi lebih baik',NULL,'2026-01-29 11:52:07','2026-01-29 11:52:07',NULL),
('ad03cbee-7edc-48c6-98e1-5627687b3565','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',100,11,100,11,1,'2026-05-13 14:20:58',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-05-13 14:20:58','2026-05-13 14:20:58',NULL),
('aecb6cf2-dd79-11f0-8c80-c3be70f67f99','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',109,6,107,7,11,'2025-12-20 07:58:34',8,8,10,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Catatan baru','Iya bu','2025-12-20 07:58:34','2025-12-20 07:58:34',NULL),
('af9cf2b2-d9a8-11f0-8cc9-95d775c4780d','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',109,2,109,2,1,'2025-12-15 11:24:57',7,5,3,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Ini adalah catatan...',NULL,'2025-12-15 11:24:57','2025-12-15 11:24:57',NULL),
('b04a6dd5-65dd-4234-af48-e2f0fdb11278','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',102,4,102,4,1,'2025-12-27 22:06:34',5,5,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-27 22:06:34','2025-12-27 22:06:34',NULL),
('b1bd42fe-d8dd-11f0-8cc6-5aaf60d1f765','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',108,1,105,5,19,'2025-12-14 11:11:52',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-14 11:11:52','2025-12-14 11:11:52',NULL),
('b2d55772-58f7-4fae-81c6-a16f63d6f159','687360ac-ce0d-4b3e-a035-bb27f7ccfc77','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',78,1,78,10,10,'2026-07-09 01:20:39',7,7,7,0,'46b7836e-3e2e-4330-831e-d078cf7ef838','',NULL,'2026-07-09 01:20:39','2026-07-09 01:20:39',NULL),
('b650930e-dd81-11f0-8c80-c3be70f67f99','cdc43038-bcb3-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',114,1,112,1,12,'2025-12-20 08:56:02',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','baru 3 surat',NULL,'2025-12-20 08:56:02','2025-12-20 08:56:02',NULL),
('bce6dd33-c591-4b04-8596-dc47ae1c3f43','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',99,5,99,5,1,'2026-02-01 21:58:54',9,9,5,0,'9310ee0e-bcb1-11f0-8ff6-9efd1c949119','',NULL,'2026-02-01 21:58:54','2026-02-01 21:58:54',NULL),
('bd2fd052-d8dc-11f0-8cc6-5aaf60d1f765','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',110,3,110,3,1,'2025-12-14 11:05:02',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-14 11:05:02','2025-12-14 11:05:02',NULL),
('bde30c9d-7af1-43f6-a710-d37d1f817d85','181eed5e-bc92-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',104,1,104,9,9,'2026-01-28 13:50:07',9,9,8,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Sudah bagus, tapi jangan berhenti menjadi lebih baik',NULL,'2026-01-28 13:50:07','2026-01-28 13:50:07',NULL),
('bf73bfa9-97fc-417b-b33c-7146af7b2440','3c60f715-d997-11f0-8cda-5bb67e5632f8','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',112,1,112,4,4,'2026-01-28 13:24:37',9,9,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Lelah itu wajar, tapi menyerah bukan pilihan',NULL,'2026-01-28 13:24:37','2026-01-28 13:24:37',NULL),
('c0a45359-e0f1-11f0-8cf3-14525ee252f4','181eed5e-bc92-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',110,1,110,2,2,'2025-12-24 17:55:37',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-24 17:55:37','2025-12-24 17:55:37',NULL),
('c0e16b12-157b-4272-8e8f-532a4420d372','3c60f715-d997-11f0-8cda-5bb67e5632f8','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',110,1,110,3,3,'2026-01-28 13:32:20',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-01-28 13:32:20','2026-01-28 13:32:20',NULL),
('c2338c5e-c1b5-4694-9c8f-b226c5fb9476','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',103,3,103,3,1,'2025-12-27 21:57:05',5,5,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-27 21:57:05','2025-12-27 21:57:05',NULL),
('c3ae6ea6-6d3d-487f-aaa0-af0fb4b48d77','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',100,4,100,5,2,'2026-01-15 21:24:48',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Sudah bagus, tapi jangan berhenti menjadi lebih baik',NULL,'2026-01-15 21:24:48','2026-01-15 21:24:48',NULL),
('c7e377e5-cc12-4ffc-9038-990e18c2ff81','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',101,5,101,5,1,'2025-12-28 09:48:03',5,5,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-28 09:48:03','2025-12-28 09:48:03',NULL),
('c9646119-df5e-11f0-90ed-b264de2d43ca','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',102,2,102,3,2,'2025-12-22 17:51:04',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','','Okey','2025-12-22 17:51:04','2025-12-22 17:51:04',NULL),
('c9d00dc5-34fe-4331-b715-9dd838fb1a64','181eed5e-bc92-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',2,1,2,2,2,'2026-06-05 11:58:45',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-06-05 11:58:45','2026-06-05 11:58:45',NULL),
('ca0d27f7-681f-480b-9b8f-6e6c19aa240a','181eed5e-bc92-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',80,30,80,30,1,'2026-07-03 06:46:26',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-07-03 06:46:26','2026-07-03 06:46:26',NULL),
('cc230972-3a54-45e0-b2a8-7cf1df7b3ea2','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',101,10,101,11,2,'2025-12-29 13:13:07',9,7,9,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-29 13:13:07','2025-12-29 13:13:07',NULL),
('cc700348-e21e-11f0-8dc8-08103af21383','cdc43038-bcb3-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',112,4,98,4,88,'2025-12-26 05:50:35',9,9,9,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Tingkatkan dan jaga hafalan',NULL,'2025-12-26 05:50:35','2025-12-26 05:50:35',NULL),
('cc86f2c7-5dcb-4d1e-b9b2-8544725c0f3d','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',99,2,99,2,1,'2026-05-13 14:23:18',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-05-13 14:23:18','2026-05-13 14:23:18',NULL),
('cea5b6f3-d8da-11f0-8cc6-5aaf60d1f765','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',113,3,113,5,3,'2025-12-14 10:51:12',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','','Oh iya bagus','2025-12-14 10:51:12','2025-12-14 10:51:12',NULL),
('d3125fa3-853e-42bc-8fc2-363a8a3b487c','181eed5e-bc92-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',80,31,80,31,1,'2026-07-03 08:10:46',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-07-03 08:10:46','2026-07-03 08:10:46',NULL),
('d4dfd3d4-580d-4c28-957f-8b719b1865fb','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',95,7,95,8,2,'2026-05-18 08:23:59',7,10,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','FOO',NULL,'2026-05-18 08:23:59','2026-05-18 08:23:59',NULL),
('d5efa6cd-72dd-418d-b001-dc7cc5a2a853','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',100,7,100,7,1,'2026-01-31 19:26:11',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-01-31 19:26:11','2026-01-31 19:26:11',NULL),
('d76cfec4-bcb0-47bf-af7f-20c555683808','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',78,1,78,2,2,'2026-03-09 20:09:03',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-03-09 20:09:03','2026-03-09 20:09:03',NULL),
('d8f2004f-dd80-11f0-8c80-c3be70f67f99','181eed5e-bc92-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',114,5,112,1,8,'2025-12-20 08:49:51',9,10,9,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','kosong',NULL,'2025-12-20 08:49:51','2025-12-20 08:49:51',NULL),
('d91ba942-015e-4123-ab4a-bc17bb226065','b31b930f-74e4-48ca-9b60-b2fe6a5ffc38','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',103,1,101,2,13,'2026-06-29 14:14:03',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-06-29 14:14:03','2026-06-29 14:14:03',NULL),
('da4a7f5f-6c7a-49b1-84f1-c87f61b0ad17','cdc43038-bcb3-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',98,5,98,8,4,'2025-12-29 10:28:32',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-29 10:28:32','2025-12-29 10:28:32',NULL),
('de7897fe-c0f6-4054-b048-9b3961ad9bc0','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',102,8,102,8,1,'2025-12-27 22:16:36',5,5,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-27 22:16:36','2025-12-27 22:16:36',NULL),
('de93e6af-9e5b-49af-9a3c-49ee460d5ac0','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',114,1,114,6,6,'2026-01-15 07:04:27',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-01-15 07:04:27','2026-01-15 07:04:27',NULL),
('df3302d6-6662-4384-bf48-0942328e3921','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',100,4,100,4,1,'2026-05-13 01:37:45',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Tetap semangat dan tingkatkan hafalan',NULL,'2026-05-13 01:37:45','2026-05-13 01:37:45',NULL),
('e29118e9-990d-4653-a229-0650e9fab58b','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',100,10,100,10,1,'2026-05-13 14:20:12',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Tidak apa-apa salah, yang penting terus belajar dan memperbaiki',NULL,'2026-05-13 14:20:12','2026-05-13 14:20:12',NULL),
('e2f4266c-bb81-482e-859d-c5fe0116dec4','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',101,1,101,1,1,'2025-12-28 09:40:07',5,5,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Ayuk',NULL,'2025-12-28 09:40:07','2025-12-28 09:40:07',NULL),
('e3e9580e-3ba5-448e-81da-b6bb40e1c589','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',98,2,98,6,5,'2026-02-20 04:33:42',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-02-20 04:33:42','2026-02-20 04:33:42',NULL),
('e700a138-a578-4f2f-9219-b44781f5f5be','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',103,1,103,1,1,'2025-12-27 21:54:08',5,5,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-27 21:54:08','2025-12-27 21:54:08',NULL),
('eb42a8fd-0d2b-44c0-9e7f-f26523000eb0','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',100,7,100,7,1,'2026-05-13 14:09:55',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Lelah itu wajar, tapi menyerah bukan pilihan',NULL,'2026-05-13 14:09:55','2026-05-13 14:09:55',NULL),
('eb78305a-e55f-424f-b389-a5f0ee8138c9','181eed5e-bc92-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',106,1,105,5,9,'2026-01-28 13:34:55',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-01-28 13:34:55','2026-01-28 13:34:55',NULL),
('ee79f625-be4e-4ddc-b13e-05f84dae2738','cdc42669-bcb3-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',67,1,67,13,13,'2026-04-20 17:28:02',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-04-20 17:28:02','2026-04-20 17:28:02',NULL),
('f05ea062-d996-11f0-8cda-5bb67e5632f8','181eed5e-bc92-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',114,1,114,3,3,'2025-12-15 09:17:54',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Bagus...',NULL,'2025-12-15 09:17:54','2025-12-15 09:17:54',NULL),
('f06f97d2-60c4-4603-bf21-fea485dd6391','3c60f715-d997-11f0-8cda-5bb67e5632f8','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',107,1,107,7,7,'2026-01-28 13:46:29',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-01-28 13:46:29','2026-01-28 13:46:29',NULL),
('f499e891-e82d-4a73-906a-fa431b61b2bd','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',2,142,2,142,1,'2026-06-14 03:07:44',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-06-14 03:07:44','2026-06-14 03:07:44',NULL),
('f4d69fe6-c34c-4ab6-b18e-1693aa097654','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',100,2,100,2,1,'2026-05-13 01:35:08',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-05-13 01:35:08','2026-05-13 01:35:08',NULL),
('f59949c0-0d89-4277-aa17-3bff68e77e89','181eed5e-bc92-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',103,1,103,3,3,'2026-01-28 13:50:56',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-01-28 13:50:56','2026-01-28 13:50:56',NULL),
('f971a492-cb69-11f0-8f32-3a0a8374bd58','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',112,3,111,5,7,'2025-11-27 08:20:46',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-11-27 08:20:46','2025-11-27 08:20:46',NULL),
('f97f4856-6ad2-40c0-aecd-0c1ca1da953b','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',98,1,98,7,7,'2026-05-07 22:09:23',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-05-07 22:09:23','2026-05-07 22:09:23',NULL),
('fb36bc96-ebf0-46de-932f-4633cb47b0a8','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',100,9,100,11,3,'2026-02-01 06:30:58',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-02-01 06:30:58','2026-02-01 06:30:58',NULL),
('fb397180-00ed-49f7-82af-a933d58d2223','598f3241-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Murojaah',114,5,114,6,2,'2026-01-15 06:20:19',7,7,7,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Murojaah',NULL,'2026-01-15 06:20:19','2026-01-15 06:20:19',NULL),
('fd7deb71-ac75-4a88-83c2-376e97ee41a2','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',113,4,112,4,6,'2026-07-16 22:33:17',9,9,9,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-07-16 22:33:17','2026-07-16 22:33:17',NULL),
('fd9490e6-8bb7-4cf0-bbbf-bbfd42144a58','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',100,5,100,5,1,'2026-05-13 13:57:00',9,9,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2026-05-13 13:57:00','2026-05-13 13:57:00',NULL),
('ffdcdb10-a312-41da-bad2-7966c2e84682','683cafdd-bc5f-11f0-8b9c-41333d9a4eb4','c02187d2-bfd2-11f0-8d7c-cdee4485d186','Ziyadah',101,9,101,9,1,'2025-12-28 10:00:22',5,5,5,0,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','',NULL,'2025-12-28 10:00:22','2025-12-28 10:00:22',NULL);
/*!40000 ALTER TABLE `tahfidzs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher_attendances`
--

DROP TABLE IF EXISTS `teacher_attendances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teacher_attendances` (
  `id` varchar(36) NOT NULL,
  `teacher_id` varchar(36) NOT NULL,
  `date` date NOT NULL DEFAULT curdate(),
  `clock_in_time` time NOT NULL,
  `clock_out_time` time DEFAULT NULL,
  `clock_in_lat` double DEFAULT NULL,
  `clock_in_lng` double DEFAULT NULL,
  `clock_in_loc` text DEFAULT NULL,
  `clock_in_image` text DEFAULT NULL,
  `clock_out_lat` double DEFAULT NULL,
  `clock_out_lng` double DEFAULT NULL,
  `clock_out_loc` text DEFAULT NULL,
  `clock_out_image` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher_attendances`
--

LOCK TABLES `teacher_attendances` WRITE;
/*!40000 ALTER TABLE `teacher_attendances` DISABLE KEYS */;
INSERT INTO `teacher_attendances` VALUES
('0ebcc02e-d6bc-481d-b5de-e9788b513b9c','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','2026-04-30','15:36:26','15:36:54',-7.747981975304977,110.36254372790195,'Jalan Magelang, Sinduadi, Mlati, Sleman, Daerah Istimewa Yogyakarta, Jawa, 55285, Indonesia','teat_1481157c-4dca-47a8-9840-615985b8ef29.jpeg',-7.747981975304977,110.36254372790195,'Jalan Magelang, Sinduadi, Mlati, Sleman, Daerah Istimewa Yogyakarta, Jawa, 55285, Indonesia',NULL,'2026-05-03 08:36:28','2026-05-03 08:36:28',NULL),
('8431f5dd-e36a-4311-ada1-87f9021149ff','369e38d2-fb66-4f00-8e6b-2967c8db4aba','2026-05-03','16:21:39','16:42:56',NULL,NULL,NULL,'teat_73523e7a-fd1a-4c2c-9a55-1ac3141646c7.jpeg',NULL,NULL,NULL,NULL,'2026-05-03 09:22:02','2026-05-03 09:22:02',NULL),
('a9edfd18-2ca5-4b27-8d54-178b8307cfd1','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','2026-05-03','16:08:31','23:46:32',-7.747981975304977,110.36254372790195,'Jalan Magelang, Sinduadi, Mlati, Sleman, Daerah Istimewa Yogyakarta, Jawa, 55285, Indonesia','teat_1e34160a-d627-4c9b-b1f2-77204cfb783f.jpeg',NULL,NULL,NULL,NULL,'2026-05-03 09:08:32','2026-05-03 09:08:32',NULL),
('b1457984-f11b-4426-8500-4ee9a3ed3f48','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','2026-05-14','03:17:25','03:18:49',NULL,NULL,NULL,'teat_f49a6576-cbae-4efc-a317-a43321e66cdb.png',NULL,NULL,NULL,NULL,'2026-05-13 20:17:28','2026-05-13 20:17:28',NULL),
('bf4bdee1-4b89-4897-88c0-a1ba71d0d253','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','2026-05-01','15:13:16','15:34:01',-7.747981975304977,110.36254372790195,'Jalan Magelang, Sinduadi, Mlati, Sleman, Daerah Istimewa Yogyakarta, Jawa, 55285, Indonesia','teat_360fafa2-4a0c-4c28-bc7a-22d603341c31.jpeg',-7.747981975304977,110.36254372790195,'Jalan Magelang, Sinduadi, Mlati, Sleman, Daerah Istimewa Yogyakarta, Jawa, 55285, Indonesia',NULL,'2026-05-03 08:13:17','2026-05-03 08:13:17',NULL),
('dc2a7a50-1ad0-452b-ad1d-a54766fe9430','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','2026-05-02','03:57:58','03:58:19',-7.747981975304977,110.36254372790195,'Jalan Magelang, Sinduadi, Mlati, Sleman, Daerah Istimewa Yogyakarta, Jawa, 55285, Indonesia','teat_bde34696-26b8-4a67-80fd-80fca49c933c.jpeg',-7.747981975304977,110.36254372790195,'Jalan Magelang, Sinduadi, Mlati, Sleman, Daerah Istimewa Yogyakarta, Jawa, 55285, Indonesia',NULL,'2026-05-02 20:58:00','2026-05-02 20:58:00',NULL),
('f2d177d0-72cd-4dd4-951b-88444e8b7f48','369e38d2-fb66-4f00-8e6b-2967c8db4aba','2026-05-16','02:54:34','02:54:54',NULL,NULL,NULL,'teat_11725d57-8471-408e-98f6-5c0cfbe95bf3.jpeg',NULL,NULL,NULL,NULL,'2026-05-13 19:54:39','2026-05-13 19:54:39',NULL);
/*!40000 ALTER TABLE `teacher_attendances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher_permits`
--

DROP TABLE IF EXISTS `teacher_permits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teacher_permits` (
  `id` varchar(36) NOT NULL,
  `teacher_id` varchar(36) NOT NULL,
  `date` date NOT NULL,
  `kind` varchar(50) NOT NULL,
  `document` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `status` enum('Diajukan','Disetujui','Ditolak') NOT NULL DEFAULT 'Diajukan',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher_permits`
--

LOCK TABLES `teacher_permits` WRITE;
/*!40000 ALTER TABLE `teacher_permits` DISABLE KEYS */;
INSERT INTO `teacher_permits` VALUES
('aa9ef237-eb86-4e60-ab02-71c4d48b7e22','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','2026-05-03','Jalan-jalan','tprm_8094493f-b278-4758-961b-3bacdfa5577d.jpeg','Jalan jalan aja','Ditolak','2026-05-05 16:37:10','2026-05-05 16:37:10',NULL),
('c1b16d83-627e-46d8-a051-8b7f1c1a2eea','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','2026-05-05','Izin',NULL,'Mau ke dokter gigi','Disetujui','2026-05-05 16:26:17','2026-05-05 16:26:17',NULL),
('c1f55bc3-d563-4a5b-b469-2d6d0c1d880e','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','2026-05-07','Sakit',NULL,'Sya sakit panas ya bu','Ditolak','2026-05-05 16:36:02','2026-05-05 16:36:02',NULL);
/*!40000 ALTER TABLE `teacher_permits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teachers`
--

DROP TABLE IF EXISTS `teachers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teachers` (
  `id` varchar(36) NOT NULL,
  `school_id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `nip` varchar(255) NOT NULL,
  `sex` enum('M','F') NOT NULL,
  `dob` date NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  `can_be_treasurer` tinyint(1) NOT NULL DEFAULT 0,
  `can_be_principal` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teachers`
--

LOCK TABLES `teachers` WRITE;
/*!40000 ALTER TABLE `teachers` DISABLE KEYS */;
INSERT INTO `teachers` VALUES
('202c1228-d4d5-44d7-bb20-668fe9a8ad8f','582e4596-bb5b-11f0-8be0-d0008dc32c8f','Sas','123123123','M','2020-11-05',NULL,NULL,NULL,'2026-07-08 12:26:17','2026-07-08 12:26:17',NULL,0,0),
('2b79230a-55b1-46f1-a5ba-d1f4895b48a0','0005ed5c-2ef5-e011-9fee-6124ccb9e3de','Si Gak Kenapa','12341234','M','2026-07-17',NULL,NULL,NULL,'2026-07-17 12:32:18','2026-07-17 12:32:18',NULL,0,0),
('369e38d2-fb66-4f00-8e6b-2967c8db4aba','582e4596-bb5b-11f0-8be0-d0008dc32c8f','Melia Bulma','500002','F','2001-06-01',NULL,NULL,NULL,'2026-01-03 09:33:58','2026-01-03 09:33:58',NULL,0,0),
('3ef85676-bcb2-11f0-8ff6-9efd1c949119','582e4596-bb5b-11f0-8be0-d0008dc32c8f','Samborin','100004','M','2026-05-01',NULL,NULL,NULL,'2025-11-08 14:50:19','2025-11-08 14:50:19',NULL,0,0),
('46b7836e-3e2e-4330-831e-d078cf7ef838','0005ed5c-2ef5-e011-9fee-6124ccb9e3de','Pak Guru 1','111111','M','2026-07-09',NULL,NULL,NULL,'2026-07-09 00:58:45','2026-07-09 00:58:45',NULL,0,0),
('54da51f0-e8e4-4a59-ba18-44191322c965','582e4596-bb5b-11f0-8be0-d0008dc32c8f','Sumarni','100007','F','2001-01-01',NULL,NULL,NULL,'2025-12-30 13:02:16','2025-12-30 13:02:16',NULL,1,0),
('67b6308e-aa22-49b0-9c86-b171a0e6ac2e','582e4596-bb5b-11f0-8be0-d0008dc32c8f','Si Guru Banyak','12341234','M','2026-07-17',NULL,NULL,NULL,'2026-07-17 10:43:50','2026-07-17 10:43:50',NULL,0,0),
('784a004c-b9b3-4f26-96b3-bdb5f8ccd4ae','8061ca5c-2ef5-e011-ad7e-ffe7f6f833dd','Kunyuk','1234','M','2026-02-04',NULL,NULL,NULL,'2026-02-21 22:28:30','2026-02-21 22:28:30',NULL,0,0),
('7f7b1f66-af6f-402a-96b7-36489ce87cc5','582e4596-bb5b-11f0-8be0-d0008dc32c8f','Poo Mania','101010','M','2026-06-22',NULL,NULL,NULL,'2026-06-22 16:54:23','2026-06-22 16:54:23',NULL,0,0),
('80434d97-77d3-4eb9-8e42-1ccc618e7cdf','582e4596-bb5b-11f0-8be0-d0008dc32c8f','Hardjo Winangun','500001','M','2026-01-01',NULL,NULL,NULL,'2026-01-03 09:33:58','2026-01-03 09:33:58',NULL,1,0),
('9310ee0e-bcb1-11f0-8ff6-9efd1c949119','582e4596-bb5b-11f0-8be0-d0008dc32c8f','Fantaboy Murni','100001','M','2025-12-01','f0162da5-3ff0-4dd9-9dca-6fda15744d70.png','081123123123','Jl Nanas No 8','2025-11-08 14:45:31','2025-11-08 14:45:31',NULL,0,1),
('9310f2a9-bcb1-11f0-8ff6-9efd1c949119','582e4596-bb5b-11f0-8be0-d0008dc32c8f','Sukarno','100002','M','2025-12-01',NULL,NULL,NULL,'2025-11-08 14:45:31','2025-11-08 14:45:31',NULL,0,0),
('9310f36c-bcb1-11f0-8ff6-9efd1c949119','582e4596-bb5b-11f0-8be0-d0008dc32c8f','Hartono','100003','M','2026-01-01',NULL,NULL,NULL,'2025-11-08 14:45:31','2025-11-08 14:45:31',NULL,0,0),
('9a779851-8f0e-4f35-9ea0-8a46f06c2848','582e4596-bb5b-11f0-8be0-d0008dc32c8f','Fiona Bloom','500003','F','2026-01-01',NULL,'','','2026-01-03 09:33:58','2026-01-03 09:33:58',NULL,0,0),
('e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','582e4596-bb5b-11f0-8be0-d0008dc32c8f','Bintang Pelita','111111','F','2025-12-01','prof_19a1bf55-a091-46ff-8fe7-ef501f0b2150.jpeg','081123123123','Jl Nangka','2025-11-08 05:15:02','2025-11-08 05:15:02',NULL,1,1),
('e804df74-3601-4757-8244-e6e7abe03510','28c25337-f7f7-43cd-aeb7-e80b6e3a35f0','Si Guru Banyak','12341234','M','2026-07-17',NULL,NULL,NULL,'2026-07-17 10:44:10','2026-07-17 10:44:10',NULL,0,0),
('f82def14-bc61-11f0-8b9c-41333d9a4eb4','582e4596-bb5b-11f0-8be0-d0008dc32c8f','Wamena Badhar','111112','M','2025-12-01',NULL,NULL,NULL,'2025-11-08 05:15:41','2025-11-08 05:15:41',NULL,0,0),
('f83e032e-cda7-44de-b678-614a18b42ed3','8061ca5c-2ef5-e011-ad7e-ffe7f6f833dd','NIP Tamb','100002','M','2025-12-01',NULL,NULL,NULL,'2026-05-17 07:51:19','2026-05-17 07:51:19',NULL,0,0);
/*!40000 ALTER TABLE `teachers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tilawahs`
--

DROP TABLE IF EXISTS `tilawahs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tilawahs` (
  `id` varchar(36) NOT NULL,
  `student_id` varchar(36) NOT NULL,
  `start_surat` int(11) NOT NULL,
  `start_ayat` int(11) NOT NULL,
  `end_surat` int(11) NOT NULL,
  `end_ayat` int(11) NOT NULL,
  `count_ayat` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `time` varchar(255) NOT NULL,
  `image` text DEFAULT NULL,
  `note` text DEFAULT NULL,
  `parent_id` varchar(36) DEFAULT NULL,
  `parent_feedback` varchar(36) DEFAULT NULL,
  `parent_status` enum('Pending','Accepted','Rejected') DEFAULT NULL,
  `parent_action_date` timestamp NULL DEFAULT NULL,
  `teacher_id` varchar(36) DEFAULT NULL,
  `teacher_feedback` varchar(36) DEFAULT NULL,
  `teacher_status` enum('Pending','Accepted','Rejected') DEFAULT NULL,
  `teacher_action_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tilawahs`
--

LOCK TABLES `tilawahs` WRITE;
/*!40000 ALTER TABLE `tilawahs` DISABLE KEYS */;
INSERT INTO `tilawahs` VALUES
('082fc4a0-a049-45dd-a645-e457cb1721a4','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119',1,1,1,7,7,'2026-07-05 21:56:14','Setelah Maghrib',NULL,'',NULL,NULL,NULL,NULL,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','','Accepted','2026-07-08 17:40:19','2026-07-05 21:56:14','2026-07-05 21:56:14',NULL),
('0d882022-7c35-4fca-917b-915b2c4c6327','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119',114,1,114,3,3,'2026-06-22 08:01:54','Setelah Maghrib',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-06-22 08:01:54','2026-06-22 08:01:54',NULL),
('136a2101-392d-452b-b485-1ffcc299ffd7','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119',114,1,113,1,1,'2026-06-20 14:17:25','Setelah Maghrib',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Accepted','2026-06-20 23:30:30','2026-06-20 14:17:25','2026-06-20 14:17:25',NULL),
('2a3c5dcb-18d6-434e-b1e8-ee3d7d448285','598f3241-bc5f-11f0-8b9c-41333d9a4eb4',4,94,4,141,48,'2026-06-26 08:02:36','Setelah Maghrib',NULL,'','682146f2-4507-4f45-aa4e-882279eeb195','','Accepted','2026-06-26 10:17:38','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','','Accepted','2026-07-08 16:17:20','2026-06-26 08:02:36','2026-06-26 08:02:36',NULL),
('2da3f27d-eb11-4220-b145-0d86a75fb55b','598f3241-bc5f-11f0-8b9c-41333d9a4eb4',2,1,2,2,2,'2026-07-06 08:36:27','Setelah Maghrib',NULL,'',NULL,NULL,NULL,NULL,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','','Accepted','2026-07-08 16:13:59','2026-07-06 08:36:27','2026-07-06 08:36:27',NULL),
('37efa174-79a2-467d-924b-1acc57c85ee2','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119',114,1,113,2,1,'2026-06-20 14:29:40','Setelah Ashar',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-06-20 14:29:40','2026-06-20 14:29:40',NULL),
('3c3c2d6c-bf15-4fec-9373-1bbf98d72bf8','687360ac-ce0d-4b3e-a035-bb27f7ccfc77',78,1,78,5,5,'2026-07-09 02:09:19','Setelah Maghrib',NULL,'','69757bfc-5e42-4e36-adcb-c2a410b9de85','Bagus nak','Accepted','2026-07-09 02:15:41',NULL,NULL,NULL,NULL,'2026-07-09 02:09:19','2026-07-09 02:09:19',NULL),
('3fc21bff-2d5f-425b-a581-c2485f03252d','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119',114,1,113,2,8,'2026-06-24 01:28:19','Setelah Maghrib',NULL,'','682146f2-4507-4f45-aa4e-882279eeb195','Bagus anakku','Accepted','2026-06-24 02:50:43',NULL,NULL,NULL,NULL,'2026-06-24 01:28:19','2026-06-24 01:28:19',NULL),
('47eeaf44-baa4-4355-b874-6132cd05726a','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119',114,1,114,1,1,'2026-06-20 15:31:25','',NULL,NULL,'682146f2-4507-4f45-aa4e-882279eeb195','Bagus nak','Accepted','2026-06-20 23:00:30','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4',NULL,'Rejected','2026-06-20 23:30:30','2026-06-20 15:31:25','2026-06-20 15:31:25',NULL),
('4b4ee240-383e-4a93-b7b2-fae559ec2226','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119',114,1,113,1,1,'2026-06-21 04:48:51','Setelah Maghrib','tila_e9df0b16-96bd-4150-9650-326ceff40817.jpeg','Note ajah',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-06-21 04:48:51','2026-06-21 04:48:51',NULL),
('4c58093c-7e35-4ed8-9364-f9c2e16a035b','598f3241-bc5f-11f0-8b9c-41333d9a4eb4',2,6,2,8,3,'2026-07-08 17:42:39','Setelah Maghrib',NULL,'',NULL,NULL,NULL,NULL,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','','Accepted','2026-07-08 17:43:10','2026-07-08 17:42:39','2026-07-08 17:42:39',NULL),
('53c46b1f-f768-4628-bf10-b02c498f1a44','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119',114,1,114,6,1,'2026-06-21 04:48:02','Setelah Subuh','tila_5310db17-94f2-4696-b30a-991f6c92cb58.jpeg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-06-21 04:48:02','2026-06-21 04:48:02',NULL),
('61e01659-60de-4403-84d4-f15eed020510','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119',114,1,113,2,10,'2026-06-22 07:38:52','Setelah Maghrib','tila_6d3b497a-6a57-4270-8b02-e9ff42fd2466.jpeg','Aku sangat rajin mengaji',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-06-22 07:38:52','2026-06-22 07:38:52',NULL),
('63830cef-6177-4f85-8000-a44af2ca8968','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119',114,1,114,6,6,'2026-06-25 02:52:46','Setelah Maghrib',NULL,'','682146f2-4507-4f45-aa4e-882279eeb195','Hohoho saya suka nak','Accepted','2026-06-25 02:53:04',NULL,NULL,NULL,NULL,'2026-06-25 02:52:46','2026-06-25 02:52:46',NULL),
('6ab092b1-bcad-46f0-b1b9-5499193ca6fd','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119',2,7,2,7,1,'2026-07-08 17:13:03','Setelah Maghrib',NULL,'',NULL,NULL,NULL,NULL,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','','Accepted','2026-07-08 17:19:35','2026-07-08 17:13:03','2026-07-08 17:13:03',NULL),
('73322b34-6354-408e-a190-869b58cc9461','598f3241-bc5f-11f0-8b9c-41333d9a4eb4',4,24,4,24,1,'2026-06-25 23:03:16','Setelah Maghrib',NULL,'','682146f2-4507-4f45-aa4e-882279eeb195','','Accepted','2026-06-25 23:51:18',NULL,NULL,NULL,NULL,'2026-06-25 23:03:16','2026-06-25 23:03:16',NULL),
('7738d7c3-ed3b-4bf5-9648-57d73705e40f','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119',2,8,2,9,2,'2026-07-08 17:18:45','Setelah Maghrib',NULL,'','682146f2-4507-4f45-aa4e-882279eeb195','','Accepted','2026-07-08 17:20:31','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','','Accepted','2026-07-08 17:33:40','2026-07-08 17:18:45','2026-07-08 17:18:45',NULL),
('79e0c8a4-d0ed-4096-ba7a-8607f1872aae','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119',114,1,114,3,1,'2026-06-20 14:17:16','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Rejected',NULL,'2026-06-20 14:17:16','2026-06-20 14:17:16',NULL),
('7abb5f73-3791-4930-acdd-0b809e05fd39','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119',114,1,114,3,1,'2026-06-21 04:34:58','Habis Makan',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-06-21 04:34:58','2026-06-21 04:34:58',NULL),
('7c77e4fc-3619-4c39-aa3d-0a4ef6d01bf0','598f3241-bc5f-11f0-8b9c-41333d9a4eb4',2,5,2,5,1,'2026-07-08 14:22:24','Setelah Maghrib',NULL,'',NULL,NULL,NULL,NULL,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','','Accepted','2026-07-08 16:12:20','2026-07-08 14:22:24','2026-07-08 14:22:24',NULL),
('83f6b26a-baae-456b-a853-c1c7e3f3a128','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119',114,1,112,4,1,'2026-06-20 22:12:30','Setelah Subuh',NULL,NULL,'682146f2-4507-4f45-aa4e-882279eeb195','Bagus nak','Accepted','2026-06-20 23:00:30','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','Boleh boleh','Accepted','2026-06-20 23:30:30','2026-06-20 22:12:30','2026-06-20 22:12:30',NULL),
('88264d22-4558-43dc-bd89-85d29c1626fc','25cbd15f-7be5-444a-b3ce-4d365523ad7d',1,1,1,7,7,'2026-07-09 14:49:57','Setelah Maghrib',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-07-09 14:49:57','2026-07-09 14:49:57',NULL),
('8b9dc373-5abb-482a-a326-301013241bfe','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119',114,1,113,5,1,'2026-06-20 14:09:53','',NULL,NULL,NULL,NULL,'Accepted',NULL,NULL,NULL,NULL,NULL,'2026-06-20 14:09:53','2026-06-20 14:09:53',NULL),
('9d386b56-2266-4d17-a321-37a941631f2f','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119',2,3,2,4,2,'2026-07-06 08:37:51','Setelah Maghrib',NULL,'',NULL,NULL,NULL,NULL,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','','Accepted','2026-07-08 16:14:21','2026-07-06 08:37:51','2026-07-06 08:37:51',NULL),
('9f275ab8-600b-4eef-8a6b-4b6cf50d923e','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119',114,1,114,3,3,'2026-06-22 17:10:43','Setelah Maghrib',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-06-22 17:10:43','2026-06-22 17:10:43',NULL),
('a6443636-c7ec-4ee0-a860-98485b130252','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119',2,6,2,6,1,'2026-07-08 14:22:40','Setelah Maghrib',NULL,'',NULL,NULL,NULL,NULL,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','','Accepted','2026-07-08 17:34:51','2026-07-08 14:22:40','2026-07-08 14:22:40',NULL),
('bfce6eca-1a41-4c04-badb-beee983cff68','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119',114,1,114,2,1,'2026-06-20 14:27:15','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-06-20 14:27:15','2026-06-20 14:27:15',NULL),
('caeece72-9994-4292-87f6-cf0eca5409f7','598f3241-bc5f-11f0-8b9c-41333d9a4eb4',4,24,4,93,70,'2026-06-26 03:07:22','Setelah Maghrib',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-06-26 03:07:22','2026-06-26 03:07:22',NULL),
('cc290a90-0042-4171-b7b5-52e5ea56855b','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119',114,1,114,4,1,'2026-06-21 04:45:10','Setelah Maghrib','tila_ffc5024a-fc64-4889-a9d4-d42a1c113373.jpeg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-06-21 04:45:10','2026-06-21 04:45:10',NULL),
('e1ab68ed-9b0b-4301-903a-49e8c323ea17','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119',113,1,113,5,5,'2026-06-26 08:08:01','Setelah Maghrib',NULL,'',NULL,NULL,NULL,NULL,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','','Accepted','2026-07-08 16:16:35','2026-06-26 08:08:01','2026-06-26 08:08:01',NULL),
('eaebf119-d747-4cc3-b705-5ae40e205a21','598f3241-bc5f-11f0-8b9c-41333d9a4eb4',4,24,4,24,1,'2026-06-25 15:48:28','Setelah Maghrib',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-06-25 15:48:28','2026-06-25 15:48:28',NULL),
('fd1dbec0-e0b6-4fbf-9012-66c8cba40957','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119',2,142,2,143,1,'2026-06-20 11:11:50','',NULL,NULL,NULL,NULL,NULL,NULL,'e12c70ed-bc61-11f0-8b9c-41333d9a4eb4','','Accepted','2026-07-09 01:16:42','2026-06-20 11:11:50','2026-06-20 11:11:50',NULL);
/*!40000 ALTER TABLE `tilawahs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_roles` (
  `user_id` varchar(36) NOT NULL,
  `role` enum('Dev','Superadmin','Kepala Sekolah','Admin Sekolah','Guru','Siswa','Unset','Wali','Affiliate','Bendahara') NOT NULL,
  `school_id` varchar(36) NOT NULL,
  `member_id` varchar(36) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`user_id`,`role`,`school_id`,`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES
('2211617a-d055-11f0-8de5-e8758f708443','Guru','582e4596-bb5b-11f0-8be0-d0008dc32c8f','369e38d2-fb66-4f00-8e6b-2967c8db4aba',1),
('2b377276-0884-4657-901d-f5a9232373dd','Siswa','582e4596-bb5b-11f0-8be0-d0008dc32c8f','bcaf2469-4320-4f0b-a8ee-585a8f9d5747',1),
('5b81ce5e-cce5-11f0-8f97-aa3b281802c1','Guru','582e4596-bb5b-11f0-8be0-d0008dc32c8f','54da51f0-e8e4-4a59-ba18-44191322c965',0),
('5b81ce5e-cce5-11f0-8f97-aa3b281802c1','Guru','582e4596-bb5b-11f0-8be0-d0008dc32c8f','80434d97-77d3-4eb9-8e42-1ccc618e7cdf',0),
('5b81ce5e-cce5-11f0-8f97-aa3b281802c1','Wali','582e4596-bb5b-11f0-8be0-d0008dc32c8f','682146f2-4507-4f45-aa4e-882279eeb195',0),
('60a633b4-b316-4019-93d5-d262120d3263','Siswa','582e4596-bb5b-11f0-8be0-d0008dc32c8f','b149abd8-87a1-404d-b6ca-e639d7d13e36',1),
('7296ff26-bca0-11f0-8ff6-9efd1c949119','Kepala Sekolah','582e4596-bb5b-11f0-8be0-d0008dc32c8f','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4',1),
('7296ff26-bca0-11f0-8ff6-9efd1c949119','Guru','582e4596-bb5b-11f0-8be0-d0008dc32c8f','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4',0),
('7296ff26-bca0-11f0-8ff6-9efd1c949119','Wali','582e4596-bb5b-11f0-8be0-d0008dc32c8f','9b3b38b7-1229-4741-a01b-63498b85b955',0),
('7296ff26-bca0-11f0-8ff6-9efd1c949119','Bendahara','582e4596-bb5b-11f0-8be0-d0008dc32c8f','e12c70ed-bc61-11f0-8b9c-41333d9a4eb4',0),
('76954a42-148d-47b0-a0c5-1843df21c7dd','Siswa','0005ed5c-2ef5-e011-9fee-6124ccb9e3de','687360ac-ce0d-4b3e-a035-bb27f7ccfc77',1),
('77afb720-8611-4bb7-9219-c95e822c6eff','Siswa','582e4596-bb5b-11f0-8be0-d0008dc32c8f','c9746ea1-0524-4577-baf7-71f6311a4789',1),
('7e4a190a-6b5c-41b8-9f72-1bdc38696f02','Guru','0005ed5c-2ef5-e011-9fee-6124ccb9e3de','46b7836e-3e2e-4330-831e-d078cf7ef838',1),
('85bf2f94-df91-4fdb-b32c-76fa74541341','Siswa','582e4596-bb5b-11f0-8be0-d0008dc32c8f','25cbd15f-7be5-444a-b3ce-4d365523ad7d',1),
('9249e048-6ab6-435e-b98e-ff66367cef4b','Wali','0005ed5c-2ef5-e011-9fee-6124ccb9e3de','69757bfc-5e42-4e36-adcb-c2a410b9de85',1),
('b156a727-49fa-4b31-a5e7-c32fee53f70d','Siswa','582e4596-bb5b-11f0-8be0-d0008dc32c8f','598f3241-bc5f-11f0-8b9c-41333d9a4eb4',1),
('bb14d3e5-008b-45b8-b40c-e0ee190633da','Siswa','582e4596-bb5b-11f0-8be0-d0008dc32c8f','2bea7bf8-e0a0-4381-9fce-e3ebd436ce8a',1),
('bdfc6e26-601f-4166-a96d-648efb9791ad','Wali','582e4596-bb5b-11f0-8be0-d0008dc32c8f','94db24a5-371b-46d7-9957-a643f0d99191',1),
('c8e84675-df12-11f0-90ed-b264de2d43ca','Guru','582e4596-bb5b-11f0-8be0-d0008dc32c8f','9310ee0e-bcb1-11f0-8ff6-9efd1c949119',1),
('c99ac0e8-e23e-11f0-9279-5798f3f8052c','Guru','582e4596-bb5b-11f0-8be0-d0008dc32c8f','f82def14-bc61-11f0-8b9c-41333d9a4eb4',1),
('d52b3378-3e12-4b67-86b8-79eba408c87e','Siswa','582e4596-bb5b-11f0-8be0-d0008dc32c8f','cdc42a1e-bcb3-11f0-8ff6-9efd1c949119',1),
('d756493f-ff65-11f0-8cd9-02f3bfe33662','Guru','582e4596-bb5b-11f0-8be0-d0008dc32c8f','3ef85676-bcb2-11f0-8ff6-9efd1c949119',1),
('f861d1c1-600f-4799-98a3-20d75c7dd5e3','Siswa','582e4596-bb5b-11f0-8be0-d0008dc32c8f','a8262175-69d1-484b-a1d1-4e8bb30ed704',1),
('fd65700b-70b0-40cb-9f25-8741191da8c9','Guru','582e4596-bb5b-11f0-8be0-d0008dc32c8f','9a779851-8f0e-4f35-9ea0-8a46f06c2848',1);
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(512) DEFAULT NULL,
  `verification_code` varchar(10) DEFAULT NULL,
  `verified` tinyint(4) NOT NULL DEFAULT 1,
  `role` enum('Dev','Superadmin','Kepala Sekolah','Admin Sekolah','Guru','Siswa','Unset','Wali','Affiliate','Bendahara') DEFAULT NULL,
  `school_id` varchar(36) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES
('010524ff-bb23-11f0-8be0-d0008dc32c8f','Si Admin Sekolah','admin_sekolah','admin_sekolah@me.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Admin Sekolah','582e4596-bb5b-11f0-8be0-d0008dc32c8f','2025-11-06 08:12:25','2025-11-06 08:12:25',NULL),
('046a8563-bb0a-11f0-8be0-d0008dc32c8f','','saya','saya@me.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Dev',NULL,'2025-11-06 05:13:33','2025-11-06 05:13:33',NULL),
('0fc58aca-22c6-49ed-9a69-6cfa8971feeb','Saiful Anwar','saifulgrtanwar@gmail.com','saifulgrtanwar@gmail.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Unset',NULL,'2026-05-17 00:43:55','2026-05-17 00:43:55',NULL),
('20e98451-d15a-46b0-8205-68ce8bdb28fd','Admin 2','admin2','admin2@me.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Admin Sekolah','8061ca5c-2ef5-e011-ad7e-ffe7f6f833dd','2026-02-19 15:16:06','2026-02-19 15:16:06',NULL),
('2211617a-d055-11f0-8de5-e8758f708443','guru2@me.com','guru2@me.com','guru2@me.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Guru','582e4596-bb5b-11f0-8be0-d0008dc32c8f','2025-12-03 14:34:11','2025-12-03 14:34:11',NULL),
('2b377276-0884-4657-901d-f5a9232373dd','asal@me.com','asal@me.com','asal@me.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Siswa','582e4596-bb5b-11f0-8be0-d0008dc32c8f','2026-07-09 14:41:34','2026-07-09 14:41:34',NULL),
('41a33677-d20f-11f0-9116-8377c8874adf','tes@gmail.com','tes@gmail.com','tes@gmail.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Wali',NULL,'2025-12-05 12:19:00','2025-12-05 12:19:00',NULL),
('459e0104-d26c-40c6-9a5c-117cc6ec008a','wali_banyak@me.com','wali_banyak@me.com','wali_banyak@me.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Unset',NULL,'2026-07-18 05:04:32','2026-07-18 05:04:32',NULL),
('57b26acf-f9fa-11f0-8ff2-507868a2f2d9','The Dev','the_dev','dev@me.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Dev',NULL,'2025-11-06 08:12:25','2025-11-06 08:12:25',NULL),
('5b81ce5e-cce5-11f0-8f97-aa3b281802c1','Rala Syifa','wali@me.com','wali@me.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Wali','582e4596-bb5b-11f0-8be0-d0008dc32c8f','2025-11-29 05:36:30','2025-11-29 05:36:30',NULL),
('5b81ce5e-cce5-11f0-8f97-aa3b281802c3','Si Komo','affiliate@me.com','affiliate@me.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Affiliate',NULL,'2025-11-29 05:36:30','2025-11-29 05:36:30',NULL),
('5cb82430-a41a-4be2-b25b-88ff583d7cca','Saya','admin_tes','test@me.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Admin Sekolah','0001795c-2ef5-e011-a96c-63a882fbcc5a','2026-05-16 06:43:49','2026-05-16 06:43:49',NULL),
('60a633b4-b316-4019-93d5-d262120d3263','asal4@me.com','asal4@me.com','asal4@me.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Siswa','582e4596-bb5b-11f0-8be0-d0008dc32c8f','2026-07-09 14:50:22','2026-07-09 14:50:22',NULL),
('71302376-f9fa-11f0-8ff2-507868a2f2d9','Si Superadmin','superadmin','superadmin@me.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Superadmin',NULL,'2025-11-06 08:12:25','2025-11-06 08:12:25',NULL),
('7296ff26-bca0-11f0-8ff6-9efd1c949119','Bintang Kejora','guru','guru@me.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Guru','582e4596-bb5b-11f0-8be0-d0008dc32c8f','2025-11-08 12:42:55','2025-11-08 12:42:55',NULL),
('753714e1-cfc6-4290-8a02-0c972ad1a1b8','guru_banyak@me.com','guru_banyak@me.com','guru_banyak@me.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Unset','582e4596-bb5b-11f0-8be0-d0008dc32c8f','2026-07-17 10:42:49','2026-07-17 10:42:49',NULL),
('76954a42-148d-47b0-a0c5-1843df21c7dd','siswa_bopkri@me.com','siswa_bopkri@me.com','siswa_bopkri@me.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Siswa','0005ed5c-2ef5-e011-9fee-6124ccb9e3de','2026-07-09 01:06:30','2026-07-09 01:06:30',NULL),
('77afb720-8611-4bb7-9219-c95e822c6eff','asal5@me.com','asal5@me.com','asal5@me.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Siswa','582e4596-bb5b-11f0-8be0-d0008dc32c8f','2026-07-09 14:52:32','2026-07-09 14:52:32',NULL),
('7e4a190a-6b5c-41b8-9f72-1bdc38696f02','guru_bopkri@me.com','guru_bopkri@me.com','guru_bopkri@me.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Guru','0005ed5c-2ef5-e011-9fee-6124ccb9e3de','2026-07-09 01:18:47','2026-07-09 01:18:47',NULL),
('85bf2f94-df91-4fdb-b32c-76fa74541341','asal123@me.com','asal123@me.com','asal123@me.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Siswa','582e4596-bb5b-11f0-8be0-d0008dc32c8f','2026-07-09 14:49:22','2026-07-09 14:49:22',NULL),
('877831ed-e0d6-11f0-8cf3-14525ee252f4','aku@me.com','aku@me.com','aku@me.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Unset',NULL,'2025-12-24 14:40:44','2025-12-24 14:40:44',NULL),
('8a0d83d0-627d-4e73-9450-5c877aa6a426','Admin Bopkri','admin_bopkri','admin_xxx@me.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Admin Sekolah','0005ed5c-2ef5-e011-9fee-6124ccb9e3de','2026-07-09 00:55:27','2026-07-09 00:55:27',NULL),
('9249e048-6ab6-435e-b98e-ff66367cef4b','wali_bopkri@me.com','wali_bopkri@me.com','wali_bopkri@me.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Wali','0005ed5c-2ef5-e011-9fee-6124ccb9e3de','2026-07-09 01:12:48','2026-07-09 01:12:48',NULL),
('b156a727-49fa-4b31-a5e7-c32fee53f70d','siswa2@me.com','siswa2@me.com','siswa2@me.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Siswa','582e4596-bb5b-11f0-8be0-d0008dc32c8f','2026-06-25 03:00:40','2026-06-25 03:00:40',NULL),
('b5f21a39-de57-11f0-90ff-2ab91f72dcfa','xxx@me.com','xxx@me.com','xxx@me.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Unset',NULL,'2025-12-21 10:27:54','2025-12-21 10:27:54',NULL),
('b93a4dd8-cb6d-42fe-b469-9e559d4d6a00','siswa_banyak@me.com','siswa_banyak@me.com','siswa_banyak@me.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Unset','582e4596-bb5b-11f0-8be0-d0008dc32c8f','2026-07-17 08:43:48','2026-07-17 08:43:48',NULL),
('bb14d3e5-008b-45b8-b40c-e0ee190633da','test123@me.com','test123@me.com','test123@me.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Siswa','582e4596-bb5b-11f0-8be0-d0008dc32c8f','2026-07-09 14:48:10','2026-07-09 14:48:10',NULL),
('bdfc6e26-601f-4166-a96d-648efb9791ad','mt dua','mtcaptro2@gmail.com','mtcaptro2@gmail.com',NULL,NULL,1,'Wali','582e4596-bb5b-11f0-8be0-d0008dc32c8f','2026-06-25 10:37:29','2026-06-25 10:37:29',NULL),
('c6f6509e-cd23-4d76-801d-a6eac5c0fa94','kita@me.com','kita@me.com','kita@me.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Unset',NULL,'2026-06-12 15:52:19','2026-06-12 15:52:19',NULL),
('c8e84675-df12-11f0-90ed-b264de2d43ca','siapa@me.com','siapa@me.com','siapa@me.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Guru','582e4596-bb5b-11f0-8be0-d0008dc32c8f','2025-12-22 08:47:02','2025-12-22 08:47:02',NULL),
('c99ac0e8-e23e-11f0-9279-5798f3f8052c','wamena@me.com','wamena@me.com','wamena@me.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Guru','582e4596-bb5b-11f0-8be0-d0008dc32c8f','2025-12-26 09:39:34','2025-12-26 09:39:34',NULL),
('d52b3378-3e12-4b67-86b8-79eba408c87e','siswa@me.com','siswa@me.com','siswa@me.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Siswa','582e4596-bb5b-11f0-8be0-d0008dc32c8f','2026-06-18 09:22:58','2026-06-18 09:22:58',NULL),
('d756493f-ff65-11f0-8cd9-02f3bfe33662','LAM ALIF','ulilaidi00000@gmail.com','ulilaidi00000@gmail.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Guru','582e4596-bb5b-11f0-8be0-d0008dc32c8f','2026-02-01 12:02:11','2026-02-01 12:02:11',NULL),
('f084d65f-bb22-11f0-8be0-d0008dc32c8f','Kepala Sekolah','kepala_sekolah','kepsek@me.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Kepala Sekolah','582e4596-bb5b-11f0-8be0-d0008dc32c8f','2025-11-06 08:11:57','2025-11-06 08:11:57',NULL),
('f696a9ac-d628-4002-a559-b2253c00f49c','Admin Jaya','admin_jaya','admin_jaya@me.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Admin Sekolah','28c25337-f7f7-43cd-aeb7-e80b6e3a35f0','2026-07-17 06:16:54','2026-07-17 06:16:54',NULL),
('f861d1c1-600f-4799-98a3-20d75c7dd5e3','ganyang@me.com','ganyang@me.com','ganyang@me.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,1,'Siswa','582e4596-bb5b-11f0-8be0-d0008dc32c8f','2026-07-16 08:40:57','2026-07-16 08:40:57',NULL),
('fd65700b-70b0-40cb-9f25-8741191da8c9','GrT Music','jodisumarno1@gmail.com','jodisumarno1@gmail.com',NULL,NULL,1,'Guru','582e4596-bb5b-11f0-8be0-d0008dc32c8f','2026-02-01 12:25:48','2026-02-01 12:25:48',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `years`
--

DROP TABLE IF EXISTS `years`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `years` (
  `id` varchar(36) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `years`
--

LOCK TABLES `years` WRITE;
/*!40000 ALTER TABLE `years` DISABLE KEYS */;
INSERT INTO `years` VALUES
('c02184d2-bfd2-11f0-8d7c-cdee4485d185','2024/2025'),
('c02187d2-bfd2-11f0-8d7c-cdee4485d186','2025/2026');
/*!40000 ALTER TABLE `years` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-18 14:56:16
