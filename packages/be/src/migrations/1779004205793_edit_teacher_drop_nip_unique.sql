ALTER TABLE teachers
DROP INDEX `nip`;

---###---

ALTER TABLE teachers
ADD UNIQUE KEY `nip` (`nip`);