CREATE TABLE IF NOT EXISTS academic_calendars (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    school_id VARCHAR(36) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    description TEXT NOT NULL,
    color VARCHAR(50) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);

---###---

DROP TABLE IF EXISTS academic_calendars;