{ username, ... }:
{

  features.home = {
    cli.enable = true;
    lazyvim.enable = true;
    lazyvim.nvimPath = "/home/tomasz/nix-configurations/others/nvim";
    ides.enable = true;
  };

  home-manager = {
    users.${username} =
      {
        inputs,
        pkgs,
        config,
        lib,
        ...
      }:
      {

        # Git Configuration
        programs.git = {
          enable = true;
          userName = "Tomasz Bawor";
          userEmail = "bawortomasz@gmail.com";
        };

      };
  };

}
