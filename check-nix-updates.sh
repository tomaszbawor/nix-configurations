#!/usr/bin/env bash

set -e

# Define temporary files
BEFORE_FILE=$(mktemp)
AFTER_FILE=$(mktemp)

# Function to extract package name and version from system derivations
extract_packages() {
  nix-store --query --requisites /run/current-system | xargs nix path-info --json | jq -r '.[] | select(.name | test("-[0-9]")) | .name' | sort
}

echo "Fetching current package versions..."
extract_packages >"$BEFORE_FILE"

echo "Updating flake..."
nix flake update

echo "Building new configuration..."
nixos-rebuild build --flake .#desktop

echo "Fetching new package versions..."
extract_packages >"$AFTER_FILE"

# Compare the package lists
echo "Comparing package versions..."
diff --side-by-side --suppress-common-lines "$BEFORE_FILE" "$AFTER_FILE" | awk '{print $1 " : " $2 " -> " $4}'

# Cleanup
rm "$BEFORE_FILE" "$AFTER_FILE"

echo "Done!"
