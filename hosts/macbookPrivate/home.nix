{ username, ... }:
{
  features.home = {
    lazyvim = {
      enable = true;
      nvimPath = "/Users/tomasz/nix-configurations/others/nvim";
    };
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
