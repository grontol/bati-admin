ALTER TABLE school_subscriptions
MODIFY COLUMN excluded_menus TEXT NULL;

---###---

ALTER TABLE school_subscriptions
MODIFY COLUMN excluded_menus JSON NULL;