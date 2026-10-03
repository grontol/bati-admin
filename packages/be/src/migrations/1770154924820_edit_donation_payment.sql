ALTER TABLE donation_payments
DROP COLUMN prayer_likes;

---###---

ALTER TABLE donation_payments
ADD COLUMN prayer_likes INT(11) NOT NULL DEFAULT 0 AFTER status;