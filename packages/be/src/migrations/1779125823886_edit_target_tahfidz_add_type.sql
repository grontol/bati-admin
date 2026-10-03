ALTER TABLE tahfidz_targets
ADD COLUMN tahfidz_type ENUM('Ziyadah', 'Murojaah', 'Tahsin') NOT NULL DEFAULT 'Ziyadah' AFTER level;

---###---

ALTER TABLE tahfidz_targets
DROP COLUMN tahfidz_type;