{ pkgs, ... }:
{

  home.file = {
    ".config/nvim" = {
      source = ./../../../others/nvim;
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
