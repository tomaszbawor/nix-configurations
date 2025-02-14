{ username
, ...
}: {

  features.home = {
    cli.enable = true;
    lazyvim.enable = true;
    lazyvim.nvimPath = "/Users/pl8000224/nix-configurations/others/nvim";
    ides.enable = true;
    gui-apps.enable = false;
    ghostty.enable = false;
  };

  home-manager = {

    users.${username} = { pkgs, config, lib, ... }: {

      programs.git = {
        enable = true;
        userName = "Tomasz Bawor";
      };

      programs.go.enable = true;
      programs.poetry.enable = true;
    };
  };

}
