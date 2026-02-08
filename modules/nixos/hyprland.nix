{ pkgs, ... }:
{
  # Enable Hyprland compositor
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # XDG portal for Wayland
  xdg.portal = {
    enable = true;
    wlr.enable = false; # Use hyprland portal instead
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
    config = {
      common = {
        default = [
          "hyprland"
          "gtk"
        ];
      };
      hyprland = {
        default = [
          "hyprland"
          "gtk"
        ];
      };
    };
  };

  # Required services
  services = {
    gvfs.enable = true; # Trash, mounting, and other functionalities
    tumbler.enable = true; # Thumbnail support for images
    gnome.gnome-keyring.enable = true; # Secrets management
    blueman.enable = true; # Bluetooth manager
    power-profiles-daemon.enable = true;
    upower.enable = true;
  };

  # Enable Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true; # For battery reporting
      };
    };
  };

  # Security - for screen locking
  security.pam.services.hyprlock = { };

  # Packages required for Hyprland ecosystem
  environment.systemPackages = with pkgs; [
    # Core Hyprland utilities
    hyprlock # Lock screen
    hypridle # Idle daemon
    hyprpaper # Wallpaper
    hyprpicker # Color picker

    # Status bar
    waybar

    # App launcher
    walker

    # Notifications
    swaynotificationcenter # swaync

    # Clipboard
    wl-clipboard
    cliphist

    # Screenshots
    grim # Screenshot tool
    slurp # Region selection
    swappy # Screenshot annotation

    # Screen recording
    wf-recorder

    # File manager
    nautilus

    # Brightness control
    brightnessctl

    # Audio
    pavucontrol
    pamixer

    # Network
    networkmanagerapplet

    # Authentication agent
    polkit_gnome

    # Additional utilities
    wlsunset # Blue light filter
    wlogout # Logout menu
    swww # Animated wallpaper daemon (alternative to hyprpaper)
  ];

  # Environment variables for Wayland
  environment.sessionVariables = {
    # Do not force DISPLAY on Wayland; let the compositor/XWayland set it.
    # Hardcoding can cause odd behavior with capture/portals on some setups.
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    GDK_BACKEND = "wayland,x11";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    MOZ_ENABLE_WAYLAND = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };
}
