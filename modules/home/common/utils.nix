{ pkgs, ... }:
{

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  home.packages = with pkgs; [

    # terminal tools
    jq
    ripgrep
    htop
    jujutsu
    tldr
    cht-sh
    lsof
    kitty
    jless
    tree

    # git
    diff-so-fancy
    lazygit

    # blog
    hugo

    # notes
    zk

    # others
    repomix # zipping repo into one file
    systemctl-tui # tui for systemctl logs browsing

    cocogitto # conventional commits helper
    fnm # Node version manager

    # secret management
    sops
    age

    # terminal
    wezterm

    xclip

    # Nix Utils
    nh
    nix-output-monitor
    nvd
    nixfmt-rfc-style

    # Python
    uv

    # Docker
    lazydocker
  ];

}
