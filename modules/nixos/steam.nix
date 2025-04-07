{
  config,
  lib,
  username,
  ...
}:
with lib;
let
  cfg = config.features.steam;
in
{
  options.features.steam.enable = mkEnableOption "Enable steam";

  config = mkIf cfg.enable {
    programs = {
      steam = {
        enable = true; # Enable Steam
        gamescopeSession.enable = true;
      };
    };
  };
}
