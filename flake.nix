{
  description = "My NixOS configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    stylix.url = "github:danth/stylix";

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
      self,
      nixpkgs,
      darwin,
      home-manager,
      homebrew,
      homebrew-bundle,
      homebrew-core,
      homebrew-cask,
      ...
    }@inputs:
    {
      # Provide nixpkgs-fmt for both Linux and Darwin
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixpkgs-fmt;

      darwinConfigurations = {
        work = darwin.lib.darwinSystem rec {
          system = "aarch64-darwin";
          specialArgs = {
            inherit inputs;
            username = "pl8000224";
          };

          modules = [
            home-manager.darwinModules.home-manager
            homebrew.darwinModules.nix-homebrew
            {
              home-manager.extraSpecialArgs = specialArgs;
            }
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
            username = "tomasz";
          };

          modules = [
            home-manager.darwinModules.home-manager
            homebrew.darwinModules.nix-homebrew
            {
              home-manager.extraSpecialArgs = specialArgs;
            }
            ./modules/darwin
            ./hosts/macbookPrivate/darwin.nix
            ./modules/home
            ./hosts/macbookPrivate/home.nix
          ];
        };

      };

      nixosConfigurations = {
        nixLab = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
            username = "tbawor";
            hostName = "nixos-lab";
          };
          modules = [
            ./modules/nixos
            ./hosts/nixosLab/configuration.nix
            ./modules/home
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = specialArgs;
            }
            ./hosts/nixosLab/home.nix
          ];
        };

        nixLabMini = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
            username = "tbawor";
            hostName = "nixos-lab-mini";
          };
          modules = [
            ./modules/nixos
            ./hosts/nixosLab-mini/configuration.nix
            ./modules/home
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = specialArgs;
            }
            ./hosts/nixosLab/home.nix
          ];
        };

        desktop = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
            username = "tomasz";
          };
          modules = [
            ./modules/nixos
            ./hosts/nixosDesktop/configuration.nix
            inputs.stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            ./modules/home
            {
              home-manager.extraSpecialArgs = specialArgs;
            }
            ./hosts/nixosDesktop/home.nix
          ];
        };
      };
    };
}
