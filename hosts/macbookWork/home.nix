{ username, ... }: {

  features.home = {
    cli.enable = true;
    lazyvim.enable = true;
    lazyvim.nvimPath = "/Users/${username}/nix-configurations/others/nvim";
    ides.enable = true;
    gui-apps.enable = false;
    ghostty.enable = false;
  };

  home-manager = {

    users.${username} = { pkgs, config, lib, ... }: {

      imports = [ ./../../modules/home/work-packages.nix ];

      programs.git = {
        enable = true;
        userName = "Tomasz Bawor";
      };
    };
  };

}
