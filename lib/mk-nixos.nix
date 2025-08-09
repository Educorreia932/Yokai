{ inputs, outputs }:
{
  system,
  host,
  user,
  modules ? [ ],
}:
inputs.nixpkgs.lib.nixosSystem {
  inherit system;
  modules = [
    ../hosts/${host}/configuration.nix
    inputs.agenix.nixosModules.default
    {
      environment.systemPackages = [ inputs.agenix.packages.${system}.default ];
    }
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
  ]
  ++ modules;
  specialArgs = {
    inherit
      inputs
      outputs
      host
      user
      ;
  };
}
