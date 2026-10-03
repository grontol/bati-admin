ALTER TABLE tahfidz_targets
MODIFY COLUMN level INT(11) NULL,
ADD COLUMN halaqoh_id VARCHAR(36) NULL AFTER level;

---###---

ALTER TABLE tahfidz_targets
MODIFY COLUMN level INT(11) NOT NULL DEFAULT 0,
DROP COLUMN halaqoh_id;