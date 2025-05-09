{ pkgs, config, lib, ... }:

{
  options.my.nvim = {
    configPath = lib.mkOption {
      type = lib.types.str;
      default = "/home/tomasz/nix-configurations/others/nvim";
      description = "Path to the Neovim configuration directory";
    };
  };

  config = {
    home.file = {
      ".config/nvim" = {
        source = config.lib.file.mkOutOfStoreSymlink config.my.nvim.configPath;
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
  };
}
