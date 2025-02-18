{ pkgs
, username
, ...
}:
{

  features.home = {
    cli.enable = true;
    lazyvim = {
      enable = true;
      nvimPath = "/home/${username}/nix-configurations/others/nvim";
    };
  };

  home-manager = {
    users.${username} =
      { pkgs
      , config
      , lib
      , ...
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
