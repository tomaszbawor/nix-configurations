{ config, lib, username, ... }: with lib; let
  cfg = config.features.synology-drive;
in
{
  options.features.synology-drive.enable = mkEnableOption "Synology Drive";

  config = mkIf cfg.enable {
    fileSystems."/home/${username}/synology-media" = {
      device = "192.168.1.10:/volume1/Media";
      fsType = "nfs";
    };
  };
}
