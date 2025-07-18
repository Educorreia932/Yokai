{
  description = "My personal NixOS configuration";

  inputs = {
    # System packages
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-25.05";
    };

    # User packages and dotfiles
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS WSL
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix Darwin
    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Flake utilities
    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    # Secret management
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Styling
    stylix = {
      url = "github:danth/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixos-wsl,
      nix-darwin,
      flake-utils,
      agenix,
      stylix,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      forAllSystems = inputs.nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      mkNixOS =
        host: user: system: modules:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = modules ++ [
            ./hosts/${host}/configuration.nix
            agenix.nixosModules.default
            {
              environment.systemPackages = [ agenix.packages.${system}.default ];
            }
            home-manager.nixosModules.home-manager
            stylix.nixosModules.stylix
            ./modules/sonata-bot.nix
            ./modules/website.nix
          ];
          specialArgs = {
            inherit
              inputs
              outputs
              host
              user
              ;
          };
        };

      mkDarwin =
        host: user: modules:
        nix-darwin.lib.darwinSystem {
          modules = modules ++ [
            ./hosts/${host}/configuration.nix
            home-manager.darwinModules.home-manager
            stylix.darwinModules.stylix
          ];
          specialArgs = {
            inherit
              inputs
              outputs
              host
              user
              ;
          };
        };
    in
    {
      # Bakeneko
      nixosConfigurations.bakeneko = mkNixOS "bakeneko" "nixos" "x86_64-linux" [
        nixos-wsl.nixosModules.default
      ];

      # Jorogumo
      darwinConfigurations.jorogumo = mkDarwin "jorogumo" "eduardo.correia" [
        agenix.nixosModules.default
      ];

      # Tengu
      nixosConfigurations.tengu = mkNixOS "tengu" "eduardo" "aarch64-linux" [ ];

      # Custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };

      # Custom packages; acessible via 'nix build', 'nix shell', etc
      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

      # Formatter for .nix files, available via 'nix fmt'
      formatter = forAllSystems (system: nixpkgs.legacyPackages."${system}".nixpkgs-fmt);
    };
}
