ALTER TABLE schools
ADD COLUMN admin_phone VARCHAR(50) NULL AFTER cp_phone;

---###---

ALTER TABLE schools
DROP TABLE admin_phone;