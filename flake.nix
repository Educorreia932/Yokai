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
  };

  outputs =
    {
      nixpkgs,
      nixos-wsl,
      home-manager,
      ...
    }@inputs:
    let
      inherit (nixpkgs) lib;
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;

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
    };
}
