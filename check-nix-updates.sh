#!/usr/bin/env bash
set -e

# Colors for better readability
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if we're in a directory with a flake.nix
if [ ! -f flake.nix ]; then
  echo -e "${RED}Error: No flake.nix found in current directory${NC}"
  exit 1
fi

# Check if we have a flake.lock
if [ ! -f flake.lock ]; then
  echo -e "${RED}Error: No flake.lock found in current directory${NC}"
  exit 1
fi

echo -e "${YELLOW}=== GitHub Rate Limit Friendly NixOS Update Preview ===${NC}"

# Set up temporary file and ensure cleanup
TEMP_DIR=$(mktemp -d)
BACKUP_LOCK="$TEMP_DIR/flake.lock.backup"

cleanup() {
  # Restore original flake.lock if we backed it up
  if [ -f "$BACKUP_LOCK" ]; then
    echo -e "${BLUE}Restoring original flake.lock...${NC}"
    cp "$BACKUP_LOCK" flake.lock
  fi
  rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

# Backup the original flake.lock
echo -e "${BLUE}Backing up current flake.lock...${NC}"
cp flake.lock "$BACKUP_LOCK"

# Step 1: Check what's currently installed
echo -e "${BLUE}Getting current package information...${NC}"
# Save the current generation to a file for reference
CURRENT_GEN="$TEMP_DIR/current_gen.txt"
nixos-rebuild list-generations --flake .# | head -10 >"$CURRENT_GEN"

# Step 2: Get current list of packages using nix-store
CURRENT_PKGS="$TEMP_DIR/current_pkgs.txt"
echo -e "${BLUE}Getting detailed list of current packages...${NC}"
nix-store -q --references /run/current-system/sw | sort >"$CURRENT_PKGS"

# Step 3: Check if we have a GitHub token available to avoid rate limits
if [ -n "$GITHUB_TOKEN" ]; then
  echo -e "${GREEN}Using GITHUB_TOKEN from environment to avoid rate limits${NC}"
  export NIX_CONFIG="access-tokens = github.com=$GITHUB_TOKEN"
else
  echo -e "${YELLOW}No GITHUB_TOKEN found. You might hit rate limits.${NC}"
  echo -e "${YELLOW}Consider setting: export GITHUB_TOKEN=your_token${NC}"
fi

# Step 4: Try to update the flake with an increased timeout
echo -e "${BLUE}Attempting to update flake inputs (this might take time)...${NC}"
SECONDS=0
timeout 300 nix flake update --commit-lock-file 2>&1 | grep -v "warning:" || true
duration=$SECONDS
echo -e "${GREEN}Update completed in $duration seconds${NC}"

# Check if the lockfile was actually changed
if cmp -s flake.lock "$BACKUP_LOCK"; then
  echo -e "${YELLOW}No changes to flake.lock - nothing to update or update failed${NC}"
  exit 0
fi

# Step 5: Build the new system to see what would change
echo -e "${BLUE}Building updated system to compare package versions...${NC}"
# Hide stderr when running this command to avoid overwhelming output
NEW_PKGS="$TEMP_DIR/new_pkgs.txt"
nixos-rebuild build --flake .# >/dev/null 2>&1 || true
NEWSYS=$(readlink -f ./result)
if [ -e "$NEWSYS" ]; then
  nix-store -q --references $NEWSYS/sw | sort >"$NEW_PKGS"
else
  echo -e "${RED}Failed to build new system. Showing diff of flake.lock instead.${NC}"
  diff -u "$BACKUP_LOCK" flake.lock || true
  exit 1
fi

# Step 6: Compare packages to determine updates
echo -e "${YELLOW}=== Package changes that would occur after update ===${NC}"

echo -e "${BLUE}Creating comparison report...${NC}"
UPDATES="$TEMP_DIR/updates.txt"
ADDED="$TEMP_DIR/added.txt"
REMOVED="$TEMP_DIR/removed.txt"

# Find all packages existing in both old and new
comm -12 "$CURRENT_PKGS" "$NEW_PKGS" >"$TEMP_DIR/common.txt"
# Find all packages exclusive to new system
comm -13 "$CURRENT_PKGS" "$NEW_PKGS" >"$ADDED"
# Find all packages exclusive to current system
comm -23 "$CURRENT_PKGS" "$NEW_PKGS" >"$REMOVED"

# For common packages, check which ones have different derivations
echo -e "${GREEN}Package updates:${NC}"
while read pkg; do
  old_version=$(echo "$pkg" | sed -E 's/.*\/[^-]+-[^-]+-([^\/]+)$/\1/')
  old_name=$(echo "$pkg" | sed -E 's/.*\/([^-]+-[^-]+)-[^\/]+$/\1/')

  # Find the corresponding package in the new system
  if grep -q "$old_name" "$NEW_PKGS"; then
    new_pkg=$(grep "$old_name" "$NEW_PKGS" | head -1)
    new_version=$(echo "$new_pkg" | sed -E 's/.*\/[^-]+-[^-]+-([^\/]+)$/\1/')

    if [ "$old_version" != "$new_version" ]; then
      echo "  $old_name: $old_version → $new_version" >>"$UPDATES"
    fi
  fi
done <"$TEMP_DIR/common.txt"

# Display results in a nicely formatted way
if [ -s "$UPDATES" ]; then
  sort "$UPDATES" | uniq | head -50
  if [ $(wc -l <"$UPDATES") -gt 50 ]; then
    echo -e "${YELLOW}  (and $(($(wc -l <"$UPDATES") - 50)) more...)${NC}"
  fi
else
  echo "  No package updates detected"
fi

echo -e "\n${GREEN}New packages that would be installed:${NC}"
if [ -s "$ADDED" ]; then
  cat "$ADDED" | sed -E 's/.*\/([^-]+-[^-]+)-([^\/]+)$/  \1: \2/' | sort | head -20
  if [ $(wc -l <"$ADDED") -gt 20 ]; then
    echo -e "${YELLOW}  (and $(($(wc -l <"$ADDED") - 20)) more...)${NC}"
  fi
else
  echo "  No new packages"
fi

echo -e "\n${RED}Packages that would be removed:${NC}"
if [ -s "$REMOVED" ]; then
  cat "$REMOVED" | sed -E 's/.*\/([^-]+-[^-]+)-([^\/]+)$/  \1: \2/' | sort | head -20
  if [ $(wc -l <"$REMOVED") -gt 20 ]; then
    echo -e "${YELLOW}  (and $(($(wc -l <"$REMOVED") - 20)) more...)${NC}"
  fi
else
  echo "  No packages removed"
fi

echo -e "\n${GREEN}Done! To apply these changes:${NC}"
echo -e "  nix flake update"
echo -e "  nixos-rebuild switch"
