-- =============================================================================
-- Complete SQL Script for shift_ai_db
-- This script creates the database, all tables, inserts initial data,
-- and applies modifications to support TeamGShift functionality.
--
-- IMPORTANT:
-- - This script will DROP and CREATE tables, leading to DATA LOSS if run on an existing database.
-- - BACKUP YOUR DATABASE BEFORE RUNNING THIS SCRIPT!
-- =============================================================================

-- Create Database
CREATE DATABASE IF NOT EXISTS shift_ai_db;
USE shift_ai_db;

-- Original TeamG Tables (with DROP TABLE for clean setup)

-- Table structure for table `account`
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `account_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('ADMIN','USER') DEFAULT 'USER',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `account`
INSERT INTO `account` VALUES (1,'admin','admin123','ADMIN','2025-10-20 00:58:45'),(2,'yamada','yamada123','USER','2025-10-20 00:58:45'),(3,'tanaka','tanaka123','USER','2025-10-20 00:58:45');

-- Table structure for table `company`
DROP TABLE IF EXISTS `company`;
CREATE TABLE `company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_code` varchar(50) NOT NULL,
  `company_name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `company_code` (`company_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `company`
-- No initial data provided in original TeamG script for company

-- Table structure for table `department`
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `dept_id` int(11) NOT NULL AUTO_INCREMENT,
  `dept_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `department`
INSERT INTO `department` VALUES (1,'ホール','接客を担当するエリア'),(2,'厨房','料理を作るエリア'),(3,'レジ','お会計を行うエリア'),(4,'倉庫','在庫を管理するエリア');

-- Table structure for table `user`
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `gender` enum('男性','女性','その他') NOT NULL,
  `position` enum('アルバイト','社員','店長','リーダー','ADMIN') NOT NULL,
  `workplace` enum('厨房','ホール','倉庫','レジ') NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `joined_date` date DEFAULT curdate(),
  PRIMARY KEY (`user_id`),
  KEY `account_id` (`account_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `user`
INSERT INTO `user` VALUES (1,1,'管理者 太郎','男性','ADMIN','ホール','080-0000-0000','admin@example.com','2025-10-20'),(2,2,'山田 花子','女性','アルバイト','厨房','080-1111-1111','yamada@example.com','2025-10-20'),(3,3,'田中 一郎','男性','リーダー','レジ','080-2222-2222','tanaka@example.com','2025-10-20');

-- Table structure for table `user_department`
DROP TABLE IF EXISTS `user_department`;
CREATE TABLE `user_department` (
  `user_id` int(11) NOT NULL,
  `dept_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`dept_id`),
  KEY `dept_id` (`dept_id`),
  CONSTRAINT `user_department_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `user_department_ibfk_2` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `user_department`
-- No initial data provided in original TeamG script for user_department

-- Table structure for table `shift`
DROP TABLE IF EXISTS `shift`;
CREATE TABLE `shift` (
  `shift_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `shift_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `status` enum('未提出','提出済み','確認済み') DEFAULT '未提出',
  PRIMARY KEY (`shift_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `shift_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table `shift`
INSERT INTO `shift` VALUES (1,2,'2025-10-10','09:00:00','15:00:00','提出済み'),(2,3,'2025-10-11','12:00:00','20:00:00','確認済み');


-- =============================================================================
-- Modifications to support TeamGShift functionality
-- =============================================================================

-- 1. Create 'role' table
CREATE TABLE IF NOT EXISTS `role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) NOT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_name` (`role_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert default roles if they don't exist
INSERT IGNORE INTO `role` (`role_name`) VALUES ('ADMIN'), ('USER');


-- 2. Modify 'account' table
-- Change 'role' ENUM to 'role_id' INT with Foreign Key to 'role' table
-- Temporarily disable foreign key checks to allow dropping/modifying columns
SET FOREIGN_KEY_CHECKS = 0;

-- Drop the old 'role' column if it exists
ALTER TABLE `account` DROP COLUMN IF EXISTS `role`;

-- Add the new role_id column
ALTER TABLE `account` ADD COLUMN `role_id` INT(11) DEFAULT 2; -- Default to USER role_id

-- Update existing accounts to map old 'role' ENUM to new 'role_id'
-- This part needs to be done carefully based on your existing data.
-- Assuming 'ADMIN' maps to role_id 1 and 'USER' maps to role_id 2
-- This UPDATE will only work if the 'role' column still exists.
-- If 'role' column was dropped, you'll need to manually set role_id for existing accounts.
-- For a fresh setup, the default value of 2 (USER) is applied.
-- If you have existing data and want to preserve roles, you'd need to run this BEFORE dropping 'role'.
-- UPDATE `account` SET `role_id` = (SELECT `role_id` FROM `role` WHERE `role_name` = 'ADMIN') WHERE `role` = 'ADMIN';
-- UPDATE `account` SET `role_id` = (SELECT `role_id` FROM `role` WHERE `role_name` = 'USER') WHERE `role` = 'USER';

-- Make role_id NOT NULL
ALTER TABLE `account` MODIFY COLUMN `role_id` INT(11) NOT NULL;

-- Add foreign key constraint
ALTER TABLE `account` ADD CONSTRAINT `fk_account_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`);

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;


-- 3. Modify 'company' table
-- Ensure primary key is named 'company_id' as expected by UserDAO
-- If your PK is 'id', rename it. If it's already 'company_id', this step is skipped.
-- Check if 'id' column exists and is the primary key
-- ALTER TABLE `company` CHANGE `id` `company_id` INT(11) NOT NULL AUTO_INCREMENT;


-- 4. Modify 'user' table
-- Add 'company_id' and remove 'workplace'
-- Temporarily disable foreign key checks
SET FOREIGN_KEY_CHECKS = 0;

-- Drop existing foreign key constraints if any (adjust constraint name if different)
ALTER TABLE `user` DROP FOREIGN KEY IF EXISTS `user_ibfk_1`;
-- ALTER TABLE `user` DROP FOREIGN KEY IF EXISTS `user_ibfk_2`; -- If you had a second FK

-- Add the new company_id column
ALTER TABLE `user` ADD COLUMN `company_id` INT(11) DEFAULT 1; -- Default to a valid company_id if existing users need one

-- Update existing users with a company_id if needed (e.g., all users belong to company 1)
-- UPDATE `user` SET `company_id` = 1 WHERE `company_id` IS NULL;

-- Make company_id NOT NULL
ALTER TABLE `user` MODIFY COLUMN `company_id` INT(11) NOT NULL;

-- Add foreign key constraint
ALTER TABLE `user` ADD CONSTRAINT `fk_user_company` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`); -- Reference original 'id' if not renamed

-- Drop the old 'workplace' column if it exists and is not needed
ALTER TABLE `user` DROP COLUMN IF EXISTS `workplace`;

-- Ensure 'email' is unique if not already
ALTER TABLE `user` ADD UNIQUE INDEX `email_unique` (`email`);

-- Re-add original foreign key for account_id
ALTER TABLE `user` ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`);

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;


-- 5. Modify 'shift' table
-- Add 'dept_id', 'created_at', 'approved_by' and update 'status' ENUM
-- Temporarily disable foreign key checks
SET FOREIGN_KEY_CHECKS = 0;

-- Drop existing foreign key constraints if any
ALTER TABLE `shift` DROP FOREIGN KEY IF EXISTS `shift_ibfk_1`;
-- ALTER TABLE `shift` DROP FOREIGN KEY IF EXISTS `shift_ibfk_2`; -- If you had a second FK
-- ALTER TABLE `shift` DROP FOREIGN KEY IF EXISTS `shift_ibfk_3`; -- If you had a third FK

-- Add dept_id column
ALTER TABLE `shift` ADD COLUMN `dept_id` INT(11) DEFAULT 1; -- Default to a valid dept_id
-- Update existing shifts with a dept_id if needed
-- UPDATE `shift` SET `dept_id` = 1 WHERE `dept_id` IS NULL;
ALTER TABLE `shift` MODIFY COLUMN `dept_id` INT(11) NOT NULL;
ALTER TABLE `shift` ADD CONSTRAINT `fk_shift_department` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`);

-- Add created_at column
ALTER TABLE `shift` ADD COLUMN `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- Add approved_by column
ALTER TABLE `shift` ADD COLUMN `approved_by` INT(11) DEFAULT NULL;
ALTER TABLE `shift` ADD CONSTRAINT `fk_shift_approved_by` FOREIGN KEY (`approved_by`) REFERENCES `user` (`user_id`);

-- Update ENUM for status (be careful with existing data, this might truncate existing values if they don't match)
ALTER TABLE `shift` MODIFY COLUMN `status` ENUM('未提出','提出済み','確認済み','拒否') DEFAULT '未提出';

-- Re-add original foreign key for user_id
ALTER TABLE `shift` ADD CONSTRAINT `shift_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;
