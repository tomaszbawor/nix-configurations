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

        imports = [ ./hyprland ];
      };
  };
}
