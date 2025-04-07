{
  config,
  lib,
  username,
  ...
}:
with lib;
let
  cfg = config.features.home.ghostty;
  inherit username;
in
{
  options.features.home.ghostty.enable = mkEnableOption "Enable ghostty";

  config = mkIf cfg.enable {
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
          programs.ghostty = {
            enable = true;
            enableFishIntegration = true;
          };
        };
    };
  };
}
