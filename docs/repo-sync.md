# Sync Upstream CAPI Repository with Rancher Fork

This GitHub Workflow automates the synchronization of the upstream Cluster API (CAPI) repositories with a Rancher forks. The synchronization is scheduled to run daily at midnight (UTC) or manually triggered on demand.

## Workflow Structure

The workflow comprises two jobs:

1. **sync-repo-on-schedule**: Runs only on schedule (daily at midnight UTC) and syncs all CAPI forks with the upstream repositories.

2. **sync-repo-on-demand**: Runs only on demand and syncs the individual CAPI provider specified through the input.

## Adding New Providers

To sync additional CAPI providers, modify the matrix in the `sync-repo-on-schedule` job to include the new provider. Ensure the `sync-repo.sh` script supports the synchronization of the new provider by adding repository
location.
