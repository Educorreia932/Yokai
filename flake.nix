{
  description = "My personal NixOS configuration";

  nixConfig = {
    extra-substituters = [ "https://gooru.cachix.org" ];
    extra-trusted-public-keys = [
      "gooru.cachix.org-1:I2qP1U67fpxRdT1y4pmb0sj/X4Xs846Yi4/P481+SnM="
    ];
  };

  inputs = {
    # System packages
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    # User packages and dotfiles
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS WSL
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix Darwin
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
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
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Gooru
    gooru = {
      url = "github:fiso64/gooru/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Sonata
    sonata = {
      url = "github:Educorreia932/Sonata";
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
      gooru,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      forAllSystems = inputs.nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "x86_64-linux"
        "aarch64-darwin"
      ];

      mkNixOS = import ./lib/mk-nixos.nix { inherit inputs outputs; };
      mkDarwin = import ./lib/mk-darwin.nix { inherit inputs outputs; };
      mkHost =
        builder: host: cfg:
        builder (cfg // { inherit host; });
    in
    {
      # Host configurations
      nixosConfigurations = nixpkgs.lib.mapAttrs (mkHost mkNixOS) {
        bakeneko = {
          user = "nixos";
          system = "x86_64-linux";
          modules = [ nixos-wsl.nixosModules.default ];
        };

        tengu = {
          user = "eduardo";
          system = "x86_64-linux";
          modules = [
            ./modules/sonata-bot.nix
            ./modules/slink.nix
            ./modules/website.nix
            gooru.nixosModules.default
          ];
        };
      };

      darwinConfigurations = nixpkgs.lib.mapAttrs (mkHost mkDarwin) {
        jorogumo = {
          user = "eduardo.correia";
          system = "aarch64-darwin";
          modules = [ ];
        };
      };

      # Custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };

      # Custom packages
      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

      # Formatter for .nix files
      formatter = forAllSystems (system: nixpkgs.legacyPackages."${system}".nixpkgs-fmt);
    };
}
