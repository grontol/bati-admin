CREATE TABLE IF NOT EXISTS tahfidz_proposals (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    student_id VARCHAR(36) NOT NULL,
    year_id VARCHAR(36) NOT NULL,
    start_surat INT NOT NULL,
    start_ayat INT NOT NULL,
    end_surat INT NOT NULL,
    end_ayat INT NOT NULL,
    count_ayat INT NOT NULL,
    note TEXT NULL,
    date timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);

---###---

DROP TABLE IF EXISTS tahfidz_proposals;