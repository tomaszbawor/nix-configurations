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
      # Do not make the system switch/boot fail if the NAS is unavailable or if
      # systemd cannot (re)start the automount during reconfiguration.
      "nofail"
      "noauto"
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
      "x-systemd.mount-timeout=5s"
    ];
  };
}
