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

        # Import common modules for all systems
        imports = [ ./common ]
          # Conditionally import system-specific modules
          ++ (if builtins.match ".*-darwin" system != null then [ ./darwin ] else [ ./nixos ]);
      };
  };
}
