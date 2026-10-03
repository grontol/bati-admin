CREATE TABLE IF NOT EXISTS payment_transactions (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    transaction_id VARCHAR(15) NOT NULL,
    student_id VARCHAR(36) NOT NULL,
    total INT(11) NOT NULL,
    admin_fee INT(11) NOT NULL,
    payment_method VARCHAR(20) NOT NULL,
    kind ENUM('Bill', 'Donation') NOT NULL,
    status ENUM('Pending', 'Paid', 'Failed') NOT NULL,
    info TEXT NOT NULL,
    method TEXT NOT NULL,
    expiry_time DATETIME NOT NULL,
    created_by VARCHAR(36) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);

CREATE TABLE IF NOT EXISTS payment_transaction_bill_details (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    payment_transaction_id VARCHAR(36) NOT NULL,
    bill_detail_id  VARCHAR(36) NOT NULL,
    month INT(11) NULL,
    amount INT(11) NOT NULL
);

CREATE TABLE IF NOT EXISTS payment_transaction_donation_details (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    payment_transaction_id VARCHAR(36) NOT NULL,
    donation_id  VARCHAR(36) NOT NULL,
    prayer TEXT NOT NULL,
    amount INT(11) NOT NULL
);

CREATE TABLE IF NOT EXISTS counters (
    counter_key VARCHAR(50) NOT NULL PRIMARY KEY,
    add_key VARCHAR(50) NULL,
    current_value INT NOT NULL DEFAULT 0
);
INSERT INTO counters VALUES('payment_transactions', NULL, 0);

---###---

DROP TABLE IF EXISTS counters;
DROP TABLE IF EXISTS payment_transaction_donation_details;
DROP TABLE IF EXISTS payment_transaction_bill_details;
DROP TABLE IF EXISTS payment_transactions;