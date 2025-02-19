# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ pkgs
, ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  features = {
    synology-drive.enable = true;
    docker.enable = true;
    virtualbox.enable = false;
    steam.enable = true;
    nvidia.enable = true;
    hyprland.enable = true;
  };

  # Bootloader config
  boot.loader = {
    efi.efiSysMountPoint = "/boot";
    grub = {
      enable = true;
      configurationLimit = 10;
      devices = [ "nodev" ];
      efiInstallAsRemovable = true;
      efiSupport = true;
      useOSProber = true;
    };
  };

  # Networking
  networking = {
    hostName = "tomasz-nixos-desktop"; # Define your hostname.
    networkmanager.enable = true;
  };

  # xServer
  services.xserver = {
    enable = true; # Enable the X11 windowing system

    displayManager = {
      gdm = {
        enable = true;
        autoSuspend = false;
      };
    };

    videoDrivers = [ "nvidia" ];
  };

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    wget

    # Lazy Vim deps
    gcc
    zig
    unzip
    # Lazy Vim deps END

    # Terminal
    ghostty

    # secret management
    sops
    age

    # Gleam
    erlang
    gleam
  ];

  # Flatpak App Installer
  services.flatpak.enable = true;

  # Disable autosuspend deamon
  services.autosuspend.enable = false;

  # Disable power management
  powerManagement.enable = false;

  system.stateVersion = "24.11"; # Did you read the comment?
}
