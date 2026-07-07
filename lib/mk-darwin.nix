{ inputs, outputs }:
{
  system,
  host,
  user,
  modules ? [ ],
}:
inputs.nix-darwin.lib.darwinSystem {
  modules = [
    ../hosts/${host}/configuration.nix
    inputs.agenix.darwinModules.default
    {
      environment.systemPackages = [ inputs.agenix.packages.${system}.default ];
    }
    inputs.home-manager.darwinModules.home-manager
    inputs.stylix.darwinModules.stylix
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
