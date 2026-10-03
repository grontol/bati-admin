ALTER TABLE news
ADD COLUMN allow_comment TINYINT(1) NOT NULL AFTER date;

---###---

ALTER TABLE news
DROP COLUMN allow_comment;