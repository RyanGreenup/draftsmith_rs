#!/bin/sh
set -e

# Define the path to the marker file
MARKER_FILE="/usr/src/app/.initialized"

# Check if the marker file exists
if [ ! -e "$MARKER_FILE" ]; then
  echo "First-time setup is running..."

  until pg_isready --host=postgres --port=5432; do
    echo "Waiting for PostgreSQL to be ready..."
    sleep 2
  done

  # Create the database
  PGPASSWORD=postgres createdb --host=${PGHOSST} --port=${PGPORT} --username=${PGUSER} ${PGDATABASE} || true

  # Run Diesel migrations
  cd $HOME/draftsmith_rs/draftsmith_rs_api
  diesel migration run --migration-dir migrations --database-url "$DATABASE_URL"

  # Write the marker file to indicate initialization done
  touch "$MARKER_FILE"
else
  echo "Initialization already completed. Skipping setup."
fi

# Run the REST API server
# Binary was installed in the dockerfile
draftsmith serve -a "0.0.0.0:${API_PORT}"

# Continue with any other command passed to the container like accessing shell
exec "$@"

