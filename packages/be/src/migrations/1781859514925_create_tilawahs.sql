CREATE TABLE IF NOT EXISTS tilawahs (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    student_id VARCHAR(36) NOT NULL,
    start_surat INT(11) NOT NULL,
    start_ayat INT(11) NOT NULL,
    end_surat INT(11) NOT NULL,
    end_ayat INT(11) NOT NULL,
    count_ayat INT(11) NOT NULL,
    date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    parent_id VARCHAR(36) NULL,
    parent_feedback VARCHAR(36) NULL,
    parent_status ENUM('Pending', 'Accepted', 'Rejected') NULL,
    parent_action_date TIMESTAMP NULL,
    teacher_id VARCHAR(36) NULL,
    teacher_feedback VARCHAR(36) NULL,
    teacher_status ENUM('Pending', 'Accepted', 'Rejected') NULL,
    teacher_action_date TIMESTAMP NULL,
    
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);

---###---

DROP TABLE IF EXISTS tilawahs;