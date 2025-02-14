{ config
, lib
, username
, pkgs
, inputs
, ...
}:
with lib;
let
  cfg = config.features.hyprland;
  inherit username;
in
{
  options.features.hyprland.enable = mkEnableOption "Enable hyprland support";

  config = mkIf cfg.enable {

    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
      # set the flake package
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # make sure to also set the portal package, so that they are in sync
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    environment.systemPackages = with pkgs; [
      pavucontrol # sound controll
      cliphist # CLipboard history
      nautilus # File manager
      btop
      bottom
      wl-clipboard
    ];

    home-manager = {
      users.${username} =
        { pkgs
        , ...
        }:
        {

          imports = [
            ./hyprland-modules/waybar
            ./hyprland-modules/swaync
            ./hyprland-modules/hyprland
            ./hyprland-modules/wlogout
            ./hyprland-modules/rofi/rofi.nix
            ./hyprland-modules/rofi/config-emoji.nix
            ./hyprland-modules/rofi/config-long.nix

            ./hyprland-modules/scripts
          ];

          home.packages = with pkgs; [
            libsForQt5.xwaylandvideobridge
            libnotify
            xdg-desktop-portal-gtk
            xdg-desktop-portal-hyprland
            material-symbols
          ];

          gtk = {
            iconTheme = {
              name = "Papirus-Dark";
              package = pkgs.papirus-icon-theme;
            };
            gtk3.extraConfig = {
              gtk-application-prefer-dark-theme = 1;
            };
            gtk4.extraConfig = {
              gtk-application-prefer-dark-theme = 1;
            };
          };

          home.file.".config/swappy/config".text = ''
            [Default]
            save_dir=/home/${username}/Pictures/Screenshots
            save_filename_format=swappy-%Y%m%d-%H%M%S.png
            show_panel=false
            line_size=5
            text_size=20
            text_font=Ubuntu
            paint_mode=brush
            early_exit=true
            fill_shape=false
          '';

        };
    };
  };
}
