{ config, lib, ... }:
{

  ## Video drivers
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    # Keep the NVIDIA driver initialized even when no clients are connected.
    # This can reduce "first use" hiccups for NVENC/compute workloads, at the
    # cost of higher idle power draw.
    nvidiaPersistenced = true;

    open = false;
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.production;
    ## Driver Override example
    # package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    #   version = "590.48.01";
    #   sha256_64bit = "sha256-ueL4BpN4FDHMh/TNKRCeEz3Oy1ClDWto1LO/LWlr1ok=";
    #   settingsSha256 = "sha256-ll7HD7dVPHKUyp5+zvLeNqAb6hCpxfwuSyi+SAXapoQ=";
    #   openSha256 = lib.fakeSha256;
    #   persistencedSha256 = lib.fakeSha256;
    # };
  };

}
