ALTER TABLE tahfidz_targets
ADD COLUMN student_id VARCHAR(36) NULL AFTER level;

---###---

ALTER TABLE tahfidz_targets
DROP COLUMN student_id;