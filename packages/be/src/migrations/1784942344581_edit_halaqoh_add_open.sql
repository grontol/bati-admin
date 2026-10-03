ALTER TABLE halaqohs
ADD COLUMN is_open TINYINT(1) NOT NULL DEFAULT 0 AFTER teacher4_id;

---###---

ALTER TABLE halaqohs
DROP COLUMN is_open;