{
	description = "Educorreia932's Dotfiles";

	inputs = {
		nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
		home-manager = {
			url = github:nix-community/home-manager;
			inputs.nixpkgs.follows = "nixpkgs";
		};
        darwin = {
            url = github:LnL7/nix-darwin/master;
            inputs.nixpkgs.follows = "nixpkgs";
        };
	};

	outputs = { self, darwin, home-manager, nixpkgs, ... }@inputs:
	{
		nixosConfigurations = {
			asus = inputs.nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
					./hosts/asus/configuration.nix
					./hosts/asus/hardware-configuration.nix
					inputs.home-manager.nixosModules.home-manager {
						home-manager = {
							useUserPackages = true;
							useGlobalPkgs = true;
							extraSpecialArgs = {inherit inputs;};
							users.eduardo = import ./hosts/asus/home-manager.nix;
						};
					}
				];
				specialArgs = { inherit inputs; };
			};
		};
        darwinConfigurations = {
            macbook = darwin.lib.darwinSystem {
                system = "aarch64-darwin";
                modules = [
                    ./hosts/macbook
                ];
                inputs = { inherit darwin home-manager nixpkgs; };
            };
        };
	};
}