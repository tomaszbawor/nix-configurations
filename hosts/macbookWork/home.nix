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
        imports = [ ./../../modules/home/work-packages.nix ];

        my.nvim.configPath = "/Users/${username}/nix-configurations/others/nvim";

        programs.git = {
          enable = true;
          userName = "Tomasz Bawor";
        };
      };
  };
}
