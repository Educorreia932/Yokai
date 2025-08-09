{ inputs, outputs }:
{
  host,
  user,
  modules ? [ ],
}:
inputs.nix-darwin.lib.darwinSystem {
  modules = [
    ../hosts/${host}/configuration.nix
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
