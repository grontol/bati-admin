ALTER TABLE tahfidz_targets
MODIFY COLUMN `type` ENUM('Juz','Surat','Rentang') NOT NULL,
ADD COLUMN start_ayat INT(11) NULL AFTER `end`,
ADD COLUMN end_ayat INT(11) NULL AFTER start_ayat;

---###---

ALTER TABLE tahfidz_targets
MODIFY COLUMN `type` ENUM('Juz','Surat') NOT NULL,
DROP COLUMN start_ayat,
DROP COLUMN end_ayat;