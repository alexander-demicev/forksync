#!/bin/bash

set -o errexit
set -o pipefail
set -o xtrace

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <provider_name> <github_token>"
  exit 1
fi

# Define the provider name passed as an argument
provider_name="$1"

# Define the source and destination repositories based on the provider name
case "$provider_name" in
  "core")
    source_repo="https://github.com/kubernetes-sigs/cluster-api.git"
    destination_repo="https://x-access-token:$2@github.com/alexander-demicev/cluster-api.git"
    ;;
  "operator")
    source_repo="https://github.com/kubernetes-sigs/cluster-api-operator.git"
    destination_repo="https://x-access-token:$2@github.com/alexander-demicev/cluster-api-operator.git"
    ;;
  "aws")
    source_repo="https://github.com/kubernetes-sigs/cluster-api-provider-aws.git"
    destination_repo="https://x-access-token:$2@github.com/alexander-demicev/cluster-api-provider-aws.git"
    ;;
  # Add more cases for other providers as needed
  *)
    echo "Invalid provider name."
    exit 1
    ;;
esac

# Clone the source repository
echo "Cloning $source_repo"
git clone --mirror "$source_repo" source_repo_temp
cd source_repo_temp

# Fetch all branches and tags
echo "Fetching all branches and tags from $source_repo"
git fetch --all --tags

echo "Pushing all branches and tags to $destination_repo"
# Iterate over local refs and push only branches and tags, excluding pull request refs
for ref in $(git for-each-ref --format '%(refname:short)' refs/heads refs/tags | grep -v 'refs/pull'); do
  git push "$destination_repo" "$ref"
done

# Cleanup: Remove temporary directory
cd ..
rm -rf source_repo_temp

echo "Git repository $source_repo cloned into $destination_repo, branches and tags fetched, and pushed to the destination repository."
