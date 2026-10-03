CREATE TABLE IF NOT EXISTS contract_preparations (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    institute_name VARCHAR(255) NOT NULL,
    institute_address VARCHAR(255) NOT NULL,
    institute_pic VARCHAR(255) NOT NULL,
    institute_pic_position VARCHAR(255) NOT NULL,
    institute_phone VARCHAR(255) NOT NULL,
    service_packet VARCHAR(255) NOT NULL,
    service_student_count VARCHAR(255) NOT NULL,
    service_whitelabel VARCHAR(255) NOT NULL,
    service_period VARCHAR(255) NOT NULL,
    service_note VARCHAR(255) NOT NULL,
    
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);

---###---

DROP TABLE IF EXISTS contract_preparations;