{ inputs, ... }:

inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    inputs.nur.nixosModules.nur
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
        extraSpecialArgs = { inherit inputs; };
        users.eduardo = import ./home-manager.nix;
      };
    }
    ./configuration.nix
    ./hardware-configuration.nix
    ../../modules
  ];
}
