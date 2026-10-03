CReATE TABLE IF NOT EXISTS halaqohs (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    school_id VARCHAR(36) NOT NULL,
    year_id VARCHAR(36) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    teacher_id VARCHAR(36) NULL,
    teacher2_id VARCHAR(36) NULL,
    teacher3_id VARCHAR(36) NULL,
    teacher4_id VARCHAR(36) NULL,
    
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);

CREATE TABLE IF NOT EXISTS `halaqoh_students` (
    `halaqoh_id` varchar(36) NOT NULL,
    `student_id` varchar(36) NOT NULL
)

---###---

DROP TABLE IF EXISTS halaqohs;
DROP TABLE IF EXISTS halaqoh_students;