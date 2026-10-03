ALTER TABLE school_subscriptions
DROP COLUMN feature_tahfidz_enabled,
DROP COLUMN feature_academic_enabled,
DROP COLUMN feature_payment_enabled,
ADD COLUMN feature_set ENUM('Basic', 'Premium', 'Enterprise') NOT NULL DEFAULT 'Basic';

---###---

ALTER TABLE school_subscriptions
DROP COLUMN feature_set,
ADD COLUMN feature_tahfidz_enabled TINYINT(1) NOT NULL,
ADD COLUMN feature_academic_enabled TINYINT(1) NOT NULL,
ADD COLUMN feature_payment_enabled TINYINT(1) NOT NULL;