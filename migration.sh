#!/bin/bash
source .env

export MIGRATION_DSN="host=pgsql-pta port=5432 dbname=$DB_DATABASE user=$DB_USERNAME password=$DB_PASSWORD sslmode=disable"

sleep 2 && goose -dir "${MIGRATION_DIR}" postgres "${MIGRATION_DSN}" up -v