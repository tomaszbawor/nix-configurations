{ config, lib, username, ... }: with lib; let
  cfg = config.features.darwin.commonBrew;
  inherit username;
in
{
  options.features.darwin.commonBrew.enable = mkEnableOption "Enable common brew packages";


  config = mkIf cfg.enable {

    homebrew = {
      # This is a module from nix-darwin
      # Homebrew is *installed* via the flake input nix-homebrew
      enable = true;
      casks = [
        "bruno"
        "1password"
        "ghostty"
        "1password-cli"
        "bruno"
        "obsidian"
        "docker"
        "rectangle-pro"
      ];
      brews = [
        "ffmpeg"
        "imagemagick"
      ];
      onActivation = {
        cleanup = "zap";
        autoUpdate = true;
      };

      # These app IDs are from using the mas CLI app
      # mas = mac app store
      # https://github.com/mas-cli/mas
      #
      # $ nix shell nixpkgs#mas
      # $ mas search <app name>
      #
      masApps = {
        "Delete Apps" = 1033808943;
      };
    };


  };
}
