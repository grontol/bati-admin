ALTER TABLE tahfidzs
DROP COLUMN semester;

ALTER TABLE student_tahfidz_progresses
DROP COLUMN semester;

---###---

ALTER TABLE tahfidzs
ADD COLUMN semester INT(11) NOT NULL DEFAULT 1 AFTER year_id;

ALTER TABLE student_tahfidz_progresses
ADD COLUMN semester INT(11) NOT NULL DEFAULT 1 AFTER year_id;