ALTER TABLE teachers
ADD COLUMN can_be_treasurer TINYINT(1) NOT NULL DEFAULT 0,
ADD COLUMN can_be_principal TINYINT(1) NOT NULL DEFAULT 0;

---###---

ALTER TABLE teachers
DROP COLUMN can_be_treasurer,
DROP COLUMN can_be_principal;