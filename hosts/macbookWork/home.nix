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

        programs.git = {
          enable = true;
          userName = "Tomasz Bawor";
        };
      };
  };

}
