{
  config,
  lib,
  username,
  ...
}:
{

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "${username}" ];

  virtualisation.virtualbox.host.enableExtensionPack = true;
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.dragAndDrop = true;

  # Make virtualbox work on kernel 6.12
  boot.kernelParams = [ "kvm.enable_virt_at_load=0" ];
}
