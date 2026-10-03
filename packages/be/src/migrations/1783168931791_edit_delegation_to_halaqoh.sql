ALTER TABLE delegates
RENAME COLUMN class_id TO halaqoh_id;

---###---

ALTER TABLE delegates
RENAME COLUMN halaqoh_id TO class_id;