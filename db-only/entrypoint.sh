#!/bin/sh

DB_ADDRESS=./sqlite.db

if [ -n "$LITESTREAM_GCS_SECRET_BASE64" ]
then
  export GOOGLE_APPLICATION_CREDENTIALS=/workdir/credentials.json
  echo "$LITESTREAM_GCS_SECRET_BASE64" | base64 -d > "$GOOGLE_APPLICATION_CREDENTIALS"
fi

cat << EOF > ./litestream.yaml
dbs:
  - path: $DB_ADDRESS
    replicas:
      - url: gcs://${LITESTREAM_GCS_BUCKET}/litestream
EOF

if [ -f "$DB_ADDRESS" ]
then
  echo "Database already exists, skipping restore"
else
  echo "No database found, restoring from replica if exists"
  ./litestream restore -config ./litestream.yaml -v -if-replica-exists "$DB_ADDRESS"
fi

exec sh
