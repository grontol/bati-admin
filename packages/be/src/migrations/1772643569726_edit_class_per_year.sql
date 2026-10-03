ALTER TABLE classes ADD COLUMN year_id VARCHAR(36) NOT NULL AFTER school_id;

ALTER TABLE class_students DROP COLUMN year_id;

ALTER TABLE class_teachers DROP PRIMARY KEY;
ALTER TABLE class_teachers DROP COLUMN year_id;
ALTER TABLE class_teachers ADD PRIMARY KEY(class_id, teacher_id);

ALTER TABLE course_schedules DROP COLUMN year_id;

ALTER TABLE course_teachers DROP PRIMARY KEY;
ALTER TABLE course_teachers DROP COLUMN year_id;
ALTER TABLE course_teachers ADD PRIMARY KEY(course_id, class_id);

---###---

ALTER TABLE classes
DROP COLUMN year_id;

ALTER TABLE class_students
ADD COLUMN year_id VARCHAR(36) NOT NULL AFTER student_id;

ALTER TABLE class_teachers DROP PRIMARY KEY;
ALTER TABLE class_teachers ADD COLUMN year_id VARCHAR(36) NOT NULL AFTER teacher_id;
ALTER TABLE class_teachers ADD PRIMARY KEY(class_id, teacher_id, year_id);

ALTER TABLE course_schedules
ADD COLUMN year_id VARCHAR(36) NOT NULL AFTER class_id;

ALTER TABLE course_teachers DROP PRIMARY KEY;
ALTER TABLE course_teachers ADD COLUMN year_id VARCHAR(36) NOT NULL AFTER class_id;
ALTER TABLE course_teachers ADD PRIMARY KEY(course_id, class_id, year_id);