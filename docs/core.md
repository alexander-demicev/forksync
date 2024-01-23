# Core GitHub Workflow

This GitHub Workflow automates the build and publishing process for the core Cluster API and its providers (Kubeadm bootstrap and control plane, Docker infrastructure provider) images. 
The workflow builds, pushes, and signs Docker images for amd64, arm64, and s390x. It also creates a GitHub release with the generated artifacts.

## Inputs

- **release_tag**: The release tag to use for the new version. This input is required when triggering the workflow manually.

## Workflow Structure

The workflow consists of three main jobs:

1. **buildandpublishimages**: Builds and publishes core CAPI and its providers' images. Images are pushed to the prime registry. The workflow includes the signing process using cosign.

2. **provenance**: Publishes the provenance of the images built in the previous step.

3. **release**: Creates a GitHub release with the generated artifacts.

## Adding New Images

If you need to add new images or make modifications to the workflow:

1. Add the image name to the list of outputs in the `buildandpublishimages` job.

2. Modify the `ALL_ARCH` and `ALL_DOCKER_BUILD` environment variables in the `Build, push, and sign Cluster API images` step to include any new images.

3. Adjust the signing process using Cosign in the same step.

4. If new images are added, update the matrix in the `provenance` job to include the image names and corresponding digests.
