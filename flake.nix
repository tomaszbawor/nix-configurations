{
  description = "My NixOS configuration";

  inputs = {
    # Common
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    krew2nix.url = "github:eigengrau/krew2nix";

    # Nixos Specific
    hyprland.url = "github:hyprwm/Hyprland";

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak"; # unstable branch. Use github:gmodena/nix-flatpak/?ref=<tag> to pin releases.
    stylix.url = "github:danth/stylix";
    # Macos Specific
    homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      darwin,
      home-manager,
      homebrew,
      hyprland,
      stylix,
      nix-flatpak,
      ...
    }@inputs:
    {

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-rfc-style;

      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs system;
            username = "tomasz";
          };

          modules = [
            home-manager.nixosModules.home-manager
            { home-manager.extraSpecialArgs = specialArgs; }
            stylix.nixosModules.stylix
            ./hosts/desktop/home.nix
            ./hosts/desktop/configuration.nix
            ./modules/nixos
            ./modules/home
            nix-flatpak.nixosModules.nix-flatpak
          ];
        };
      };

      darwinConfigurations = {
        work = darwin.lib.darwinSystem rec {
          system = "aarch64-darwin";
          specialArgs = {
            inherit inputs system;
            username = "pl8000224";
          };

          modules = [
            { home-manager.extraSpecialArgs = specialArgs; }
            home-manager.darwinModules.home-manager
            homebrew.darwinModules.nix-homebrew
            ./hosts/macbookWork/home.nix
            ./hosts/macbookWork/darwin.nix
            ./modules/darwin
            ./modules/home
          ];
        };

        private = darwin.lib.darwinSystem rec {
          system = "aarch64-darwin";
          specialArgs = {
            inherit inputs system;
            username = "tomasz";
          };

          modules = [
            { home-manager.extraSpecialArgs = specialArgs; }
            home-manager.darwinModules.home-manager
            homebrew.darwinModules.nix-homebrew
            ./hosts/macbookPrivate/home.nix
            ./hosts/macbookPrivate/darwin.nix
            ./modules/darwin
            ./modules/home
          ];
        };
      };

    };
}
