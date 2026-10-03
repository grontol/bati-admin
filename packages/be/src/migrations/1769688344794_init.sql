CREATE TABLE `bills` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL PRIMARY KEY,
  `school_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `year_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` int DEFAULT NULL,
  `class_id` varchar(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` enum('monthly','event') COLLATE utf8mb4_unicode_ci NOT NULL,
  `event_date` date DEFAULT NULL,
  `monthly_date` int DEFAULT NULL,
  `months` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `bill_details` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bill_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` int NOT NULL,
  `document` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `classes` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL PRIMARY KEY,
  `school_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `class_students` (
  `class_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `student_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `year_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `teacher_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `class_teachers` (
  `class_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `teacher_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `year_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `delegates` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL PRIMARY KEY,
  `subject_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `object_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reason` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `class_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `fcm_tokens` (
  `user_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fcm_token` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `parents` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL PRIMARY KEY,
  `user_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sex` enum('M','F') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `parent_students` (
  `parent_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `student_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `payments` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bill_detail_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `month` int DEFAULT NULL,
  `student_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `quran_juz` (
  `id` int NOT NULL PRIMARY KEY,
  `start_surat` int NOT NULL,
  `start_ayat` int NOT NULL,
  `end_surat` int NOT NULL,
  `end_ayat` int NOT NULL,
  `ayat_count` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `quran_surat` (
  `id` int NOT NULL PRIMARY KEY,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ayat_count` int NOT NULL,
  `name_ar` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `juz` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `schools` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL PRIMARY KEY,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `year_id` varchar(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `semester` int DEFAULT NULL,
  `address` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `rt` int DEFAULT NULL,
  `rw` int DEFAULT NULL,
  `village` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `district` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `region` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `postal_code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `kind` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `npsn` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `akreditasi` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `school_status` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `school_settings` (
  `school_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `students` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` varchar(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `school_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nis` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sex` enum('M','F') COLLATE utf8mb4_unicode_ci NOT NULL,
  `dob` date NOT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `student_tahfidz_progresses` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL PRIMARY KEY,
  `student_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `year_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `semester` int NOT NULL,
  `progress` double NOT NULL,
  `avg_tajwid` double NOT NULL,
  `avg_makhroj` double NOT NULL,
  `avg_kelancaran` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tahfidzs` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL PRIMARY KEY,
  `student_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `year_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `semester` int NOT NULL,
  `type` enum('Ziyadah','Murojaah','Tahsin') COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_surat` int NOT NULL,
  `start_ayat` int NOT NULL,
  `end_surat` int NOT NULL,
  `end_ayat` int NOT NULL,
  `count_ayat` int NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tajwid` int NOT NULL,
  `makhroj` int NOT NULL,
  `kelancaran` int NOT NULL,
  `redo` tinyint(1) NOT NULL DEFAULT '0',
  `teacher_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `teacher_feedback` mediumtext COLLATE utf8mb4_unicode_ci,
  `parent_feedback` mediumtext COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tahfidz_schedules` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL PRIMARY KEY,
  `school_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` int NOT NULL,
  `day` int NOT NULL,
  `hour_start` time NOT NULL,
  `hour_end` time NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tahfidz_targets` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL PRIMARY KEY,
  `school_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `year_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `semester` int NOT NULL,
  `level` int NOT NULL,
  `type` enum('Juz','Surat') COLLATE utf8mb4_unicode_ci NOT NULL,
  `start` int NOT NULL,
  `end` int NOT NULL,
  `mode` enum('forward','surat_backward','ayat_backward') COLLATE utf8mb4_unicode_ci NOT NULL,
  `priority` int NOT NULL,
  `target_count` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `teachers` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` varchar(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `school_id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nip` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sex` enum('M','F') COLLATE utf8mb4_unicode_ci NOT NULL,
  `dob` date NOT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `users` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(512) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `verification_code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `verified` tinyint NOT NULL DEFAULT '0',
  `role` enum('Dev','Superadmin','Kepala Sekolah','Admin Sekolah','Guru','Siswa','Unset','Wali','Affiliate') COLLATE utf8mb4_unicode_ci NOT NULL,
  `school_id` varchar(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `years` (
  `id` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL PRIMARY KEY,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `bill_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_bill_detail_bill` (`bill_id`);
  
ALTER TABLE `bill_details`
  ADD CONSTRAINT `FK_bill_detail_bill` FOREIGN KEY (`bill_id`) REFERENCES `bills` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `class_students`
  ADD PRIMARY KEY (`class_id`,`student_id`);
  
ALTER TABLE `class_teachers`
  ADD PRIMARY KEY (`class_id`,`teacher_id`,`year_id`);

ALTER TABLE `fcm_tokens`
  ADD PRIMARY KEY (`user_id`,`fcm_token`);

ALTER TABLE `parent_students`
  ADD PRIMARY KEY (`parent_id`,`student_id`);

ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_payment_bill_detail` (`bill_detail_id`);

ALTER TABLE `payments`
  ADD CONSTRAINT `FK_payment_bill_detail` FOREIGN KEY (`bill_detail_id`) REFERENCES `bill_details` (`id`);

ALTER TABLE `school_settings`
  ADD PRIMARY KEY (`school_id`,`id`);

ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `school_id` (`school_id`,`nis`);

ALTER TABLE `teachers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nip` (`nip`);

ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

---###---

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS bills;
DROP TABLE IF EXISTS bill_details;
DROP TABLE IF EXISTS classes;
DROP TABLE IF EXISTS class_students;
DROP TABLE IF EXISTS class_teachers;
DROP TABLE IF EXISTS delegates;
DROP TABLE IF EXISTS fcm_tokens;
DROP TABLE IF EXISTS parents;
DROP TABLE IF EXISTS parent_students;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS quran_juz;
DROP TABLE IF EXISTS quran_surat;
DROP TABLE IF EXISTS schools;
DROP TABLE IF EXISTS school_settings;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS student_tahfidz_progresses;
DROP TABLE IF EXISTS tahfidzs;
DROP TABLE IF EXISTS tahfidz_schedules;
DROP TABLE IF EXISTS tahfidz_targets;
DROP TABLE IF EXISTS teachers;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS years;

SET FOREIGN_KEY_CHECKS = 1;