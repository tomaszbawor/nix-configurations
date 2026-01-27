{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wl-clipboard
    cliphist
    brightnessctl
    fuzzel
    swayidle
    swaylock
  ];
}
