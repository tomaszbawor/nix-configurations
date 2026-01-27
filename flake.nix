{
  description = "My NixOS configuration";

  inputs = {
    # Common
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    krew2nix.url = "github:eigengrau/krew2nix";

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak"; # unstable branch. Use github:gmodena/nix-flatpak/?ref=<tag> to pin releases.darwin

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
      niri,
      noctalia,
      darwin,
      home-manager,
      homebrew,
      nix-flatpak,
      ...
    }@inputs:
    {

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt;

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
            ./hosts/desktop/home.nix
            ./hosts/desktop/configuration.nix
            niri.nixosModules.niri
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
