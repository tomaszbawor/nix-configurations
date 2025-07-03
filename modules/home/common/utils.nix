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
    nix-direnv.enable = true;
    enableFishIntegration = true;
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

    xclip
    nixfmt-rfc-style
    claude-code

    nh
    nix-output-monitor
    nvd

  ];

}
