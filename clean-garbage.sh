#!/usr/bin/env bash

set -euo pipefail

echo "🧹 Cleaning up Nix garbage..."

# Delete old generations for all profiles
echo "➡️  Deleting old generations..."
nix profile wipe-history --older-than 7d || true
sudo nix-collect-garbage --delete-older-than 7d || true
nix-collect-garbage --delete-older-than 7d || true

# Delete unreachable paths
echo "➡️  Running nix-collect-garbage -d..."
sudo nix-collect-garbage -d || true
nix-collect-garbage -d || true

# Clean up logs
echo "➡️  Cleaning up log files..."
rm -rf ~/.cache/nix
sudo rm -rf /var/log/nix/* || true

# Optimize store
echo "➡️  Optimizing store..."
sudo nix-store --optimize || true

echo "✅ Nix cleanup complete."
