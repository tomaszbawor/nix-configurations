{ config, pkgs, username, ... }: {

  features.darwin = {
    commonBrew.enable = true;
    workBrew.enable = true;
  };
  # zsh is the default shell on Mac and we want to make sure that we're
  # configuring the rc correctly with nix-darwin paths.
  programs.zsh.enable = true;
  programs.zsh.shellInit = ''
    # Nix
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
      . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
    # End Nix
  '';

  programs.fish.enable = true;

  programs.fish.shellInit = ''
    # Nix
    if test -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
      source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
    end
    # End Nix
  '';

  environment.shells = [ pkgs.fish pkgs.zsh pkgs.bashInteractive ];

  environment.variables = {
    NIX_SSL_CERT_FILE = "/etc/nix/ca_cert.pem";
    SSL_CERT_FILE = "/etc/nix/ca_cert.pem";
    REQUEST_CA_BUNDLE = "/etc/nix/ca_cert.pem";
  };

  # User Darwin Settings
  users.users.${username} = {
    home = "/Users/${username}";
    shell = pkgs.fish;
  };

  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];

  system = {
    stateVersion = 4;
    # Turn off NIX_PATH warnings now that we're using flakes
    checks.verifyNixPath = false;

    defaults = {
      NSGlobalDomain = {
        KeyRepeat = 2;
        InitialKeyRepeat = 15;
      };

      finder = {
        _FXShowPosixPathInTitle = false;
      };
    };
  };

}
