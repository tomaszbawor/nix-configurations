{ pkgs, username, ... }:
{

  nixpkgs.config = {
    allowUnfree = true;
  };

  # Kernel version
  boot.kernelPackages = pkgs.linuxPackages_6_14;

  environment.variables = {
    NIXPKGS_ALLOW_UNFREE = "1";
  };

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
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
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
