ALTER TABLE payment_transactions
ADD COLUMN paid_date DATETIME NULL AFTER created_by;

---###---

ALTER TABLE payment_transactions
DROP COLUMN paid_date;