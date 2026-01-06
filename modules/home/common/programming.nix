{ pkgs, ... }:
{

  home.packages = with pkgs; [
    vscode

    jetbrains.idea

    # Programming tools
    rustup

    # Gleam
    erlang
    gleam

    # JS runtime
    bun

    ## Lua package manager
    lux-cli

    # C programming
    clang-tools
  ];

  programs.java = {
    enable = true;
    package = pkgs.temurin-bin-25;
  };

  programs.go.enable = true;
  programs.poetry.enable = true;
}
