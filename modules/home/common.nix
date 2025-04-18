{
  username,
  inputs,
  config,
  lib,
  system,
  ...
}:
let
  kubectl = inputs.krew2nix.packages.${system}.kubectl;
in
{

  config.lib.meta = {
    configPath = "${config.my.home}/git/config";
    mkMutableSymlink =
      path:
      config.hm.lib.file.mkOutOfStoreSymlink (
        config.lib.meta.configPath + lib.removePrefix (toString inputs.self) (toString path)
      );
  };

  config.home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;

    users.${username} =
      { pkgs, ... }:
      {
        home.stateVersion = "24.11";
        programs.home-manager.enable = true;

        xdg.enable = true;

        home.packages = with pkgs; [
          # terminal tools
          jq
          ripgrep
          htop
          jujutsu
          tldr
          cht-sh

          # Kubernetes
          (kubectl.withKrewPlugins (plugins: [
            plugins.ns
            plugins.ctx
          ]))
          argocd
          argocd-autopilot
          kustomize
          kubectx
          wget
          kubernetes-helm
          fluxcd
          lens

          # git
          diff-so-fancy
          lazygit

          # ansible
          sshpass

          # fonts
          nerd-fonts.jetbrains-mono

          # blog
          hugo

          # notes
          zk
        ];
      };
  };
}
