{
  description = "Educorreia932's Dotfiles";

  inputs = {
    # System packages
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };

    # Community packages
    nur = { url = "github:nix-community/NUR"; };

    # User packages and dotfiles
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, home-manager, nixpkgs, nur, ... }@inputs:
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;
      nixosConfigurations = {
        asus = import ./hosts/asus { inherit inputs; };
      };
    };
}
