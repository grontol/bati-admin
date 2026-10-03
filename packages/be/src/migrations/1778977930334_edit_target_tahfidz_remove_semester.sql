ALTER TABLE tahfidz_targets
DROP COLUMN semester;

---###---

ALTER TABLE tahfidz_targets
ADD COLUMN semester INT(11) NOT NULL AFTER year_id;