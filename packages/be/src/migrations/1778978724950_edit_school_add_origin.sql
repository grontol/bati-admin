ALTER TABLE schools
ADD COLUMN origin VARCHAR(255) NULL AFTER description;

---###---
ALTER TABLE schools
DROP COLUMN origin;