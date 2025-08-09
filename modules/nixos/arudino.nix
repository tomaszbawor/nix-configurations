{
  pkgs,
  username,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    arduino
    arduino-ide
    avrdude
    ravedude
    avrdudess
    pkgsCross.avr.buildPackages.gcc
    pkgsCross.avr.buildPackages.binutils
    pkgsCross.avr.buildPackages.avrdude
  ];
}
