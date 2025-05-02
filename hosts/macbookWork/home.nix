{ username, ... }:
{

  features.home = {
    cli.enable = true;
    lazyvim.enable = true;
    lazyvim.nvimPath = "/Users/${username}/nix-configurations/others/nvim";
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

        imports = [ ./../../modules/home/work-packages.nix ];

        programs.git = {
          enable = true;
          userName = "Tomasz Bawor";
        };
      };
  };

}
