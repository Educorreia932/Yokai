{ config, pkgs, ... }:

{
	home.username = "eduardo";
	home.homeDirectory = "/home/eduardo";

	home.stateVersion = "22.11"; 

	# The home.packages option allows you to install Nix packages into your
	# environment.
	home.packages = [
		# # Adds the 'hello' command to your environment. It prints a friendly
		# # "Hello, world!" when run.
		# pkgs.hello

		# # It is sometimes useful to fine-tune packages, for example, by applying
		# # overrides. You can do that directly here, just don't forget the
		# # parentheses. Maybe you want to install Nerd Fonts with a limited number of
		# # fonts?
		# (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

		# # You can also create simple shell scripts directly inside your
		# # configuration. For example, this adds a command 'my-hello' to your
		# # environment:
		# (pkgs.writeShellScriptBin "my-hello" ''
		#   echo "Hello, ${config.home.username}!"
		# '')
	];

	home.file = {
		nvim = {
			source = config.lib.file.mkOutOfStoreSymlink "/home/eduardo/Dotfiles/nvim";
			target = "/home/eduardo/.config/nvim";
		};
	};

	# You can also manage environment variables but you will have to manually
	# source
	#
	#  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
	#
	# or
	#
	#  /etc/profiles/per-user/eduardo/etc/profile.d/hm-session-vars.sh
	#
	# if you don't want to manage your shell through Home Manager.
	home.sessionVariables = {
		# EDITOR = "emacs";
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
