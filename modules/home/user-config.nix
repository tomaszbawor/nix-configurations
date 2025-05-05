{
  username,
  inputs,
  config,
  lib,
  system,
  ...
}:
{

  config.lib.meta = {
    configPath = "${config.my.home}/git/config";
    mkMutableSymlink =
      path:
      config.hm.lib.file.mkOutOfStoreSymlink (
        config.lib.meta.configPath + lib.removePrefix (toString inputs.self) (toString path)
      );
  };

  config.home-manager = {
    backupFileExtension = "bkup";
    useGlobalPkgs = true;
    useUserPackages = true;

    users.${username} =
      { pkgs, ... }:
      {
        home.stateVersion = "24.11";

        # Import common modules, then conditionally import system-specific ones
        imports = [
          ./common
        ] ++ (if builtins.match ".*-darwin" system != null then [ ./darwin.nix ] else [ ./hyprland ]);
      };
  };
}
