ALTER TABLE class_students
RENAME COLUMN teacher_id TO tahfidz_teacher_id;

ALTER TABLE class_students
MODIFY COLUMN tahfidz_teacher_id VARCHAR(36) NULL;

---###---

ALTER TABLE class_students
MODIFY COLUMN tahfidz_teacher_id VARCHAR(36) NOT NULL;

ALTER TABLE class_students
RENAME COLUMN tahfidz_teacher_id TO teacher_id;