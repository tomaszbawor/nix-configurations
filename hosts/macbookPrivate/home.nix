{ username, ... }:
{
  features.home = {
    cli.enable = true;
    lazyvim = {
      enable = true;
      nvimPath = "/Users/tomasz/nix-configurations/others/nvim";
    };
    ides.enable = false;
    gui-apps.enable = false;
  };

  home-manager = {

    users.${username} =
      {
        pkgs,
        config,
        lib,
        ...
      }:
      {
        programs.git = {
          enable = true;
          userName = "Tomasz Bawor";
        };

      };
  };

}
