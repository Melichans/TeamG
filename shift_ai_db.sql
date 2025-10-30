-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: shift_ai_db
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `account_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `username` (`username`),
  KEY `fk_account_role` (`role_id`),
  CONSTRAINT `fk_account_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,'admin','admin123','2025-10-19 15:58:45',2),(2,'yamada','yamada123','2025-10-19 15:58:45',2),(3,'tanaka','tanaka123','2025-10-19 15:58:45',2),(4,'c1_user01','pass01','2025-10-28 01:00:00',2),(5,'c1_user02','pass02','2025-10-28 01:01:00',2),(6,'c1_user03','pass03','2025-10-28 01:02:00',2),(7,'c2_user01','pass01','2025-10-28 01:03:00',2),(8,'c2_user02','pass02','2025-10-28 01:04:00',2),(9,'c2_user03','pass03','2025-10-28 01:05:00',2);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company` (
  `company_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_code` varchar(50) NOT NULL,
  `company_name` varchar(100) NOT NULL,
  PRIMARY KEY (`company_id`),
  UNIQUE KEY `company_code` (`company_code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES (1,'COMP001','株式会社レストランA'),(2,'COMP002','株式会社レストランB');
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `dept_id` int(11) NOT NULL AUTO_INCREMENT,
  `dept_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'ホール','接客を担当するエリア'),(2,'厨房','料理を作るエリア'),(3,'レジ','お会計を行うエリア'),(4,'倉庫','在庫を管理するエリア');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notice`
--

DROP TABLE IF EXISTS `notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notice` (
  `notice_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `message` text DEFAULT NULL,
  `notice_date` datetime DEFAULT current_timestamp(),
  `is_read` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notice`
--

LOCK TABLES `notice` WRITE;
/*!40000 ALTER TABLE `notice` DISABLE KEYS */;
INSERT INTO `notice` VALUES (2,'シフト提出','シフト提出締切間近です','2025-10-29 09:38:17',1),(3,'システムへようこそ！','これはサンプルのお知らせです。掲示板機能が正常に動作しています。','2025-10-29 09:46:13',0),(4,'新機能のお知らせ','マイページに新しい設定項目が追加されました。ぜひご確認ください。','2025-10-29 09:46:13',0),(5,'メンテナンスのお知らせ','下記の日程でシステムメンテナンスを実施します。期間中はサービスをご利用いただけません。\n2025年11月15日 02:00～04:00','2025-10-29 09:46:13',1);
/*!40000 ALTER TABLE `notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) NOT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_name` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'ADMIN'),(2,'USER');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shift`
--

DROP TABLE IF EXISTS `shift`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shift` (
  `shift_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `shift_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `status` enum('未提出','提出済み','確認済み','拒否','募集') DEFAULT '未提出',
  `dept_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `approved_by` int(11) DEFAULT NULL,
  `memo` text DEFAULT NULL,
  PRIMARY KEY (`shift_id`),
  KEY `user_id` (`user_id`),
  KEY `fk_shift_approved_by` (`approved_by`),
  KEY `fk_shift_dept` (`dept_id`),
  CONSTRAINT `fk_shift_approved_by` FOREIGN KEY (`approved_by`) REFERENCES `user` (`user_id`),
  CONSTRAINT `fk_shift_department` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`),
  CONSTRAINT `fk_shift_dept` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`),
  CONSTRAINT `shift_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shift`
--

LOCK TABLES `shift` WRITE;
/*!40000 ALTER TABLE `shift` DISABLE KEYS */;
INSERT INTO `shift` VALUES (1,2,'2025-10-10','09:00:00','15:00:00','確認済み',1,'2025-10-22 04:15:22',NULL,NULL),(2,3,'2025-10-11','12:00:00','20:00:00','確認済み',1,'2025-10-22 04:15:22',NULL,NULL),(4,2,'2025-10-11','10:00:00','18:00:00','確認済み',2,'2025-10-23 01:01:18',NULL,NULL),(5,2,'2025-10-12','10:00:00','18:00:00','確認済み',2,'2025-10-23 01:01:18',NULL,NULL),(6,2,'2025-10-13','12:00:00','20:00:00','確認済み',2,'2025-10-23 01:01:18',NULL,NULL),(7,2,'2025-10-14','12:00:00','20:00:00','確認済み',2,'2025-10-23 01:01:18',NULL,NULL),(8,2,'2025-10-17','10:00:00','18:00:00','確認済み',2,'2025-10-23 01:01:18',NULL,NULL),(9,2,'2025-10-18','10:00:00','18:00:00','確認済み',2,'2025-10-23 01:01:18',NULL,NULL),(10,2,'2025-10-19','10:00:00','18:00:00','確認済み',2,'2025-10-23 01:01:18',NULL,NULL),(11,3,'2025-10-10','10:00:00','18:00:00','確認済み',3,'2025-10-23 01:01:18',NULL,NULL),(12,3,'2025-10-11','10:00:00','18:00:00','確認済み',3,'2025-10-23 01:01:18',NULL,NULL),(13,3,'2025-10-12','12:00:00','20:00:00','確認済み',3,'2025-10-23 01:01:18',NULL,NULL),(14,3,'2025-10-13','12:00:00','20:00:00','確認済み',3,'2025-10-23 01:01:18',NULL,NULL),(15,3,'2025-10-14','14:00:00','22:00:00','確認済み',3,'2025-10-23 01:01:18',NULL,NULL),(16,3,'2025-10-15','14:00:00','22:00:00','確認済み',3,'2025-10-23 01:01:18',NULL,NULL),(17,3,'2025-10-16','14:00:00','22:00:00','確認済み',3,'2025-10-23 01:01:18',NULL,NULL),(18,3,'2025-10-17','12:00:00','20:00:00','確認済み',3,'2025-10-23 01:01:18',NULL,NULL),(21,3,'2025-12-03','07:00:00','21:00:00','確認済み',1,'2025-10-28 02:48:18',NULL,''),(22,3,'2025-12-04','07:00:00','21:00:00','確認済み',1,'2025-10-28 02:54:00',NULL,''),(23,3,'2025-12-06','07:00:00','21:00:00','確認済み',1,'2025-10-28 02:54:04',NULL,''),(24,3,'2025-12-05','07:00:00','21:00:00','確認済み',4,'2025-10-28 02:54:29',NULL,''),(25,3,'2025-12-11','07:00:00','21:00:00','確認済み',1,'2025-10-28 03:05:54',NULL,''),(26,3,'2025-12-13','14:00:00','17:00:00','確認済み',1,'2025-10-28 03:06:00',NULL,''),(27,2,'2025-11-01','09:00:00','17:00:00','確認済み',1,'2025-10-28 05:07:56',NULL,'夕方対応可'),(28,2,'2025-11-03','10:00:00','18:00:00','確認済み',1,'2025-10-28 05:07:56',NULL,''),(29,2,'2025-11-05','11:00:00','19:00:00','確認済み',2,'2025-10-28 05:07:56',NULL,'厨房ヘルプ'),(30,3,'2025-11-02','09:00:00','15:00:00','確認済み',2,'2025-10-28 05:07:56',NULL,''),(31,3,'2025-11-04','12:00:00','20:00:00','確認済み',2,'2025-10-28 05:07:56',NULL,''),(32,3,'2025-11-07','09:00:00','17:00:00','確認済み',3,'2025-10-28 05:07:56',NULL,'レジ研修'),(33,4,'2025-11-01','08:00:00','16:00:00','確認済み',1,'2025-10-28 05:07:56',NULL,'店長業務'),(34,4,'2025-11-08','10:00:00','18:00:00','確認済み',1,'2025-10-28 05:07:56',NULL,''),(35,5,'2025-11-01','10:00:00','18:00:00','確認済み',3,'2025-10-28 05:07:56',NULL,''),(36,5,'2025-11-03','12:00:00','20:00:00','確認済み',3,'2025-10-28 05:07:56',NULL,''),(37,5,'2025-11-06','09:00:00','17:00:00','確認済み',1,'2025-10-28 05:07:56',NULL,''),(38,6,'2025-11-02','09:00:00','17:00:00','確認済み',1,'2025-10-28 05:07:56',NULL,''),(39,6,'2025-11-05','11:00:00','19:00:00','確認済み',2,'2025-10-28 05:07:56',NULL,''),(40,7,'2025-11-04','08:00:00','16:00:00','確認済み',4,'2025-10-28 05:07:56',NULL,'倉庫作業'),(41,7,'2025-11-09','07:00:00','15:00:00','確認済み',4,'2025-10-28 05:07:56',NULL,''),(42,2,'2025-12-01','09:00:00','17:00:00','確認済み',1,'2025-10-28 05:07:56',NULL,NULL),(43,2,'2025-12-02','10:00:00','18:00:00','確認済み',2,'2025-10-28 05:07:56',NULL,NULL),(44,2,'2025-12-05','09:00:00','17:00:00','確認済み',1,'2025-10-28 05:07:56',NULL,NULL),(45,5,'2025-12-03','10:00:00','18:00:00','確認済み',3,'2025-10-28 05:07:56',NULL,NULL),(46,5,'2025-12-04','12:00:00','20:00:00','確認済み',3,'2025-10-28 05:07:56',NULL,NULL),(47,5,'2025-12-06','09:00:00','17:00:00','確認済み',1,'2025-10-28 05:07:56',NULL,NULL),(48,NULL,'2025-11-01','09:00:00','17:00:00','募集',1,'2025-10-29 00:33:28',NULL,'週末のラッシュ時のヘルプが必要です。'),(49,NULL,'2025-11-02','12:00:00','21:00:00','募集',2,'2025-10-29 00:33:28',NULL,'経験豊富な調理師を募集します。'),(50,NULL,'2025-11-03','17:00:00','22:00:00','募集',1,'2025-10-29 00:33:28',NULL,'夜間シフトのカバーが必要です。'),(51,NULL,'2025-10-30','09:00:00','17:00:00','募集',1,'2025-10-29 00:55:40',NULL,'急募！ホールスタッフを1名募集します。'),(52,NULL,'2025-10-30','12:00:00','20:00:00','募集',2,'2025-10-29 00:55:40',NULL,'厨房が人手不足のため、募集します。経験者歓迎！'),(53,NULL,'2025-10-31','10:00:00','18:00:00','募集',3,'2025-10-29 00:55:40',NULL,'レジ担当を募集します。未経験でも大丈夫です。'),(54,NULL,'2025-11-10','10:00:00','18:00:00','募集',1,'2025-10-29 00:59:54',NULL,'週末のホールスタッフを募集します。経験者歓迎！'),(55,NULL,'2025-11-12','12:00:00','21:00:00','募集',2,'2025-10-29 00:59:54',NULL,'ランチタイムの厨房補助。簡単な調理です。'),(56,NULL,'2025-11-15','09:00:00','15:00:00','募集',3,'2025-10-29 00:59:54',NULL,'朝の時間帯のレジ担当。未経験でも大丈夫です。'),(57,NULL,'2025-11-18','15:00:00','20:00:00','募集',4,'2025-10-29 00:59:54',NULL,'夕方からの倉庫整理。力仕事に自信のある方。');
/*!40000 ALTER TABLE `shift` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `gender` enum('男性','女性','その他') NOT NULL,
  `position` enum('アルバイト','社員','店長','リーダー','ADMIN') NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `joined_date` date DEFAULT curdate(),
  `company_id` int(11) NOT NULL,
  `push_notifications_enabled` tinyint(1) DEFAULT 1 COMMENT 'プッシュ通知が有効かどうかのフラグ',
  `language` varchar(10) DEFAULT 'ja' COMMENT 'ユーザーが選択した言語 (e.g., ja, en)',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email_unique` (`email`),
  KEY `account_id` (`account_id`),
  KEY `fk_user_company` (`company_id`),
  CONSTRAINT `fk_user_company` FOREIGN KEY (`company_id`) REFERENCES `company` (`company_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,1,'管理者 太郎','男性','ADMIN','080-0000-0000','admin@example.com','2025-10-20',1,1,'ja'),(2,2,'山田 花子','女性','アルバイト','080-1111-1111','yamada@example.com','2025-10-20',1,1,'ja'),(3,3,'田中 一郎','男性','リーダー','080-2222-2222','tanaka@example.com','2025-10-20',1,1,'ja'),(4,2,'佐藤 花子','女性','アルバイト','080-3333-0001','sato_h@example.com','2025-10-28',1,1,'ja'),(5,3,'鈴木 次郎','男性','社員','080-3333-0002','suzuki_j@example.com','2025-10-28',1,1,'ja'),(6,4,'高橋 美咲','女性','店長','080-3333-0003','takahashi_m@example.com','2025-10-28',1,1,'ja'),(7,5,'井上 大輔','男性','アルバイト','080-4444-0001','inoue_d@example.com','2025-10-28',2,1,'ja'),(8,6,'中村 真由','女性','リーダー','080-4444-0002','nakamura_m@example.com','2025-10-28',2,1,'ja'),(9,7,'小林 拓也','男性','社員','080-4444-0003','kobayashi_t@example.com','2025-10-28',2,1,'ja');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_department`
--

DROP TABLE IF EXISTS `user_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_department` (
  `user_id` int(11) NOT NULL,
  `dept_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`dept_id`),
  KEY `dept_id` (`dept_id`),
  CONSTRAINT `user_department_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `user_department_ibfk_2` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_department`
--

LOCK TABLES `user_department` WRITE;
/*!40000 ALTER TABLE `user_department` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'shift_ai_db'
--

--
-- Dumping routines for database 'shift_ai_db'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-30 11:18:11
