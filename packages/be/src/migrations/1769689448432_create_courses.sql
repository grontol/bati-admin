CREATE TABLE `courses` (
  `id` varchar(36) NOT NULL PRIMARY KEY,
  `school_id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `course_schedules` (
  `id` varchar(36) NOT NULL PRIMARY KEY,
  `class_id` varchar(36) NOT NULL,
  `year_id` varchar(36) NOT NULL,
  `course_id` varchar(36) NOT NULL,
  `day` int(11) NOT NULL,
  `slot_number` int(11) NOT NULL,
  `lh` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `course_teachers` (
  `course_id` varchar(36) NOT NULL,
  `class_id` varchar(36) NOT NULL,
  `year_id` varchar(36) NOT NULL,
  `teacher_id` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE schools
  ADD COLUMN cp_name varchar(255) NULL AFTER school_status,
  ADD COLUMN cp_phone varchar(255) NULL AFTER cp_name;

ALTER TABLE `course_teachers`
  ADD PRIMARY KEY (`course_id`,`class_id`,`year_id`),
  ADD KEY `course_id` (`course_id`),
  ADD KEY `class_id` (`class_id`);

---###---

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS course_schedules;
DROP TABLE IF EXISTS course_teachers;

SET FOREIGN_KEY_CHECKS = 1;