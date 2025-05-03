{ host, ... }:
{
  services.xserver = {
    enable = false;
    xkb = {
      layout = "pl";
      variant = "";
    };

    displayManager.gdm.enable = true;

    windowManager.hypr.enable = true;
  };
}
