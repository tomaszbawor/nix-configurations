{
  pkgs,
  ...
}:
{
  programs = {
    firefox.enable = false; # Firefox is not installed by default
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    docker-compose # Allows Controlling Docker From A Single File
    ffmpeg # Terminal Video / Audio Editing
    tuigreet # The Login Manager (Sometimes Referred To As Display Manager)
    htop # Simple Terminal Based System Monitor
    killall # For Killing All Instances Of Programs
    brave # Browser
    libnotify # For Notifications
    lshw # Detailed Hardware Information
    nixd # Nix language server
    nwg-displays # configure monitor configs via GUI
    onefetch # provides zsaneyos build info on current system
    pciutils # Collection Of Tools For Inspecting PCI Devices
    picard # For Changing Music Metadata & Getting Cover Art
    playerctl # Allows Changing Media Volume Through Scripts
    socat # Needed For Screenshots
    unrar # Tool For Handling .rar Files
    unzip # Tool For Handling .zip Files
    usbutils # Good Tools For USB Devices
    wget # Tool For Fetching Files With Links
    ytmdl # Tool For Downloading Audio From YouTube
    obsidian # Note taking application
    bruno # Testing HTTP API
    google-chrome # Browser
    cameractrls # Camera Controll App
    _1password-gui # 1Password gui
  ];
}
