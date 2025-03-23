# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

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
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "tbawor-nixos-desktop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  services.xserver = {
    enable = true; # Enable the X11 windowing system

    displayManager = {
      gdm = {
        enable = true;
        autoSuspend = false;
      };
    };

    desktopManager = {
      gnome.enable = true;
    };

    videoDrivers = [ "nvidia" ];
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "pl2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
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

    talosctl

    gnomeExtensions.pop-shell
    dconf2nix
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tomasz = {
    isNormalUser = true;
    description = "Tomasz Bawor";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # Enable automatic login for the user..
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "tomasz";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
