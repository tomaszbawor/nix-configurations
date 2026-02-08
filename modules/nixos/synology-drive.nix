{
  config,
  lib,
  username,
  ...
}:
{

  fileSystems."/home/${username}/synology-media" = {
    device = "192.168.1.10:/volume1/Media";
    fsType = "nfs";

    # Avoid boot/login stalls when the NAS is offline or slow: mount on first
    # access (systemd automount) instead of eagerly at boot.
    options = [
      "_netdev"
      "noauto"
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
      "x-systemd.device-timeout=5s"
      "x-systemd.mount-timeout=5s"
    ];
  };
}
