ALTER TABLE teachers
DROP COLUMN user_id;

ALTER TABLE parents
DROP COLUMN user_id;

---###---

ALTER TABLE teachers
ADD COLUMN user_id VARCHAR(36) NULL AFTER id;

ALTER TABLE parents
ADD COLUMN user_id VARCHAR(36) NULL AFTER id;