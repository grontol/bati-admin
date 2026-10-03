CREATE TABLE IF NOT EXISTS student_assessments (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    teacher_id VARCHAR(36) NOT NULL,
    class_id VARCHAR(36) NOT NULL,
    course_id VARCHAR(36) NOT NULL,
    date DATE NOT NULL,
    kind ENUM('Sumatif', 'SAS') NOT NULL,
    tp_lm INT(11) NOT NULL,
    course_topic_id VARCHAR(36) NOT NULL,
    pass_limit INT(11) NOT NULL,
    
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);

CREATE TABLE IF NOT EXISTS student_assessment_details (
    student_assessment_id VARCHAR(36) NOT NULL,
    student_id VARCHAR(36) NOT NULL,
    point INT(11) NOT NULL
);

---###---

DROP TABLE IF EXISTS student_assessment;
DROP TABLE IF EXISTS student_assessment_details;