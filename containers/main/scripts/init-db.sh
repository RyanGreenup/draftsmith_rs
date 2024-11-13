#!/bin/bash
set -e

# Wait for PostgreSQL server to start
until pg_isready --host=postgres-db --port=5432; do
  echo "Waiting for PostgreSQL to be ready..."
  sleep 2
done

# Create the database
PGPASSWORD=postgres createdb --host=postgres-db --port=5432 --username=postgres draftsmith2 || true

# Run migrations

