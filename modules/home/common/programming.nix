{ pkgs, ... }:
{

  home.packages = with pkgs; [
    vscode

    jetbrains.idea
    jetbrains.clion

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
    cmake
  ];

  programs.java = {
    enable = true;
    package = pkgs.temurin-bin-25;
  };

  programs.go.enable = true;
  # TODO: Re-enable once nixpkgs fixes pbs-installer version constraint
  # poetry 2.2.1 requires pbs-installer<2026.0.0 but nixpkgs has 2026.1.13
  # programs.poetry.enable = true;
}
