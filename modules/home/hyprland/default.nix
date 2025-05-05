{ ... }:
{
  imports = [
    # Hyprland and related system-specific home-manager modules (NixOS only)
    ./core
    ./fastfetch
    ./rofi
    ./scripts
    ./waybar/waybar-curved.nix
    ./yazi
    ./wlogout
    ./stylix.nix
    ./swappy.nix
    ./swaync.nix
    ./xdg.nix
  ];
}
