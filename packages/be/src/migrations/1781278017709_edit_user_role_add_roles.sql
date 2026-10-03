ALTER TABLE user_roles
MODIFY COLUMN role ENUM('Dev','Superadmin','Kepala Sekolah','Admin Sekolah','Guru','Siswa','Unset','Wali','Affiliate','Bendahara');

---###---

ALTER TABLE user_roles
MODIFY COLUMN role ENUM('Dev','Superadmin','Kepala Sekolah','Admin Sekolah','Guru','Siswa','Unset','Wali','Affiliate');