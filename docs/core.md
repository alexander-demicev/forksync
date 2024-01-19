# Core GitHub Workflow

This GitHub Workflow automates the build and publishing process for core Cluster API (CAPI) and its providers' images. 
It leverages GitHub Actions to build, push, and sign Docker images for various architectures (amd64, arm64, and s390x). The workflow also creates a GitHub release with the generated artifacts.

## Inputs

- **release_tag**: The release tag to use for the new version. This input is required when triggering the workflow manually.

## Workflow Structure

The workflow consists of three main jobs:

1. **buildandpublishimages**: Builds and publishes core CAPI and its providers' images. Images are pushed to prime registry. The workflow includes the signing process using cosign.

2. **provenance**: Publishes the provenance of the images built in the previous step.

3. **release**: Creates a GitHub release with the generated artifacts.

## Adding New Images

If you need to add new images or make modifications to the workflow:

1. **Update Docker Images**: Modify the `ALL_ARCH` and `ALL_DOCKER_BUILD` environment variables in the `Build, push and sign Cluster API images` step to include any new images.

2. **Configure Signing**: Adjust the signing process using Cosign in the same step.

4. **Update Provenance Matrix**: If new images are added, update the matrix in the `provenance` job to include the image names and corresponding digests.
