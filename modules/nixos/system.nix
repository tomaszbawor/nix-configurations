{
  config,
  username,
  ...
}:
{
  nix = {
    settings = {
      # Build throughput: let Nix pick sane defaults for this machine instead
      # of hard-capping concurrency (noticeably speeds up rebuilds/dev loops).
      max-jobs = "auto";

      # 0 means "use all available cores". Nix uses this for scheduling and for
      # builds that can actually utilize multiple cores.
      cores = 0;

      download-buffer-size = 250000000;
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9B8X524t6SdoVufp3My3AytGxr7EF3AoCY7CI="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
  };
  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Keep Polish keyboard layout
  console.keyMap = "pl2";
  system.stateVersion = "24.11"; # Do not change!

  # Compressed RAM swap: prevents hard UI stalls during memory pressure
  # (e.g. builds + containers + OBS), while still keeping the system responsive.
  zramSwap = {
    enable = true;
    algorithm = "lz4"; # prioritize low CPU overhead over max compression
    memoryPercent = 25;
  };

  system.autoUpgrade = {
    enable = true;

    # Flake-based auto-upgrades keep the system consistent with this repo and
    # avoid mixing channels with a flake-pinned configuration.
    flake = "/home/${username}/nix-configurations#${config.networking.hostName}";

    # Avoid background writes to flake.lock / git state (do input updates via
    # an explicit `nh os switch -u` / `nix flake update` workflow instead).
    flags = [ "--no-write-lock-file" ];
  };

  programs = {
    nix-ld.enable = true; # Shim layer to link libraries for precompiled binaries
  };

}
