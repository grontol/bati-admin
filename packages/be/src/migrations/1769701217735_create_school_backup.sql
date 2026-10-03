CREATE TABLE `school_backups` (
  `id` varchar(36) NOT NULL PRIMARY KEY,
  `name` varchar(255) NOT NULL,
  `year_id` varchar(36) DEFAULT NULL,
  `semester` int(11) DEFAULT NULL,
  `address` mediumtext NOT NULL,
  `rt` int(11) DEFAULT NULL,
  `rw` int(11) DEFAULT NULL,
  `village` varchar(255) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `city` varchar(255) NOT NULL,
  `region` varchar(255) NOT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `kind` varchar(10) DEFAULT NULL,
  `npsn` varchar(20) DEFAULT NULL,
  `akreditasi` varchar(20) DEFAULT NULL,
  `school_status` varchar(10) DEFAULT NULL,
  `cp_name` varchar(255) DEFAULT NULL,
  `cp_phone` varchar(50) DEFAULT NULL,
  `image` varchar(512) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

---###---

DROP TABLE IF EXISTS school_backups;