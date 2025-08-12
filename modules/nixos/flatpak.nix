{ inputs, pkgs, ... }:
{
  # Dependent on flatpaks flake
  services = {

    flatpak = {
      enable = true; # Enable Flatpak
      packages = [
        "org.freecad.FreeCAD"
        "com.bambulab.BambuStudio"
      ];

      update.onActivation = true;

    };
  };

}
