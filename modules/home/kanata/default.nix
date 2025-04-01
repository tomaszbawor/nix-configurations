{ pkgs, config, lib, username, ... }:
with lib;
let
  cfg = config.features.home.kanata-homerow;
  inherit username;
in {
  options.features.home.kanata-homerow.enable =
    mkEnableOption "Kanata Homerow configuration";

  config = mkIf cfg.enable {
    # Set up udev rules for uinput
    services.udev.extraRules = ''
      KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
    '';
    boot.kernelModules = [ "uinput" ];
    hardware.uinput.enable = true;
    systemd.services.kanata-default.serviceConfig = {
      SupplementaryGroups = [ "input" "uinput" ];
    };
    users.groups.uinput.members = [ "${username}" "root" ];
    users.groups.input.members = [ "${username}" "root" ];
    services.kanata = mkIf pkgs.stdenv.isLinux {

      enable = true;
      keyboards.default = {
        configFile = ./kanata.kbd;
        devices = [ ];
      };
    };

    home-manager = {
      users.${username} = { inputs, pkgs, config, lib, ... }: { };
    };
  };
}

