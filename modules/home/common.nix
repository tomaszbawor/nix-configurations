{ username
, inputs
, config
, lib
, ...
}:
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
      { pkgs
      , ...
      }:
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

          # Kubernetes
          kubectl
          krew
          wget

          # git
          diff-so-fancy
          lazygit
          commitizen
          pre-commit

          # ansible
          ansible
          sshpass

          # fonts
          nerd-fonts.jetbrains-mono
          neofetch
        ];
      };
  };
}
