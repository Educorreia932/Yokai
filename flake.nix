{
  description = "My personal NixOS configuration";

  inputs = {
    # System packages
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-24.05"; };

    # Community packages
    nur = { url = "github:nix-community/NUR"; };

    # User packages and dotfiles
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, ... }@inputs:
    let
      user = "eduardo";
      inherit (nixpkgs) lib;
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;
      nixosConfigurations.asus = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/asus ];
        specialArgs = { inherit inputs user; };
      };
    };
}
