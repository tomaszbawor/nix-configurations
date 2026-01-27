{
  host,
  pkgs,
  config,
  ...
}:
{
  services.xserver = {
    enable = false;
    xkb = {
      layout = "pl";
      variant = "";
    };
  };

  # Switch to greetd with Niri session via tuigreet
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --asterisks --cmd ${config.programs.niri.package}/bin/niri-session";
        user = "greeter";
      };
    };
  };

}
