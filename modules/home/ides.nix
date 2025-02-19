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

    home-manager = {
      users.${username} =
        {
          pkgs,
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
          programs.poetry.enable = true;
        };
    };
  };
}
