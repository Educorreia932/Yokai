{ config, lib, pkgs, ... }:

{
	home-manager.users.eduardo = {
		programs.pywal = {
			enable = true;    
		};
	};
}
