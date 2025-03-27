{
  description = "My NixOS configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    krew2nix = {
      url = "github:eigengrau/krew2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    flatpaks.url = "github:GermanBread/declarative-flatpak/stable-v3";

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
    { nixpkgs
    , darwin
    , home-manager
    , nixos-cosmic
    , homebrew
    , flatpaks
    , plasma-manager
    , ...
    }@inputs: {
      # Provide nixpkgs-fmt for both Linux and Darwin
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      formatter.aarch64-darwin =
        nixpkgs.legacyPackages.aarch64-darwin.nixpkgs-fmt;

      darwinConfigurations = {
        work = darwin.lib.darwinSystem rec {
          system = "aarch64-darwin";
          specialArgs = {
            inherit inputs;
            inherit system;
            username = "pl8000224";
          };

          modules = [
            home-manager.darwinModules.home-manager
            plasma-manager.homeManagerModules.plasma-manager
            homebrew.darwinModules.nix-homebrew
            { home-manager.extraSpecialArgs = specialArgs; }
            ./modules/darwin
            ./hosts/macbookWork/darwin.nix
            ./modules/home
            ./hosts/macbookWork/home.nix
          ];
        };

        private = darwin.lib.darwinSystem rec {
          system = "aarch64-darwin";
          specialArgs = {
            inherit inputs;
            inherit system;
            username = "tomasz";
          };

          modules = [
            home-manager.darwinModules.home-manager
            homebrew.darwinModules.nix-homebrew
            { home-manager.extraSpecialArgs = specialArgs; }
            ./modules/darwin
            ./hosts/macbookPrivate/darwin.nix
            ./modules/home
            ./hosts/macbookPrivate/home.nix
          ];
        };

      };

      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
            inherit system;
            username = "tomasz";
          };
          modules = [
            home-manager.nixosModules.home-manager
            flatpaks.nixosModules.declarative-flatpak
            nixos-cosmic.nixosModules.default
            { home-manager.extraSpecialArgs = specialArgs; }
            ./modules/nixos
            ./hosts/desktop/configuration.nix
            ./hosts/desktop/home.nix
            ./modules/home
          ];
        };
      };
    };
}
