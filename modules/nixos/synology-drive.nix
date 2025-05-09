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
  };
}
