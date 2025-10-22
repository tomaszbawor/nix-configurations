{ username, ... }:
{
  home-manager = {
    users.${username} =
      {
        pkgs,
        config,
        lib,
        ...
      }:
      {
        my.nvim.configPath = "/Users/${username}/nix-configurations/others/nvim";

        programs.git = {

          enable = true;
          settings = {
            user = {
              name = "Tomasz Bawor";
            };
          };
        };
      };
  };
}
