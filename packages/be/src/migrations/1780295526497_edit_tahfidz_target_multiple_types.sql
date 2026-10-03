ALTER TABLE tahfidz_targets
MODIFY COLUMN tahfidz_type TEXT;

---###---

ALTER TABLE tahfidz_targets
MODIFY COLUMN tahfidz_type ENUM('Ziyadah', 'Murojaah', 'Tahsin');