-- Core table for the audit logging lab

CREATE TABLE IF NOT EXISTS students (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- Insert sample students for testing
INSERT INTO students (name, email) VALUES
    ('Kofi Mensah', 'kofi@example.com'),
    ('Ama Boateng', 'ama@example.com'),
    ('Kwame Asante', 'kwame@example.com')
ON CONFLICT (email) DO NOTHING;
