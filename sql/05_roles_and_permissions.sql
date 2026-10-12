-- Create roles for read-only and read/write access
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'app_read') THEN
        CREATE ROLE app_read;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'app_write') THEN
        CREATE ROLE app_write;
    END IF;
END
$$;

-- Allow both roles to access the database
GRANT CONNECT ON DATABASE bootcamp TO app_read, app_write;

-- Allow access to the public schema
GRANT USAGE ON SCHEMA public TO app_read, app_write;

-- Read-only permissions
GRANT SELECT ON ALL TABLES IN SCHEMA public TO app_read;

-- Read/write permissions
GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA public TO app_write;

-- Apply permissions to tables created in the future by postgres
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public
GRANT SELECT ON TABLES TO app_read;

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO app_write;
