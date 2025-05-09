{
  pkgs,
  username,
  ...
}:
{
  boot.kernelPackages = pkgs.linuxPackages_zen;
}
