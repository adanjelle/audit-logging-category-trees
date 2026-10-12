-- Test 1: Update student 1
UPDATE students
SET name = 'Kofi M.'
WHERE id = 1;

-- Test 2: Delete student 3
DELETE FROM students
WHERE id = 3;

-- Test 3: Insert a new student
INSERT INTO students (name, email)
VALUES ('Abena Owusu', 'abena@example.com');

-- Display the audit trail
SELECT
    tbl,
    op,
    old_row->>'name' AS was,
    new_row->>'name' AS now,
    changed_by,
    at
FROM audit_log
ORDER BY id;
