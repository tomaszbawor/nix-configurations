{ config, lib, username, ... }:
with lib;
let
  cfg = config.features.home.gui-apps;
  inherit username;
in
{
  options.features.home.gui-apps.enable =
    mkEnableOption "Enable Installation for GUI apps";

  config = mkIf cfg.enable {
    home-manager = {
      users.${username} = { inputs, pkgs, config, lib, ... }: {

        home.packages =
          [ pkgs.obsidian pkgs.bruno pkgs.google-chrome pkgs.brave ];

      };
    };
  };
}

