{ config, lib, ... }:
with lib;
let cfg = config.features.nvidia;
in {
  options.features.nvidia.enable = mkEnableOption "Enable nvidia drivers";

  config = mkIf cfg.enable {
    ## Video drivers
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;

      open = false;
      nvidiaSettings = true;

      #package = config.boot.kernelPackages.nvidiaPackages.beta;
      ## Driver Override example
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "570.133.07";
        sha256_64bit = "sha256-LUPmTFgb5e9VTemIixqpADfvbUX1QoTT2dztwI3E3CY=";
        openSha256 = "sha256-PMh5efbSEq7iqEMBr2+VGQYkBG73TGUh6FuDHZhmwHk=";
        settingsSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
        persistencedSha256 = lib.fakeSha256;
      };
    };

    environment.variables = {
      ## Wayland NVIDIA Fixes
      WLR_NO_HARDWARE_CURSORS = "1";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
  };
}
