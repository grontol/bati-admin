CREATE TABLE IF NOT EXISTS activities (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    school_id VARCHAR(36) NOT NULL,
    year_id VARCHAR(36) NOT NULL,
    name VARCHAR(255) NOT NULL,
    
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);

CREATE TABLE IF NOT EXISTS activity_groups (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    activity_id VARCHAR(36) NOT NULL,
    group_name VARCHAR(512) NOT NULL,
    `type` enum('repeat', 'event') NOT NULL,
    repeat_time JSON NULL,
    event_time JSON NULL,
    teacher_id VARCHAR(36) NULL,
    
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);

CREATE TABLE IF NOT EXISTS activity_group_students (
    activity_group_id VARCHAR(36) NOT NULL,
    student_id VARCHAR(36) NOT NULL
);

---###---

DROP TABLE IF EXISTS activity_group_students;
DROP TABLE IF EXISTS activity_groups;
DROP TABLE IF EXISTS activities;