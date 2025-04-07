{
  pkgs,
  config,
  username,
  inputs,
  ...
}:
{
  ids.gids.nixbld = 350;

  environment = {

    systemPackages = [
      pkgs.coreutils
      pkgs.libiconv
    ];

    variables = {
      LIBRARY_PATH = "${pkgs.libiconv}/lib:$LIBRARY_PATH";
      LD_LIBRARY_PATH = "${pkgs.libiconv}/lib:$LD_LIBRARY_PATH";
      CPATH = "${pkgs.libiconv}/include:$CPATH";
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  system.activationScripts.applications.text =
    let
      env = pkgs.buildEnv {
        name = "system-applications";
        paths = config.environment.systemPackages;
        pathsToLink = "/Applications";
      };
    in
    pkgs.lib.mkForce ''
      # Set up applications.
      echo "setting up /Applications..." >&2
      rm -rf /Applications/Nix\ Apps
      mkdir -p /Applications/Nix\ Apps
      find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
      while read -r src; do
        app_name=$(basename "$src")
        echo "copying $src" >&2
        ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
      done
    '';

  nix = {
    enable = true;

    package = pkgs.nix;

    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 2;
        Minute = 0;
      };
      options = "--delete-older-than 30d";
    };

    # Turn this on to make command line easier
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nix-homebrew = {
    user = username;
    enable = true;
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
    };
    mutableTaps = false;
    enableRosetta = true;
    autoMigrate = true;
  };

}
