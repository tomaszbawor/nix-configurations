{ pkgs, inputs, ... }:
{
  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps = {
      enable = true;
    };
    portal = {
      enable = true;
      configPackages = [ inputs.hyprland.packages.${pkgs.system}.default ];
    };
  };
}
