# pub.kimiaki.space

Running [GoToSocial](https://github.com/superseriousbusiness/gotosocial) on [Cloud Run](https://cloud.google.com/run) (via [Litestream](https://litestream.io/)) with [Cloud Storage](https://cloud.google.com/storage) and [Cloudflare R2](https://www.cloudflare.com/products/r2/).

## Environment Variables

| Name | Description |
| :-- | :-- |
| GTS_HOST | See https://docs.gotosocial.org/en/latest/configuration/general/ , required |
| GTS_STORAGE_S3_ENDPOINT | See https://docs.gotosocial.org/en/latest/configuration/storage/ , required |
| GTS_STORAGE_S3_BUCKET | See https://docs.gotosocial.org/en/latest/configuration/storage/ , required |
| GTS_STORAGE_S3_ACCESS_KEY | See https://docs.gotosocial.org/en/latest/configuration/storage/ , required |
| GTS_STORAGE_S3_SECRET_KEY | See https://docs.gotosocial.org/en/latest/configuration/storage/ , required |
| LITESTREAM_GCS_BUCKET | GCS bucket name used by sqlite replication, required |
| LITESTREAM_GCS_SECRET_BASE64 | Base64 encoded Service account key, see also https://cloud.google.com/iam/docs/creating-managing-service-account-keys , optional |

## Deployment

1. [Create a Google Cloud Project](https://cloud.google.com/resource-manager/docs/creating-managing-projects)
2. [Enable billing for a project](https://cloud.google.com/billing/docs/how-to/modify-project)
3. [Create buckets](https://cloud.google.com/storage/docs/creating-buckets)
4. [Setup Cloud Run](https://cloud.google.com/run/docs/setup)
5. Setup [Building repositories from GitHub](https://cloud.google.com/build/docs/automating-builds/github/build-repos-from-github)
6. [Create a Cloud Build trigger](https://cloud.google.com/build/docs/automating-builds/create-manage-triggers)
    - Apply the following IAM roles:
        - Cloud Build Service Account
        - Service Account User
        - Cloud Run Admin
    - Prepare a storage bucket used by `GTS_STORAGE_S3_*`
6. Setup [substitution variables](https://cloud.google.com/build/docs/configuring-builds/substitute-variable-values) and [secrets](https://cloud.google.com/build/docs/securing-builds/use-secrets)
    - See [cloudbuild.yaml](./cloudbuild.yaml)
6. Trigger the Cloud Build trigger
7. [Mapping custom domains](https://cloud.google.com/run/docs/mapping-custom-domains) to the Cloud Run service named "gts"

### Local

1. Place a .env to project root
2. [Create service account key](https://cloud.google.com/iam/docs/creating-managing-service-account-keys)
    - Apply the following IAM roles:
        - Storage Object Admin
3. Append the .env with `LITESTREAM_GCS_SECRET_BASE64=<base64 encoded service account key>`
4. Remove the Cloud Run service named "gts" if already it run
5. Run `docker build -t gts .`
6. Run `docker run --rm -p 8080:8080 --env-file=.env gts`
7. Run `docker exec -it <container id> sh`
8. Do something like https://docs.gotosocial.org/en/latest/installation_guide/binary/#5-create-your-user

## FAQ

### Can I create a user on Cloud Run Instance?

As far as I know, you can't. Please following the local deployment steps.

### Can I use the other S3 compatible object storage instead of R2?

Yes you can.
