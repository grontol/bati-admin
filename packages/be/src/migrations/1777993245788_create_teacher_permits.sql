CREATE TABLE IF NOT EXISTS teacher_permits (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    teacher_id VARCHAR(36) NOT NULL,
    date DATE NOT NULL,
    kind VARCHAR(50) NOT NULL,
    document TEXT NULL,
    description TEXT NULL,
    status ENUM('Diajukan', 'Disetujui', 'Ditolak') NOT NULL DEFAULT 'Diajukan',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);

---###---

DROP TABLE IF EXISTS teacher_permits;