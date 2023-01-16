#!/bin/sh

export GTS_PORT=$PORT

if [ -n "$LITESTREAM_GCS_SECRET_BASE64" ]
then
  export GOOGLE_APPLICATION_CREDENTIALS=/gotosocial/credentials.json
  echo "$LITESTREAM_GCS_SECRET_BASE64" | base64 -d > "$GOOGLE_APPLICATION_CREDENTIALS"
fi

cat << EOF > /gotosocial/litestream.yaml
dbs:
  - path: $GTS_DB_ADDRESS
    replicas:
      - url: gcs://${LITESTREAM_GCS_BUCKET}/litestream
EOF

if [ -f "$GTS_DB_ADDRESS" ]
then
  echo "Database already exists, skipping restore"
else
  echo "No database found, restoring from replica if exists"
  ./litestream restore -config ./litestream.yaml -v -if-replica-exists "$GTS_DB_ADDRESS"
fi

exec ./litestream replicate -config ./litestream.yaml -exec "./gotosocial --config-path ./config.yaml server start"
