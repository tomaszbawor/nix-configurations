{
  config,
  lib,
  username,
  pkgs,
  inputs,
  ...
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
        {
          inputs,
          pkgs,
          config,
          lib,
          ...
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
          ];

          home.packages = with pkgs; [
            libsForQt5.xwaylandvideobridge
            libnotify
            xdg-desktop-portal-gtk
            xdg-desktop-portal-hyprland
            material-symbols

            # Scripts
            (import ./hyprland-modules/scripts/emopicker9000.nix { inherit pkgs; })
            (import ./hyprland-modules/scripts/task-waybar.nix { inherit pkgs; })
            (import ./hyprland-modules/scripts/squirtle.nix { inherit pkgs; })
            (import ./hyprland-modules/scripts/nvidia-offload.nix { inherit pkgs; })
            (import ./hyprland-modules/scripts/wallsetter.nix {
              inherit pkgs;
              inherit username;
            })
            (import ./hyprland-modules/scripts/web-search.nix { inherit pkgs; })
            (import ./hyprland-modules/scripts/rofi-launcher.nix { inherit pkgs; })
            (import ./hyprland-modules/scripts/screenshootin.nix { inherit pkgs; })
            (import ./hyprland-modules/scripts/list-hypr-bindings.nix { inherit pkgs; })
          ];

          home.file."Pictures/Wallpapers" = {
            source = ../../others/wallpapers;
            recursive = true;
          };

          stylix.targets.waybar.enable = false;
          stylix.targets.rofi.enable = false;
          stylix.targets.hyprland.enable = false;
          stylix.targets.nixvim.enable = false;
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

          home.sessionVariables = {
            EDITOR = "nvim";
          };
        };
    };
  };
}
