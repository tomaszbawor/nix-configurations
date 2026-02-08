{ config, ... }:
{
  # OBS Virtual Camera on Linux uses the `v4l2loopback` kernel module.
  # Loading it via NixOS avoids needing root access when starting the
  # virtual camera from within OBS.
  boot = {
    kernelModules = [ "v4l2loopback" ];

    # Build the module for the currently selected kernelPackages.
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];

    extraModprobeConfig = ''
      # `exclusive_caps=1` improves compatibility with WebRTC apps (e.g. browsers)
      # and conferencing software which expect the "new" V4L2 capability model.
      options v4l2loopback exclusive_caps=1 card_label="OBS Virtual Camera" video_nr=10
    '';
  };
}
