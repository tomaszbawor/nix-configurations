{ pkgs, ... }:
{

  home.packages = [
    pkgs.vscode

    pkgs.jetbrains.idea-ultimate

    # Programming tools
    pkgs.rustup
  ];

  programs.java = {
    enable = true;
    package = pkgs.temurin-bin-21;
  };

  programs.go.enable = true;
  programs.poetry.enable = true;
}
