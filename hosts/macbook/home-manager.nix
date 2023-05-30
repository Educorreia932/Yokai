{ config, pkgs, lib, ... }:

let
    user = "eduardo";
in
{
	imports = [
    	<home-manager/nix-darwin>
	];

	users.users.${user} = {
		name = "${user}";
		home = "/Users/${user}";
		isHidden = false;
		shell = pkgs.zsh;
	};

	home-manager = {
		users.${user} = {
			home.username = "${user}";
    		home.homeDirectory = "/Users/${user}";
		} // import ../../common/home-manager.nix { config = config; pkgs = pkgs; lib = lib; };
	};

	services.nix-daemon.enable = true;
}