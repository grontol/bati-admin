ALTER TABLE donations
DROP COLUMN photo;

---###---

ALTER TABLE donations
ADD COLUMN photo VARCHAR(512) NULL AFTER end_data;