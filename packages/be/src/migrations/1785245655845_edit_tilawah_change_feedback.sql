ALTER TABLE tilawahs
MODIFY COLUMN parent_feedback TEXT NULL,
MODIFY COLUMN teacher_feedback TEXT NULL;

---###---

ALTER TABLE tilawahs
MODIFY COLUMN parent_feedback VARCHAR(36) NULL,
MODIFY COLUMN teacher_feedback VARCHAR(36) NULL;