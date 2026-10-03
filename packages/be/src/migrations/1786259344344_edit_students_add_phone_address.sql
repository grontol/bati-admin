ALTER TABLE students
ADD COLUMN phone VARCHAR(50) NULL AFTER parent_name,
ADD COLUMN address TEXT NULL AFTER phone;

---###---

ALTER TABLE students
DROP COLUMN phone,
DROP COLUMN address;