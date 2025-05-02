{
  config,
  lib,
  username,
  ...
}:
with lib;
let
  cfg = config.features.home.cli;
  inherit username;
in
{
  options.features.home.cli.enable = mkEnableOption "Enable cli setup";

  config = mkIf cfg.enable {
    home-manager = {
      users.${username} =
        { pkgs, ... }:
        {

          home.packages = with pkgs; [
            cocogitto # conventional commits helper
            fnm # Node version manager
          ];

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

          programs.k9s.enable = true;

          programs.kubecolor = {
            enable = true;
            enableAlias = true;
          };

          programs.atuin = {
            enable = true;
            enableFishIntegration = true;
          };
        };

    };
  };
}
