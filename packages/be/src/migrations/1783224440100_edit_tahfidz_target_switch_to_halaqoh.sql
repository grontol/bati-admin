DELETE FROM tahfidz_targets WHERE halaqoh_id IS NULL;

ALTER TABLE tahfidz_targets
DROP COLUMN level,
MODIFY COLUMN halaqoh_id VARCHAR(36) NOT NULL;

---###---

ALTER TABLE tahfidz_targets
ADD COLUMN level INT(11) NULL,
MODIFY COLUMN halaqoh_id VARCHAR(36) NULL;