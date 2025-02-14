{ pkgs
, username
, ...
}: {

  features.home = {
    cli.enable = true;
    lazyvim = {
      enable = true;
      nvimPath = "/Users/tomasz/Code/SOCS/nixos-config/others/nvim";
    };
    ides.enable = true;
    gui-apps.enable = false;
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
