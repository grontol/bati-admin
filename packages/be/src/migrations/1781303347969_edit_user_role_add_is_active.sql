ALTER TABLE user_roles
ADD COLUMN is_active TINYINT(1) NOT NULL DEFAULT 1;

---###---

ALTER TABLE user_roles
DROP COLUMN is_active;