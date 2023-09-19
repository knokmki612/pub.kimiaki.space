# pub.kimiaki.space

Running [GoToSocial](https://github.com/superseriousbusiness/gotosocial) on [Cloud Run](https://cloud.google.com/run).

## Environment or Substitution Variables

| Name | Description |
| :-- | :-- |
| GTS_HOST | See https://docs.gotosocial.org/en/latest/configuration/general/ , required |
| GTS_DB_ADDRESS | See https://docs.gotosocial.org/en/latest/configuration/database/, required |
| GTS_DB_PORT | See https://docs.gotosocial.org/en/latest/configuration/database/, required |
| GTS_DB_USER | See https://docs.gotosocial.org/en/latest/configuration/database/, required |
| GTS_DB_DATABASE | See https://docs.gotosocial.org/en/latest/configuration/database/, required |
| GTS_DB_PASSWORD | See https://docs.gotosocial.org/en/latest/configuration/database/, required |
| GTS_STORAGE_S3_ENDPOINT | See https://docs.gotosocial.org/en/latest/configuration/storage/ , required |
| GTS_STORAGE_S3_BUCKET | See https://docs.gotosocial.org/en/latest/configuration/storage/ , required |
| GTS_STORAGE_S3_ACCESS_KEY | See https://docs.gotosocial.org/en/latest/configuration/storage/ , required |
| GTS_STORAGE_S3_SECRET_KEY | See https://docs.gotosocial.org/en/latest/configuration/storage/ , required |
| REGION | Region of Cloud Run Instances, required |
| IMAGE_NAME | Image name of docker image, required |

## Deployment

1. [Create a Google Cloud Project](https://cloud.google.com/resource-manager/docs/creating-managing-projects)
2. [Enable billing for a project](https://cloud.google.com/billing/docs/how-to/modify-project)
3. [Create buckets](https://cloud.google.com/storage/docs/creating-buckets)
4. [Setup Artifact Registry](https://cloud.google.com/artifact-registry/docs/docker/store-docker-container-images)
5. [Setup Cloud Run](https://cloud.google.com/run/docs/setup)
6. Setup [Building repositories from GitHub](https://cloud.google.com/build/docs/automating-builds/github/build-repos-from-github)
7. [Create a Cloud Build trigger](https://cloud.google.com/build/docs/automating-builds/create-manage-triggers)
    - Apply the following IAM roles:
        - Cloud Build Service Account
        - Service Account User
        - Cloud Run Admin
    - Prepare a storage bucket used by `GTS_STORAGE_S3_*`
8. Setup [substitution variables](https://cloud.google.com/build/docs/configuring-builds/substitute-variable-values) and [secrets](https://cloud.google.com/build/docs/securing-builds/use-secrets)
    - See [cloudbuild.yaml](./cloudbuild.yaml)
9. Trigger the Cloud Build trigger
10. [Mapping custom domains](https://cloud.google.com/run/docs/mapping-custom-domains) to the Cloud Run service named "gts"

### Local

1. Place a .env to project root
2. Run `docker build -t gts .`
3. Run `docker run --rm -p 8080:8080 --env-file=.env gts`
4. Run `docker exec -it <container id> sh`
5. Do something like https://docs.gotosocial.org/en/latest/getting_started/user_creation/

## FAQ

### Can I create a user on Cloud Run Instance?

As far as I know, you can't. Please following the local deployment steps.

Or [create Cloud Run jobs](https://cloud.google.com/run/docs/create-jobs?) with same container image but change [command](https://cloud.google.com/sdk/gcloud/reference/run/jobs/create#--command) or [args](https://cloud.google.com/sdk/gcloud/reference/run/jobs/create#--args).
