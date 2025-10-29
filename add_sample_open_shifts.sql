-- 掲示板（募集中シフト）用のサンプルデータを追加するSQLスクリプト

-- ホールスタッフの募集
INSERT INTO `shift` (`user_id`, `shift_date`, `start_time`, `end_time`, `status`, `dept_id`, `memo`) VALUES
(NULL, '2025-11-10', '10:00:00', '18:00:00', '募集', 1, '週末のホールスタッフを募集します。経験者歓迎！');

-- 厨房スタッフの募集
INSERT INTO `shift` (`user_id`, `shift_date`, `start_time`, `end_time`, `status`, `dept_id`, `memo`) VALUES
(NULL, '2025-11-12', '12:00:00', '21:00:00', '募集', 2, 'ランチタイムの厨房補助。簡単な調理です。');

-- レジ担当の募集
INSERT INTO `shift` (`user_id`, `shift_date`, `start_time`, `end_time`, `status`, `dept_id`, `memo`) VALUES
(NULL, '2025-11-15', '09:00:00', '15:00:00', '募集', 3, '朝の時間帯のレジ担当。未経験でも大丈夫です。');

-- 倉庫整理の募集
INSERT INTO `shift` (`user_id`, `shift_date`, `start_time`, `end_time`, `status`, `dept_id`, `memo`) VALUES
(NULL, '2025-11-18', '15:00:00', '20:00:00', '募集', 4, '夕方からの倉庫整理。力仕事に自信のある方。');

