ALTER TABLE users
MODIFY COLUMN role ENUM('Dev','Superadmin','Kepala Sekolah','Admin Sekolah','Guru','Siswa','Unset','Wali','Affiliate','Bendahara');

---###---

ALTER TABLE users
MODIFY COLUMN role ENUM('Dev','Superadmin','Kepala Sekolah','Admin Sekolah','Guru','Siswa','Unset','Wali','Affiliate');