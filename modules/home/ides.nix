{
  config,
  lib,
  username,
  ...
}:
with lib;
let
  cfg = config.features.home.ides;
  inherit username;
in
{
  options.features.home.ides.enable = mkEnableOption "Enable cli setup";

  config = mkIf cfg.enable {

    # Fix for broken LLDB build needed for intellij

    nixpkgs.overlays = [
      (final: prev: {
        lldb = prev.lldb.overrideAttrs {
          dontCheckForBrokenSymlinks = true;
        };
      })
    ];

    home-manager = {
      users.${username} =
        {
          inputs,
          pkgs,
          config,
          lib,
          ...
        }:
        {

          home.packages = [
            pkgs.vscode

            pkgs.jetbrains.idea-ultimate
            pkgs.jetbrains.webstorm
            pkgs.jetbrains.rust-rover

            # Programming tools
            pkgs.rustup

            # Node Version Manager
            pkgs.nodejs_20
            pkgs.nodenv
          ];

          programs.java = {
            enable = true;
            package = pkgs.temurin-bin-21;
          };

          programs.go.enable = true;
        };
    };
  };
}
