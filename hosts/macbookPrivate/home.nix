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
        programs.git = {
          enable = true;
          userName = "Tomasz Bawor";
        };

      };
  };

}
