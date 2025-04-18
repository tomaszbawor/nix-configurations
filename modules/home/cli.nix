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

          programs.fish = {
            enable = true;
            generateCompletions = true;

            loginShellInit = ''
              fnm env --use-on-cd --shell fish | source
            '';
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
              gadd = "git add .";

              # Kubernetes
              k = "kubectl";
              kgp = "kubectl get pods";
              k8s-get-namespaced = "kubectl api-resources --verbs=list --namespaced -o name  | xargs -n 1 kubectl get --show-kind --ignore-not-found -n";
              # Docker
              doco = "docker compose";

              # Gradle
              gb = "./gradlew build";
              gkf = "./gradlew ktlintFormat";

              # Ultilities
              gites = "git add .; git commit --amend --no-edit; git push -f";
              runbg = ''bash -c '"$@" > /dev/null 2>&1 & disown' --'';
            };
          };

          programs.bat.enable = true;

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

          programs.kubecolor = {
            enable = true;
            enableAlias = true;
          };

          programs.atuin = {
            enable = true;
            enableFishIntegration = true;
          };

          programs.btop.enable = true;
        };

    };
  };
}
