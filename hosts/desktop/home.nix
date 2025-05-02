{ username, ... }:
{

  features.home = {
    cli.enable = true;
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
