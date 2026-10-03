CREATE TABLE `tahfeedz`.`school_subscriptions` (
    `id` VARCHAR(36) NOT NULL,
    `school_id` VARCHAR(36) NOT NULL,
    `status` ENUM('Aktif','Trial','Hold','Rejected','Non Aktif','Nego') NOT NULL,
    `mode` ENUM('Normal','White Label') NOT NULL,
    `feature_tahfidz_enabled` TINYINT(1) NOT NULL,
    `feature_academic_enabled` TINYINT(1) NOT NULL,
    `feature_payment_enabled` TINYINT(1) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB;

---###---

DROP TABLE IF EXISTS school_subscriptions;