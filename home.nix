{ config, pkgs, lib, ... }:

let
	applyFunction = (name: value: {
		source = config.lib.file.mkOutOfStoreSymlink value.source;
		target = value.target;
	});
in
{
	home.username = "eduardo";
	home.homeDirectory = "/home/eduardo";

	home.stateVersion = "22.11"; 

	home.packages = [

	];

	home.file = lib.mapAttrs applyFunction {
		alacritty = {
			source = "/home/eduardo/Dotfiles/alacritty";
			target = "/home/eduardo/.config/alacritty";
		};
		nvim = {
			source = "/home/eduardo/Dotfiles/nvim";
			target = "/home/eduardo/.config/nvim";
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
			initExtra = ''
				# Load Wal colors
				cat /home/eduardo/.cache/wal/sequences

				# Remove duplicate commands from history
				setopt hist_ignore_all_dups
			'';
		};
	};
}
