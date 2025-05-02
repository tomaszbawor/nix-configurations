{ host, ... }:
{
  imports = [
    ./animations-dynamic.nix # May change
    ./binds.nix
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./pyprland.nix
    ./windowrules.nix
  ];
}
