CREATE TABLE IF NOT EXISTS teacher_attendances (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    teacher_id VARCHAR(36) NOT NULL,
    date DATE NOT NULL DEFAULT (CURDATE()),
    clock_in_time TIME NOT NULL,
    clock_out_time TIME NULL,
    clock_in_lat DOUBLE NULL,
    clock_in_lng DOUBLE NULL,
    clock_in_loc TEXT NULL,
    clock_in_image TEXT NULL,
    clock_out_lat DOUBLE NULL,
    clock_out_lng DOUBLE NULL,
    clock_out_loc TEXT NULL,
    clock_out_image TEXT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);

---###---

DROP TABLE IF EXISTS teacher_attendances;