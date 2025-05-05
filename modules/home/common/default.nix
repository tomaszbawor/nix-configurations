{ lib, ... }:
{
  # Common home-manager modules for all systems (NixOS and Darwin)
  imports = [
    # Utilities and general tools
    ./amfora.nix
    ./bat.nix
    ./btop.nix
    ./emoji.nix
    ./eza.nix
    ./fish.nix
    ./gh.nix
    ./ghostty.nix
    ./gtk.nix
    ./ides.nix
    ./kubernetes.nix
    ./nvim.nix
    ./qt.nix
    ./starship.nix
    ./utils.nix
    ./zoxide.nix
  ];
}

