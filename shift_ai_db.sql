
-- データベースを作成
CREATE DATABASE IF NOT EXISTS shift_ai_db;
USE shift_ai_db;

-- ロールテーブル作成
CREATE TABLE `role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) NOT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_name` (`role_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ロールのデータベース
INSERT INTO `role` (`role_name`) VALUES ('ADMIN'), ('USER');

-- 企業のテーブル作成
CREATE TABLE `company` (
  `company_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_code` varchar(50) NOT NULL,
  `company_name` varchar(100) NOT NULL,
  PRIMARY KEY (`company_id`),
  UNIQUE KEY `company_code` (`company_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 企業のデータベース
INSERT INTO `company` (`company_code`, `company_name`) VALUES
('COMP001', '株式会社レストランA'),
('COMP002', '株式会社レストランB');

-- アカウントのテーブル作成
CREATE TABLE `account` (
  `account_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL, -- Lưu mật khẩu mã hóa (bcrypt)
  `role_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `username` (`username`),
  CONSTRAINT `account_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- アカウントのデータベース
INSERT INTO `account` VALUES
(1, 'admin', 'hashed_password_admin', 1, '2025-10-20 00:58:45'),
(2, 'yamada', 'hashed_password_yamada', 2, '2025-10-20 00:58:45'),
(3, 'tanaka', 'hashed_password_tanaka', 2, '2025-10-20 00:58:45');

-- 
CREATE TABLE `department` (
  `dept_id` int(11) NOT NULL AUTO_INCREMENT,
  `dept_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `company_id` int(11) NOT NULL,
  PRIMARY KEY (`dept_id`),
  CONSTRAINT `department_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `company` (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 
INSERT INTO `department` VALUES
(1, 'ホール', '接客を担当するエリア', 1),
(2, '厨房', '料理を作るエリア', 1),
(3, 'レジ', 'お会計を行うエリア', 1),
(4, '倉庫', '在庫を管理するエリア', 1);

-- ユーザのテーブル作成
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `company_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `gender` enum('男性','女性','その他') NOT NULL,
  `position` enum('アルバイト','社員','店長','リーダー','ADMIN') NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `joined_date` date DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`),
  KEY `account_id` (`account_id`),
  KEY `company_id` (`company_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`),
  CONSTRAINT `user_ibfk_2` FOREIGN KEY (`company_id`) REFERENCES `company` (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ユーザのデータベース
INSERT INTO `user` VALUES
(1, 1, 1, '管理者 太郎', '男性', 'ADMIN', '080-0000-0000', 'admin@example.com', '2025-10-20'),
(2, 2, 1, '山田 花子', '女性', 'アルバイト', '080-1111-1111', 'yamada@example.com', '2025-10-20'),
(3, 3, 1, '田中 一郎', '男性', 'リーダー', '080-2222-2222', 'tanaka@example.com', '2025-10-20');

-- 
CREATE TABLE `user_department` (
  `user_id` int(11) NOT NULL,
  `dept_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`, `dept_id`),
  CONSTRAINT `user_department_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `user_department_ibfk_2` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 
INSERT INTO `user_department` VALUES
(1, 1),
(2, 2),
(3, 3);

-- シフトのテーブル作成
CREATE TABLE `shift` (
  `shift_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `dept_id` int(11) NOT NULL,
  `shift_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `status` enum('未提出','提出済み','確認済み','拒否') DEFAULT '未提出',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `approved_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`shift_id`),
  KEY `user_id` (`user_id`),
  KEY `dept_id` (`dept_id`),
  KEY `shift_date` (`shift_date`),
  CONSTRAINT `shift_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `shift_ibfk_2` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`),
  CONSTRAINT `shift_ibfk_3` FOREIGN KEY (`approved_by`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- シフトのデータベ
INSERT INTO `shift` VALUES
(1, 2, 2, '2025-10-10', '09:00:00', '15:00:00', '提出済み', '2025-10-20 00:58:45', NULL),
(2, 3, 3, '2025-10-11', '12:00:00', '20:00:00', '確認済み', '2025-10-20 00:58:45', 1);
