{ pkgs, ... }:
{
  programs.starship = {
    enable = true;
    package = pkgs.starship;
    enableZshIntegration = true;
    enableInteractive = true;
  };
}
