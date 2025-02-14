{ config
, lib
, username
, ...
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
        { inputs
        , pkgs
        , config
        , lib
        , ...
        }:
        {

          home.packages = with pkgs; [
            neovim
            bat
          ];

          programs.fish = {
            enable = true;
            generateCompletions = true;
            shellAliases = {
              ls = "eza";
              cat = "bat";
              lg = "lazygit";

              vim = "nvim";
              v = "nvim .";

              # Git
              gdc = "git diff --cached";
              glog = "git log --oneline";
              gs = "git status";

              # Kubernetes
              k = "kubectl";
              kgp = "kubectl get pods";

              # Gradle
              gb = "./gradlew build";
              gkf = "./gradlew ktlintFormat";

              # Ultilities
              gites = "git add .; git commit --amend --no-edit; git push -f";
            };
          };

          # Helper programs used in my ZSH Setup
          programs.zoxide = {
            enable = true;
            enableFishIntegration = true;
          };

          programs.eza = {
            enable = true;
            enableFishIntegration = true;
            enableBashIntegration = true;
            extraOptions = [
              "--icons"
              "--git"
            ];
          };

          programs.fzf = {
            enable = true;
            enableFishIntegration = true;
          };

          programs.starship = {
            enable = true;
            enableFishIntegration = true;
          };

          programs.k9s.enable = true;

          programs.zellij = {
            enable = false;
          };

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
