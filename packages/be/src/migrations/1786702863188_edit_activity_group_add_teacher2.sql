ALTER TABLE activity_groups
ADD COLUMN teacher2_id VARCHAR(36) NULL AFTER teacher_id;

---###---

ALTER TABLE activity_groups
DROP COLUMN teacher2_id;