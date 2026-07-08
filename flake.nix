{
  description = "My personal NixOS configuration";

  inputs = {
    # System packages
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-26.05";
    };

    # User packages and dotfiles
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS WSL
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix Darwin
    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-26.05";
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
      url = "github:danth/stylix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Sure Nix
    sure-nix = {
      url = "github:nSimonFR/sure-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Terranix
    terranix = {
      url = "github:terranix/terranix";
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
      terranix,
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
          system = "aarch64-linux";
          modules = [
            ./modules/sonata-bot.nix
            ./modules/website.nix
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

      apps = forAllSystems (
        system:
        import ./infrastructure {
          inherit system terranix;
          pkgs = nixpkgs.legacyPackages.${system};
          agenix = inputs.agenix.packages.${system}.default;
        }
      );
    };
}
