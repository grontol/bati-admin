CREATE TABLE IF NOT EXISTS galleries (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    owner_id VARCHAR(36) NOT NULL,
    filename VARCHAR(255) NOT NULL,
    description TEXT NULL
);

---###---

DROP TABLE IF EXISTS galleries;