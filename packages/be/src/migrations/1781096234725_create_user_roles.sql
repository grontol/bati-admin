CREATE TABLE IF NOT EXISTS user_roles (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    user_id VARCHAR(36) NOT NULL,
    role ENUM('Dev','Superadmin','Kepala Sekolah','Admin Sekolah','Guru','Siswa','Unset','Wali','Affiliate') NOT NULL,
    school_id VARCHAR(36) NOT NULL,
    member_id VARCHAR(36) NOT NULL
);

---###---

DROP TABLE IF EXISTS user_roles;