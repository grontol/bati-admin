ALTER TABLE user_roles
DROP COLUMN id;

ALTER TABLE user_roles
ADD PRIMARY KEY (user_id, role, school_id, member_id);

---###---

ALTER TABLE user_roles
DROP PRIMARY KEY;

ALTER TABLE user_roles
ADD COLUMN id VARCHAR(36) NOT NULL FIRST;