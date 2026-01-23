{ host, pkgs, ... }:
{
  services.xserver = {
    enable = false;
    xkb = {
      layout = "pl";
      variant = "";
    };
  };

  # Switch to a GUI greeter: SDDM on Wayland
  services.greetd.enable = false;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Optional: Plasma desktop remains disabled; Hyprland sessions are provided via Hyprland package
  services.desktopManager.plasma6.enable = false;
}
