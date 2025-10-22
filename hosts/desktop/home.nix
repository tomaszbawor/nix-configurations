{ username, ... }:
{

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

          settings = {
            user = {
              name = "Tomasz Bawor";
              email = "bawortomasz@gmail.com";
            };
          };
        };
      };
  };

}
