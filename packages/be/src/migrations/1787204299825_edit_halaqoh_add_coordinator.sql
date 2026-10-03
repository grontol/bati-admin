ALTER TABLE halaqohs
ADD COLUMN coordinator_id VARCHAR(36) NULL AFTER is_open,
ADD COLUMN coordinator2_id VARCHAR(36) NULL AFTER coordinator_id;

---###---

ALTER TABLE halaqohs
DROP COLUMN coordinator_id,
DROP COLUMN coordinator2_id,