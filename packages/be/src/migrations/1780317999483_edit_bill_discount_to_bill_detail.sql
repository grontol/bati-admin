ALTER TABLE bill_discounts
RENAME COLUMN bill_id TO bill_detail_id;

---###---

ALTER TABLE bill_discounts
RENAME COLUMN bill_detail_id TO bill_id;