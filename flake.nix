{
	description = "Educorreia932's Dotfiles";

	inputs = {
		nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
		home-manager = {
			url = github:nix-community/home-manager;
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs:
	{
		nixosConfigurations = {
			eduardo = inputs.nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
					./configuration.nix
					./hardware-configuration.nix
					inputs.home-manager.nixosModules.home-manager {
						home-manager = {
							useUserPackages = true;
							useGlobalPkgs = true;
							extraSpecialArgs = {inherit inputs;};
							users.eduardo = ./home/home.nix;
						};
					}
				];
				specialArgs = { inherit inputs; };
			};
		};
	};
}