{ pkgs, ... }:
{
  programs.starship = {
    enable = true;
    package = pkgs.starship;
    enableFishIntegration = true;
    enableInteractive = true;
  };
}
