INSERT INTO user_roles (id, user_id, role, school_id, member_id)
SELECT UUID(), user_id, 'Guru', school_id, id
FROM teachers
WHERE user_id IS NOT NULL;

INSERT INTO user_roles (id, user_id, role, school_id, member_id)
SELECT UUID(), parents.user_id, 'Wali', students.school_id, parents.id
FROM parents
JOIN parent_students ON parent_students.parent_id = parents.id
JOIN students ON students.id = parent_students.student_id
WHERE parents.user_id IS NOT NULL
GROUP BY parents.user_id, students.school_id, parents.id;

---###---

DELETE FROM user_roles WHERE 1;