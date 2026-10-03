CREATE TABLE IF NOT EXISTS impression_suggestions (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    institute_name VARCHAR(255) NOT NULL,
    rating VARCHAR(255) NOT NULL,
    impression TEXT NOT NULL,
    suggestion TEXT NOT NULL, 
    
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL
);

---###---

DROP TABLE IF EXISTS impression_suggestions;