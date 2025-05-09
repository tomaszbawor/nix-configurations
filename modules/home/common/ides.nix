{ pkgs, ... }:
{

  home.packages = with pkgs; [
    vscode

    jetbrains.idea-ultimate

    # Programming tools
    rustup

    # Gleam
    erlang
    gleam

    # AI Agent
    codex

    arduino
    arduino-ide
  ];

  programs.java = {
    enable = true;
    package = pkgs.temurin-bin-21;
  };

  programs.go.enable = true;
  programs.poetry.enable = true;
}