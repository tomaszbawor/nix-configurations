{
  pkgs,
  username,
  ...
}:
{
  programs.nh = {
    enable = true;
    clean = {
      enable = true;

      # We rely on `nh clean` instead of `nix.gc.automatic` to keep generations
      # and store size under control without duplicating cleanup mechanisms.
      extraArgs = "--keep-since 7d --keep 5";
    };
    flake = "/home/${username}/nix-configurations";
  };

  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nvd
  ];
}
