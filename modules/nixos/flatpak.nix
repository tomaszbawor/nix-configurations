{ inputs, pkgs, ... }:
{
  # Dependent on flatpaks flake
  services = {

    flatpak = {
      enable = true; # Enable Flatpak
      remotes = {
        "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        "flathub-beta" = "https://dl.flathub.org/beta-repo/flathub-beta.flatpakrepo";
      };
      packages = [
        "flathub:app/com.freecad.FreeCAD//stable"
        "flathub:app/com.bambulab.BambuStudio//stable"
      ];

    };
  };

}
