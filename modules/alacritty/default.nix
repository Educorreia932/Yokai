{ config, lib, pkgs, ... }:

{
	home-manager.users.eduardo = {
		home.file =  {
			alacritty = {
				source = ./config;
				target = ".config/alacritty";
				recursive = true;
			};
		};

		programs.alacritty = {
			enable = true;
		};
	};
}
