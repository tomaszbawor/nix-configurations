{
  config,
  lib,
  username,
  ...
}:
with lib;
let
  cfg = config.features.home.lazyvim;
  inherit username;
in
{
  options.features.home.lazyvim.enable = mkEnableOption "Enable cli setup";
  options.features.home.lazyvim.nvimPath = mkOption {
    type = types.str;
    default = "";
    description = "Absolute path to the nvim configuration directory";
  };

  config = mkIf cfg.enable {

    home-manager = {
      users.${username} =
        {
          inputs,
          pkgs,
          config,
          lib,
          ...
        }:
        {

          home.file = {
            ".config/nvim" = {
              source = config.lib.file.mkOutOfStoreSymlink "${cfg.nvimPath}";
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
            zig
            unzip
            python314Full
          ];
        };
    };
  };
}
