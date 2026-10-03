ALTER TABLE school_subscriptions
ADD COLUMN excluded_menus JSON NULL;

---###---

ALTER TABLE school_subscriptions
DROP COLUMN excluded_menus;