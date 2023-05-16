{ config, pkgs, lib, ... }:

let
	applyFunction = (name: value: {
		source = config.lib.file.mkOutOfStoreSymlink value.source;
		target = value.target;
	});
in
rec {
	home.username = "eduardo";
	home.homeDirectory = "/home/eduardo";

	home.stateVersion = "22.11"; 

	home.packages = [

	];

	home.file = lib.mapAttrs applyFunction {
		alacritty = {
			source = "${home.homeDirectory}/Dotfiles/alacritty";
			target = "${home.homeDirectory}/.config/alacritty";
		};
		nvim = {
			source = "${home.homeDirectory}/Dotfiles/nvim";
			target = "${home.homeDirectory}/.config/nvim";
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
			initExtra = builtins.readFile "${home.homeDirectory}/Dotfiles/zshrc";
		};
	};
}
