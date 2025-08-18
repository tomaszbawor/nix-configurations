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

    open = false;
    nvidiaSettings = true;

    # package = config.boot.kernelPackages.nvidiaPackages.production;
    ## Driver Override example
    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "580.76.05";
      sha256_64bit = "sha256-IZvmNrYJMbAhsujB4O/4hzY8cx+KlAyqh7zAVNBdl/0=";
      settingsSha256 = "sha256-ll7HD7dVPHKUyp5+zvLeNqAb6hCpxfwuSyi+SAXapoQ=";
      openSha256 = lib.fakeSha256;
      persistencedSha256 = lib.fakeSha256;
    };
  };

}
