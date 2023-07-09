# DB only workspace

## Environment Variables

| Name | Description |
| :-- | :-- |
| LITESTREAM_GCS_BUCKET | GCS bucket name used by sqlite replication, required |
| LITESTREAM_GCS_SECRET_BASE64 | Base64 encoded Service account key, see also https://cloud.google.com/iam/docs/creating-managing-service-account-keys , required |

### Usage

1. Place a .env to project root
2. [Create service account key](https://cloud.google.com/iam/docs/creating-managing-service-account-keys)
    - Apply the following IAM roles:
        - Storage Object Admin
3. Append the .env with `LITESTREAM_GCS_SECRET_BASE64=<base64 encoded service account key>`
4. Remove the Cloud Run service named "gts" if already it run
5. Run `docker build -t db-only .`
6. Run `docker run --rm -v $(pwd):/workdir/output --env-file=.env -it db-only`

```shell
# Backup
sqlite3 sqlite.db '.backup output/gts_202307082341.db'
# Dump
sqlite3 output/gts_202307082341.db '.dump' > output/gts_dump_202307082341.sql
# Recover
sqlite3 output/gts_202307082341.db '.recover' > output/gts_recover_202307082341.sql
# Replace (Beforehand delete entire GCS object)
rm sqlite.db
sqlite3 sqlite.db < output/gts_dump_202307082341.sql
./litestream replicate -config ./litestream.yaml
```
