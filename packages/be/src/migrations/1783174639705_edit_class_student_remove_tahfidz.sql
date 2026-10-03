ALTER TABLE class_students
DROP COLUMN tahfidz_teacher_id;

---###---
ALTER TABLE class_students
ADD COLUMN tahfidz_teacher_id VARCHAR(36) NULL;