{ host, pkgs, ... }:
{
  services.xserver = {
    enable = false;
    xkb = {
      layout = "pl";
      variant = "";
    };
  };

  # Switch to greetd with Hyprland session via tuigreet
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --asterisks --cmd ${pkgs.hyprland}/bin/start-hyprland";
        user = "greeter";
      };
    };
  };

}
