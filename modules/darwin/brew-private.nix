{ config, lib, ... }:
with lib;
let
  cfg = config.features.darwin.privateBrew;
in
{
  options.features.darwin.privateBrew.enable = mkEnableOption "Enable private brew packages";

  config = mkIf cfg.enable {
    homebrew = {
      brews = [
        "libiconv"
      ];

      # Add any private-specific casks here
      casks = [
        # Add your private-specific casks here
      ];

      # Add any private-specific Mac App Store apps here
      masApps = {
        # Example: "App Name" = 1234567890;
      };
    };
  };
}

