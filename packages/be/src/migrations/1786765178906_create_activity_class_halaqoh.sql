CREATE TABLE IF NOT EXISTS activity_group_classes (
    activity_group_id VARCHAR(36) NOT NULL,
    class_id VARCHAR(36) NOT NULL
);

CREATE TABLE IF NOT EXISTS activity_group_halaqohs (
    activity_group_id VARCHAR(36) NOT NULL,
    halaqoh_id VARCHAR(36) NOT NULL
);

---###---

DROP TABLE IF EXISTS activity_group_halaqohs;
DROP TABLE IF EXISTS activity_group_classes;