# Contributing

## Pull Request Workflow

This repository uses GitHub Actions to validate that configurations build correctly. When submitting a pull request, follow these steps:

1. Create a new branch for your changes:
   ```bash
   git checkout -b feature/my-new-feature
   ```

2. Make your changes to the configuration

3. Test your changes locally:
   ```bash
   # For NixOS configurations
   nix build .#nixosConfigurations.desktop.config.system.build.toplevel
   
   # For macOS configurations
   nix build .#darwinConfigurations.work.system
   nix build .#darwinConfigurations.private.system
   ```

4. Commit your changes:
   ```bash
   git add .
   git commit -m "Description of your changes"
   ```

5. Push your branch and create a pull request:
   ```bash
   git push -u origin feature/my-new-feature
   ```

6. Wait for the GitHub Actions workflow to complete. It will verify that:
   - The flake structure is valid
   - Code formatting is correct
   - All configurations build successfully

If any of the checks fail, review the workflow logs to identify and fix the issues, then push the fixes to your branch.

## Adding a New Host

To add a new host configuration:

1. Create a new directory in `hosts/` with your hostname
2. Add the necessary configuration files:
   - For NixOS: `configuration.nix` and `home.nix`
   - For macOS: `darwin.nix` and `home.nix`
3. Update `flake.nix` to include your new configuration
4. Update the GitHub workflow in `.github/workflows/validate-pr.yml` to include your new host in the CI process

## Formatting Guidelines

Use `nixfmt-rfc-style` for formatting Nix files:

```bash
nix fmt .
```

## Local Testing

Before submitting a PR, it's recommended to run the same checks that the CI will perform:

```bash
# Check flake structure
nix flake check --no-build

# Check formatting
nix fmt -- --check .

# Test builds
nix build .#nixosConfigurations.desktop.config.system.build.toplevel
nix build .#darwinConfigurations.work.system
nix build .#darwinConfigurations.private.system
```