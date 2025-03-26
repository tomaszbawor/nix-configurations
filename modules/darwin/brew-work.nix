{ config, lib, ... }:
with lib;
let cfg = config.features.darwin.workBrew;
in {
  options.features.darwin.workBrew.enable =
    mkEnableOption "Enable brew packages for work";

  config = mkIf cfg.enable {
    homebrew = {
      brews = [ "ollama" ];
      casks = [ "vmware-horizon-client" ];
    };
  };
}
