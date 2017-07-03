#!/bin/bash
set -e

echo "******CREATING CONFLUENCE DATABASE******"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
   CREATE DATABASE confluence WITH ENCODING 'UNICODE' LC_COLLATE 'C' LC_CTYPE 'C' TEMPLATE template0;
   CREATE USER confluence;
   GRANT ALL PRIVILEGES ON DATABASE confluence to confluence;
EOSQL
echo ""

{ echo; echo "host confluence confluence 0.0.0.0/0 trust"; } >> \
  "$PGDATA"/pg_hba.conf

echo "******CONFLUENCE DATABASE CREATED******"
