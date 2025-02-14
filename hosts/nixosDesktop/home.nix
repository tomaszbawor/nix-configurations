{ pkgs
, username
, ...
}: {

  features.home = {
    cli.enable = true;
    lazyvim.enable = true;
    lazyvim.nvimPath = "/home/tomasz/nix-configurations/others/nvim";
    ides.enable = true;
    gui-apps.enable = true;
    ghostty.enable = true;
  };

  home-manager = {
    users.${username} = { inputs, pkgs, config, lib, ... }: {

      # Git Configuration
      programs.git = {
        enable = true;
        userName = "Tomasz Bawor";
        userEmail = "bawortomasz@gmail.com";
      };

      # Packages specific to this pc
      home.packages = [
        pkgs.gparted
        pkgs.ollama-cuda
        pkgs.spotify
        #        pkgs.nvtopPackages.nvidia
      ];

    };
  };

}
