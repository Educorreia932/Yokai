{ config, pkgs, lib, ... }:

{
	home.stateVersion = "22.11"; 
	home.packages = [

	];

	home.file =  {
		alacritty = {
			source = ./config/alacritty;
			target = ".config/alacritty";
			recursive = true;
		};
		nvim = {
			source = ./config/nvim;
			target = ".config/nvim";
			recursive = true;
		};
	};

	home.sessionVariables = {
		
	};

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;

	programs = {
		alacritty = {
			enable = true;
		};
		git = {
			enable = true;
			userName = "Educorreia932";
			userEmail = "skelozard1@gmail.com";
		};
		neovim = {
			enable = true;    
			defaultEditor = true;
		};
		zsh = {
			enable = true;
			oh-my-zsh = {
				enable = true;
				theme = "robbyrussell";
				plugins = [
					"sudo"
					"git"
				];
			};
			initExtra = builtins.readFile ./config/zsh/zshrc;
		};
	};
}
