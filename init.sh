#!/bin/sh
set -e  # Exit on error

# Connect to Postgres and execute SQL commands
psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" <<-EOSQL
  CREATE DATABASE "$APP1_DB";

  CREATE USER "$APP1_USER" WITH PASSWORD '$APP1_PASSWORD';

  GRANT ALL PRIVILEGES ON DATABASE "$APP1_DB" TO "$APP1_USER";

  REVOKE ALL ON DATABASE "$APP1_DB" FROM PUBLIC;
EOSQL

echo "Database and user initialization completed."
