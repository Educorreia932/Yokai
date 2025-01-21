{
  description = "My personal NixOS configuration";

  inputs = {
    # System packages
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-24.11";
    };

    # Community packages
    nur = {
      url = "github:nix-community/NUR";
    };

    # User packages and dotfiles
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS WSL
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix Darwin
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Flake utilities
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixos-wsl,
      nix-darwin,
      flake-utils,
      ...
    }@inputs:
    let
      inherit (nixpkgs) lib;
      forAllSystems = nixpkgs.lib.genAttrs flake-utils.allSystems;
    in
    {
      formatter = forAllSystems (system: nixpkgs.legacyPackages."${system}".nixpkgs-fmt);

      # Bakeneko
      nixosConfigurations.bakeneko = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-wsl.nixosModules.default
          home-manager.nixosModules.home-manager
          ./hosts/bakeneko/configuration.nix
        ];
        specialArgs = {
          inherit inputs;
          user = "nixos";
        };
      };

      # Kappa
      nixosConfigurations.kappa = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/kappa/configuration.nix ];
        specialArgs = {
          inherit inputs;
          user = "eduardo";
        };
      };

      # Jorogumo
      darwinConfigurations.jorogumo = nix-darwin.lib.darwinSystem {
        modules = [ 
          home-manager.darwinModules.home-manager
          ./hosts/jorogumo/configuration.nix
        ];
        specialArgs = {
          inherit inputs;
          user = "eduardo.correia";
        };
      };

      # Tengu
      nixosConfigurations.tengu = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/tengu/configuration.nix ];
        specialArgs = {
          inherit inputs;
          user = "nixos";
        };
      };
    };
}
