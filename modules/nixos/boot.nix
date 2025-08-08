{
  pkgs,
  username,
  ...
}:
{
  # boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_16;
}
