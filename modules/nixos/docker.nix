{ config, lib, username, ... }:
with lib;
let
  cfg = config.features.docker;
  inherit username;
in
{
  options.features.docker.enable = mkEnableOption "Enable docker support";

  config = mkIf cfg.enable {
    # docker
    virtualisation.docker.enable = true;
    users.extraGroups.docker.members = [ "${username}" ];
    virtualisation.docker.logDriver = "json-file";
  };
}
