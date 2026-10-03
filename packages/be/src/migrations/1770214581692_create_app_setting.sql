CREATE TABLE IF NOT EXISTS app_settings (
    id VARCHAR(255) NOT NULL PRIMARY KEY,
    value TEXT NOT NULL
);

---###---

DROP TABLE IF EXISTS app_settings;