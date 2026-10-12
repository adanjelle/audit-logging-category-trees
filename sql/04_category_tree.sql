-- Create the categories table
CREATE TABLE IF NOT EXISTS categories (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    parent_id INT REFERENCES categories(id)
);

-- Insert sample categories without duplicating existing data
INSERT INTO categories (name, parent_id)
SELECT 'Electronics', NULL
WHERE NOT EXISTS (
    SELECT 1 FROM categories WHERE name = 'Electronics'
);

INSERT INTO categories (name, parent_id)
SELECT 'Computers', parent.id
FROM categories AS parent
WHERE parent.name = 'Electronics'
AND NOT EXISTS (
    SELECT 1 FROM categories WHERE name = 'Computers'
);

INSERT INTO categories (name, parent_id)
SELECT 'Laptops', parent.id
FROM categories AS parent
WHERE parent.name = 'Computers'
AND NOT EXISTS (
    SELECT 1 FROM categories WHERE name = 'Laptops'
);

INSERT INTO categories (name, parent_id)
SELECT 'Phones', parent.id
FROM categories AS parent
WHERE parent.name = 'Electronics'
AND NOT EXISTS (
    SELECT 1 FROM categories WHERE name = 'Phones'
);

-- Display the category hierarchy
WITH RECURSIVE tree AS (
    SELECT id, name, parent_id, 0 AS depth
    FROM categories
    WHERE parent_id IS NULL

    UNION ALL

    SELECT c.id, c.name, c.parent_id, t.depth + 1
    FROM categories AS c
    JOIN tree AS t ON c.parent_id = t.id
)
SELECT repeat('  ', depth) || name AS tree
FROM tree
ORDER BY depth, name;
