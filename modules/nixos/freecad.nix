{
  pkgs,
  username,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    freecad-wayland
  ];

  nixpkgs.overlays = [
    (final: prev: {
      coin3d = prev.coin3d.overrideAttrs {
        src = prev.fetchFromGitHub {
          owner = "coin3d";
          repo = "coin";
          rev = "v4.0.3";
          hash = "sha256-dUFmcUOdNc3ZFtr+Hnh3Q3OY/JA/WxmiRJiU2RFSSus=";
        };
      };
    })
  ];
}
