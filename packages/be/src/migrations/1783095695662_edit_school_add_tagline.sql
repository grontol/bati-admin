ALTER TABLE schools
ADD COLUMN tagline TEXT NULL AFTER origin;

---###---

ALTER TABLE schools
DROP COLUMN tagline;