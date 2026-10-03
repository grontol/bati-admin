CREATE TABLE IF NOT EXISTS student_attendances (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    teacher_id VARCHAR(36) NOT NULL,
    class_id VARCHAR(36) NOT NULL,
    course_id VARCHAR(36) NOT NULL,
    date DATE NOT NULL,
    slot_number INT(11) NOT NULL,
    course_topic_id VARCHAR(36) NOT NULL,
    materi TEXT NOT NULL,
    photo VARCHAR(512) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);

CREATE TABLE IF NOT EXISTS student_attendance_details (
    student_attendance_id VARCHAR(36) NOT NULL,
    student_id VARCHAR(36) NOT NULL,
    kind ENUM('Hadir', 'Sakit', 'Izin', 'Alpha', 'Telat', 'Haid') NOT NULL
);

---###---

DROP TABLE IF EXISTS student_attendances;
DROP TABLE IF EXISTS student_attendance_details;