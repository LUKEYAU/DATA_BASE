SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";
-- Database: `university`

CREATE TABLE `courses` (
  `course_id` int(11) NOT NULL,
  `course_name` varchar(255) NOT NULL,
  `department` varchar(255) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `enrolled_students` int(11) DEFAULT 0,
  `is_required` tinyint(1) DEFAULT NULL,
  `credits` int(11) DEFAULT NULL,
  `course_time` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `courses` (`course_id`,`course_name`, `department`, `capacity`, `enrolled_students`, `is_required`, `credits`, `course_time`) VALUES
(1, '系統程式', 'Computer Science', 6, 1, 1, 5, 'Monday 9AM-12PM'),
(2, '資料庫系統', 'Computer Science', 6, 1, 1, 5, 'Wednesday 9AM-12PM'),
(3, '機率與統計', 'Computer Science', 6, 1, 1, 5, 'Tuesday 2PM-5PM'),
(4, '互連網路', 'Computer Science', 5, 1, 0, 4, 'Thursday 2PM-5PM'),
(5, 'Web程式設計', 'Computer Science', 5, 1, 0, 4, 'Monday 1PM - 12PM'),
(6, '系統分析與設計', 'Computer Science', 5, 1, 0, 4, 'Friday 9AM-11AM'),
(7, '多媒體系統', 'Computer Science', 5, 1, 0, 4, 'Monday 1PM-3PM'),
(8, '電子商務安全', 'Computer Science', 5, 1, 0, 4, 'Friday 2PM-5PM'),
(9, 'UNIX應用與實務', 'Computer Science', 5, 1, 0, 4, 'Thursday 2PM-5PM'),
(10, '數位系統設計', 'Computer Science', 5, 1, 0, 4, 'Wednesday 1PM-3PM'),
(11, '數位系統設計實驗', 'Computer Science', 5, 1, 0, 4, 'Wednesday 3PM-4PM'),
(12, '工程數學(二)', 'Chemical Engineering', 5, 1, 0, 4, 'Tuesday 9AM-12PM'),
(13, '影像創作與視覺行銷', 'Marketing', 5, 0, 0, 4, 'Thursday 1PM-4PM');


CREATE TABLE `students` (
  `student_id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `department` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


INSERT INTO `students` (`student_id`, `name`, `department`) VALUES
('1', 'Alice Wang', 'Computer Science'),
('2', 'Bob Lee', 'Electrical Engineering'),
('3', 'Carol Wu', 'Computer Science'),
('d1130836', '邱家悅', 'Computer Science'),
('d1149958', '張庭毓', 'Computer Science'),
('d1177557', '陳俊爾', 'Computer Science'),
('d1185370', '林森茂', 'Computer Science');



CREATE TABLE `enrollments` (
  `enrollment_id` int(11) NOT NULL,
  `student_id` varchar(255) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  `watching` BOOLEAN NOT NULL DEFAULT FALSE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


ALTER TABLE `courses`
  ADD PRIMARY KEY (`course_id`);

ALTER TABLE `enrollments`
  ADD PRIMARY KEY (`enrollment_id`),
  ADD KEY `course_id` (`course_id`),
  ADD KEY `student_id` (`student_id`);

ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`);

ALTER TABLE `courses`
  MODIFY `course_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

ALTER TABLE `enrollments`
  MODIFY `enrollment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

ALTER TABLE `enrollments`
  ADD CONSTRAINT `fk_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`);

INSERT INTO `enrollments` (`student_id`, `course_id`)
SELECT s.student_id, c.course_id
FROM `students` s
JOIN `courses` c ON s.department = c.department
WHERE c.is_required = 1
  AND NOT EXISTS (
    SELECT 1 FROM `enrollments` e
    WHERE e.student_id = s.student_id AND e.course_id = c.course_id
  );
UPDATE `courses` c
SET c.enrolled_students = (
    SELECT COUNT(*)
    FROM `enrollments` e
    WHERE e.course_id = c.course_id
  );
