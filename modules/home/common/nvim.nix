{ pkgs, config, ... }:
{

  home.file = {
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/tomasz/nix-configurations/others/nvim";
      recursive = true;
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    neovim
    lua
    gcc
    unzip
    python314Full
  ];
}
