# Database Service for Website Hosting

This repository manages a shared PostgreSQL instance in Docker for multiple websites hosted on a self-managed server. It’s designed for a total traffic of up to 5,000 visitors/day across all projects.

## Overview
- **Purpose**: Centralized database service for all website projects.
- **Traffic**: Supports ~5,000 visitors/day collectively (low-to-moderate load).
- **Design**: Single Postgres instance with separate databases per project for resource efficiency and simplicity.

## Setup
1. **Clone the Repo**:
   `bash
   git clone <repo-url> /opt/db-service
   cd /opt/db-service
   `
2. **Create .env File**:
   - Copy `.env.example` to `.env` and fill in credentials (see Security section).
3. **Start the Service**:
   `bash
   docker-compose up -d
   `

## Files
- **`docker-compose.yml`**: Defines the Postgres service with environment variables.
- **`init.sh`**: Initializes databases and users using `.env` variables.
- **`backup.sh`**: Script to back up all databases.
- **No `Dockerfile`**: Uses official `postgres:15` image.

## Connecting Projects
- Use Docker networking: `postgres://<user>:<pass>`db:5432/<project_db>`.
- Example: `postgres://app1_user:app1pass123`db:5432/app1_db`.

## Security
- **Credentials**: Stored in `.env` (not versioned). Example:
  `text
  DB_USER=admin
  DB_PASSWORD=securepass123
  APP1_DB=app1_db
  APP1_USER=app1_user
  APP1_PASSWORD=app1pass123
  APP2_DB=app2_db
  APP2_USER=app2_user
  APP2_PASSWORD=app2pass123
  `
- **Setup**: Copy `.env` to the server manually. `init.sh` reads these via environment variables passed in `docker-compose.yml`.

## Key Decisions
- **Single Instance**: Saves RAM/CPU (~1-2GB total vs. 100-200MB per instance), sufficient for low traffic. Isolation via separate databases/users.
- **Environment Variables**: Keeps credentials out of version control, using `.env` and `init.sh` for flexibility.
- **Docker**: Simplifies deployment and updates.

## Maintenance
- **Backup**: Run `./backup.sh` or schedule via cron (e.g., `0 2 * * * /opt/db-service/backup.sh`).
- **Monitor**: Check logs with `docker-compose logs -f`.
- **Update**: Pull new image and recreate: `docker-compose up -d --build`.

## Scaling
- Add resources or split to separate instances if traffic exceeds ~10,000 visitors/day or a project dominates load.
