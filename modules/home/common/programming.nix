{ pkgs, ... }:
{

  home.packages = with pkgs; [
    vscode

    # Ovverride JDK fixes intellij java sdk build failure
    # (jetbrains.idea-ultimate.override {
    #   jdk = pkgs.openjdk21;
    # })

    # Programming tools
    rustup

    # Gleam
    erlang
    gleam

    # JS runtime
    bun

    ## Lua package manager 
    lux-cli
  ];

  programs.java = {
    enable = true;
    package = pkgs.temurin-bin-21;
  };

  programs.go.enable = true;
  programs.poetry.enable = true;
}
