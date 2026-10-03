ALTER TABLE activity_groups
MODIFY COLUMN repeat_time TEXT NULL,
MODIFY COLUMN event_time TEXT NULL;

---###---

ALTER TABLE activity_groups
MODIFY COLUMN repeat_time JSON NULL,
MODIFY COLUMN event_time JSON NULL;