CREATE TABLE IF NOT EXISTS bill_discounts (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    student_id VARCHAR(36) NOT NULL,
    bill_id VARCHAR(36) NOT NULL,
    kind ENUM('absolute', 'percentage') NOT NULL,
    amount INT(11) NOT NULL,
    description TEXT NULL,
    
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);

---###---

DROP TABLE IF EXISTS bill_discounts;