ALTER TABLE schools
ADD COLUMN associate VARCHAR(36) NULL AFTER tagline;

---###---

ALTER TABLE schools
DROP COLUMN associate;