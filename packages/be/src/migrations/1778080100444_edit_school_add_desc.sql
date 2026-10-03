ALTER TABLE schools
ADD COLUMN description TEXT NULL AFTER logo;

---###---

ALTER TABLE schools
DROP COLUMN description;