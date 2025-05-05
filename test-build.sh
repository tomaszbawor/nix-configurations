#!/usr/bin/env bash
# Test script to build all configurations (NixOS and Darwin)
set -euo pipefail

echo "Building NixOS desktop..."
# Build the NixOS desktop system
nix build --no-link .#nixosConfigurations.desktop.config.system.build.toplevel

echo "Building Darwin (Work)..."
# Build the macOS work configuration
nix build --no-link .#darwinConfigurations.work.config.system.build.toplevel

echo "Building Darwin (Private)..."
# Build the macOS private configuration
nix build --no-link .#darwinConfigurations.private

echo "All configurations built successfully."

