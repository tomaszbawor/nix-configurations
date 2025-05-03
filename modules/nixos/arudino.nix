{
  pkgs,
  username,
  ...
}:
{

  environment.systemPackages = with pkgs; [
    avrdude
    ravedude
    avrdudess
    pkgsCross.avr.buildPackages.gcc
    pkgsCross.avr.buildPackages.binutils
    pkgsCross.avr.buildPackages.avrdude
  ];
}
