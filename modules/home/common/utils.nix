{ pkgs, ... }:
{

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    shell = "${pkgs.fish}/bin/fish";
    mouse = true;
    baseIndex = 1;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.zellij = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
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

    # git
    diff-so-fancy
    lazygit

    # blog
    hugo

    # notes
    zk

    # others
    repomix # zipping repo into one file

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
  ];

}
