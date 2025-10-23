-- This migration adds settings for push notifications and language to the 'user' table.
-- Please execute these commands on your 'shift_ai_db' database.

ALTER TABLE `user` ADD COLUMN `push_notifications_enabled` BOOLEAN DEFAULT TRUE COMMENT 'プッシュ通知が有効かどうかのフラグ';
ALTER TABLE `user` ADD COLUMN `language` VARCHAR(10) DEFAULT 'ja' COMMENT 'ユーザーが選択した言語 (e.g., ja, en)';

-- Verify the changes
-- DESCRIBE `user`;
