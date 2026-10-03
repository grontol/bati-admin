ALTER TABLE tilawahs
ADD COLUMN image TEXT NULL AFTER time,
ADD COLUMN note TEXT NULL AFTER image;

---###---

ALTER TABLE tilawahs
DROP COLUMN image,
DROP COLUMN note;