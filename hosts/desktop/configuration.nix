# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, lib, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "desktop"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Corne Keyboard
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="4653", ATTR{idProduct}=="0001", MODE="0666"
  '';
  services.udev.packages = with pkgs; [
    via
    qmk-udev-rules
  ];

  # Enable automatic login for the user..
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "tomasz";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Turn off auto suspend and sleep
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  services.flatpak = {
    enable = true;
    packages = [
      "flathub:app/com.mattjakeman.ExtensionManager/x86_64/stable"
      "flathub:app/app.freelens.Freelens/x86_64/stable"
    ];

    remotes = {
      "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      "flathub-beta" = "https://dl.flathub.org/beta-repo/flathub-beta.flatpakrepo";
    };
  };

  nixpkgs.config.permittedInsecurePackages = [
    "libsoup-2.74.3"
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
