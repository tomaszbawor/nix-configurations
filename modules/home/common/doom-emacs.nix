{
  pkgs,
  config,
  lib,
  ...
}:
let
  doomDir = "${config.home.homeDirectory}/.config/emacs";
  doomConfigDir = "${config.home.homeDirectory}/.config/doom";
in
{
  options.my.doom = {
    configPath = lib.mkOption {
      type = lib.types.str;
      default = "/home/tomasz/nix-configurations/others/doom";
      description = "Path to the Doom Emacs configuration directory";
    };
  };

  config = {
    home.file = {
      ".config/doom" = {
        source = config.lib.file.mkOutOfStoreSymlink config.my.doom.configPath;
        recursive = true;
      };
    };

    home.sessionPath = [
      "${doomDir}/bin"
    ];

    home.packages = with pkgs; [
      emacs
      git
      ripgrep
      fd
    ];

    home.activation.doomEmacs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ ! -d "${doomDir}" ]; then
        ${pkgs.git}/bin/git clone --depth 1 https://github.com/doomemacs/doomemacs "${doomDir}"
      fi

      if [ -x "${doomDir}/bin/doom" ]; then
        export DOOMDIR="${doomConfigDir}"
        if [ ! -d "${doomDir}/.local" ]; then
          "${doomDir}/bin/doom" install --force --no-config --no-env
        fi
        "${doomDir}/bin/doom" sync --force
      fi
    '';
  };
}
