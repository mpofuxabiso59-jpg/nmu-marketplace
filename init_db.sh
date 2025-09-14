#!/usr/bin/env bash
set -e

echo "Waiting for Postgres..."
while ! pg_isready -h $DB_HOST -p $DB_PORT -U $DB_USER >/dev/null 2>&1; do
  sleep 1
done

echo "Running migrations..."
psql $DATABASE_URL -f migrations/001_init.sql

echo "Creating admin user..."
node scripts/create_admin.js

echo "Init complete."
