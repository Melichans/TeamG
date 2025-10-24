-- Sample shift data for Yamada (user_id=2) and Tanaka (user_id=3)
-- Please execute this script against your shift_ai_db database.

-- Shifts for Yamada (user_id=2, dept_id=2 '厨房')
INSERT INTO shift (user_id, dept_id, shift_date, start_time, end_time, status) VALUES (2, 2, '2025-10-10', '10:00:00', '18:00:00', '提出済み');
INSERT INTO shift (user_id, dept_id, shift_date, start_time, end_time, status) VALUES (2, 2, '2025-10-11', '10:00:00', '18:00:00', '提出済み');
INSERT INTO shift (user_id, dept_id, shift_date, start_time, end_time, status) VALUES (2, 2, '2025-10-12', '10:00:00', '18:00:00', '提出済み');
INSERT INTO shift (user_id, dept_id, shift_date, start_time, end_time, status) VALUES (2, 2, '2025-10-13', '12:00:00', '20:00:00', '提出済み');
INSERT INTO shift (user_id, dept_id, shift_date, start_time, end_time, status) VALUES (2, 2, '2025-10-14', '12:00:00', '20:00:00', '提出済み');
INSERT INTO shift (user_id, dept_id, shift_date, start_time, end_time, status) VALUES (2, 2, '2025-10-17', '10:00:00', '18:00:00', '提出済み');
INSERT INTO shift (user_id, dept_id, shift_date, start_time, end_time, status) VALUES (2, 2, '2025-10-18', '10:00:00', '18:00:00', '提出済み');
INSERT INTO shift (user_id, dept_id, shift_date, start_time, end_time, status) VALUES (2, 2, '2025-10-19', '10:00:00', '18:00:00', '提出済み');


-- Shifts for Tanaka (user_id=3, dept_id=3 'レジ')
INSERT INTO shift (user_id, dept_id, shift_date, start_time, end_time, status) VALUES (3, 3, '2025-10-10', '10:00:00', '18:00:00', '提出済み');
INSERT INTO shift (user_id, dept_id, shift_date, start_time, end_time, status) VALUES (3, 3, '2025-10-11', '10:00:00', '18:00:00', '提出済み');
INSERT INTO shift (user_id, dept_id, shift_date, start_time, end_time, status) VALUES (3, 3, '2025-10-12', '12:00:00', '20:00:00', '提出済み');
INSERT INTO shift (user_id, dept_id, shift_date, start_time, end_time, status) VALUES (3, 3, '2025-10-13', '12:00:00', '20:00:00', '提出済み');
INSERT INTO shift (user_id, dept_id, shift_date, start_time, end_time, status) VALUES (3, 3, '2025-10-14', '14:00:00', '22:00:00', '提出済み');
INSERT INTO shift (user_id, dept_id, shift_date, start_time, end_time, status) VALUES (3, 3, '2025-10-15', '14:00:00', '22:00:00', '提出済み');
INSERT INTO shift (user_id, dept_id, shift_date, start_time, end_time, status) VALUES (3, 3, '2025-10-16', '14:00:00', '22:00:00', '提出済み');
INSERT INTO shift (user_id, dept_id, shift_date, start_time, end_time, status) VALUES (3, 3, '2025-10-17', '12:00:00', '20:00:00', '提出済み');

