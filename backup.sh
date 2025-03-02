#!/bin/sh

# Backup all databases in the Postgres instance
# Assumes the container is named 'db' from docker-compose.yml
# Adjust 'admin' and container name if different
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="backup_$TIMESTAMP.sql"

echo "Backing up all databases to $BACKUP_FILE..."
docker exec db pg_dumpall -U "$DB_USER" > "$BACKUP_FILE"

if [ $? -eq 0 ]; then
    echo "Backup completed successfully: $BACKUP_FILE"
else
    echo "Backup failed!"
    exit 1
fi
