CREATE TABLE IF NOT EXISTS activity_attendances (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    activity_group_id VARCHAR(36) NOT NULL,
    teacher_id VARCHAR(36) NOT NULL,
    date DATE NOT NULL,
    time VARCHAR(10) NOT NULL,
    note TEXT NULL,
    photo VARCHAR(512) NULL,
    
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);

CREATE TABLE IF NOT EXISTS activity_attendance_details (
    activity_attendance_id VARCHAR(36) NOT NULL,
    student_id VARCHAR(36) NOT NULL,
    kind ENUM('Hadir', 'Sakit', 'Izin', 'Alpha', 'Telat', 'Haid') NOT NULL
);

---###---

DROP TABLE IF EXISTS activity_attendances;
DROP TABLE IF EXISTS activity_attendance_details;