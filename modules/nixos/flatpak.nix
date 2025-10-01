{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  # Dependent on flatpaks flake
  services = {

    flatpak = {
      enable = true; # Enable Flatpak

      remotes = lib.mkOptionDefault [
        # mkOptionDefault is merging with current props, not overriding
        {
          name = "beta";
          location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
        }
      ];

      packages = [
        {
          appId = "org.freecad.FreeCAD";
          origin = "beta";
        }
        "com.bambulab.BambuStudio"
        # "org.freecad.FreeCAD"
      ];

      update.onActivation = true;

    };
  };
}
