# cluster-api-fork-sync

## Description

This repository is designed to synchronize upstream Cluster API related forks, create custom releases and build/publish continer images for them.
The resulting images are SLSA3-compliant and are published to the Prime container registry.

## Usage

### Adding a new repository to the syncronization workflow

The syncronization [workflow](.github/workflows/repo-sync.yaml) automates the synchronization of the upstream Cluster API repositories with a Rancher forks, it's scheduled to run daily at midnight (UTC) or can be manually triggered on demand.

Before adding a new repository fork to the syncronization workflow, please make sure that:

- Github Actions are disabled for the fork.
- [highlander-ci-bot](https://github.com/highlander-ci-bot) is added to the repository collaborators with `write` permission.

Add the repository to the [workflow](.github/workflows/repo-sync.yaml) workflow:

- Add the repository name to the input variable and worfklow matrix.
- Add repository source and destination location to the [sync-repo.sh](sync-repo.sh) script.

### Building and publishing container images

Create a new workflow file in the [workflows](.github/workflows) directory with the name of the repository you want to build images for. Refer to the [existing workflows](.github/workflows) for examples. If the repository contains complex logic or is not similar to other repositories, create a new
documentation file in the [docs](docs) directory.