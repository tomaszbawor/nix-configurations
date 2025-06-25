{ host, ... }:
{
  services.xserver = {
    enable = false;
    xkb = {
      layout = "pl";
      variant = "";
    };

    windowManager.hypr.enable = true;
  };

  services.displayManager.gdm.enable = true;
}
