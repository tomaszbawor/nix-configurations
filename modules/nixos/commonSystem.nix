{ pkgs, username, ... }: {

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs.config = { allowUnfree = true; };

  # Kernel version
  boot.kernelPackages = pkgs.linuxPackages_6_14;

  environment.variables = { NIXPKGS_ALLOW_UNFREE = "1"; };
  # Select internationalisation properties.
  i18n.defaultLocale = "pl_PL.UTF-8";

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
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
  };

  services.xserver.xkb = {
    # Keyboard layout
    layout = "pl";
    variant = "";
  };

  users.users.${username} = {
    isNormalUser = true;
    description = "Tomasz Bawor";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;

    packages = with pkgs; [ fish fd ];
  };

  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-24.11";
  };

  programs = {
    fish.enable = true;
    nix-ld.enable = true; # Enable nix-ld
  };

}
