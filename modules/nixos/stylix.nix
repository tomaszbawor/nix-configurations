{ pkgs
, username
, ...
}:
{

  stylix = {
    enable = true;
    image = ./../../others/wallpapers/wallpaper1.jpg;
    base16Scheme = {
      base00 = "2b2b2b"; # background;
      base01 = "323232"; # line cursor
      base02 = "323232"; # statusline
      base03 = "606366"; # line numbers
      base04 = "a4a3a3"; # selected line number
      base05 = "a9b7c6"; # foreground
      base06 = "ffc66d"; # function bright yellow
      base07 = "ffffff";
      base08 = "4eade5"; # cyan
      base09 = "689757"; # blue
      base0A = "bbb529"; # yellow
      base0B = "6a8759"; # string green
      base0C = "629755"; # comment green
      base0D = "9876aa"; # purple
      base0E = "cc7832"; # orange
      base0F = "808080"; # gray
    };
    polarity = "dark";
    opacity.terminal = 0.8;
    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Modern-Ice";
    cursor.size = 24;
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.iosevka-term-slab;
        name = "Iosevka";
      };
      sansSerif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      serif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      sizes = {
        applications = 12;
        terminal = 12;
        desktop = 11;
        popups = 12;
      };
    };
  };
  # TODO:  Clean this !!!!
  environment.systemPackages = with pkgs; [
    vim
    wget
    killall
    docker-compose
    eza
    git
    cmatrix
    lolcat
    htop
    brave
    libvirt
    lxqt.lxqt-policykit
    lm_sensors
    unzip
    unrar
    libnotify
    v4l-utils
    ydotool
    duf
    ncdu
    pciutils
    ffmpeg
    socat
    cowsay
    ripgrep
    lshw
    bat
    pkg-config
    meson
    hyprpicker
    ninja
    brightnessctl
    virt-viewer
    swappy
    appimage-run
    networkmanagerapplet
    yad
    inxi
    playerctl
    nh
    nixfmt-rfc-style
    discord
    libvirt
    swww
    grim
    slurp
    file-roller
    swaynotificationcenter
    imv
    mpv
    gimp
    tree
    spotify
    neovide
    greetd.tuigreet
  ];

  fonts = {
    packages = with pkgs; [
      noto-fonts-emoji
      noto-fonts-cjk-sans
      font-awesome
      symbola
      material-icons
    ];
  };

  # Extra Portal Configuration
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal
    ];
  };

  home-manager = {
    users.${username} =
      { ...
      }:
      {

        stylix.targets.waybar.enable = false;
        stylix.targets.rofi.enable = false;
        stylix.targets.hyprland.enable = false;
        stylix.targets.nixvim.enable = false;

        home.file."Pictures/Wallpapers" = {
          source = ../../others/wallpapers;
          recursive = true;
        };
      };
  };

}
