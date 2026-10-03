CREATE TABLE IF NOT EXISTS donations (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    school_id VARCHAR(36) NULL,
    kind ENUM('Donasi', 'Wakaf', 'Infaq') NOT NULL,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    target_amount INT NULL,
    start_date DATE NULL,
    end_date DATE NULL,
    photo VARCHAR(512) NULL,
    is_active TINYINT(1) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);

CREATE TABLE IF NOT EXISTS donation_payments (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    donation_id VARCHAR(36) NOT NULL,
    user_id VARCHAR(36) NULL,
    amount INT(11) NOT NULL,
    date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    prayer TEXT NOT NULL,
    status ENUM('Pending', 'Paid', 'Failed') NOT NULL,
    prayer_likes INT(11) NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);

---###---

DROP TABLE IF EXISTS donations;
DROP TABLE IF EXISTS donation_payments;