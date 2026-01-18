{ host, ... }:
{
  services.xserver = {
    enable = false;
    xkb = {
      layout = "pl";
      variant = "";
    };
  };

  # services.displayManager.gdm.enable = false;
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;
}
