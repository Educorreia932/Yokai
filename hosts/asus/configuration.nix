{ config, pkgs, lib, ... }:

{
	imports =
		[ 
			# Include the results of the hardware scan.
			./hardware-configuration.nix
		];

	services.asusctl.enable = true;

	nix = {
		settings.experimental-features = [ "nix-command" "flakes" ];
		settings.trusted-users = [ "root" "eduardo" ];
	};

	# Bootloader
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	# Enable NTFS filesystem
	boot.supportedFilesystems = [ "ntfs" ];

	networking.hostName = "nixos"; # Define your hostname.

	# Save space by hardlinking identical files in the Nix store
  	nix.settings.auto-optimise-store = true;

	# Enable networking
	networking.networkmanager.enable = true;

	# Set your time zone.
	time.timeZone = "Europe/Lisbon";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_GB.UTF-8";
		LC_IDENTIFICATION = "en_GB.UTF-8";
		LC_MEASUREMENT = "en_GB.UTF-8";
		LC_MONETARY = "en_GB.UTF-8";
		LC_NAME = "en_GB.UTF-8";
		LC_NUMERIC = "en_GB.UTF-8";
		LC_PAPER = "en_GB.UTF-8";
		LC_TELEPHONE = "en_GB.UTF-8";
		LC_TIME = "en_GB.UTF-8";
	};

	i18n.inputMethod = {
		enabled = "ibus";
  		ibus.engines = with pkgs.ibus-engines; [ mozc ];
	};

	# Enable the X11 windowing system.
	services.xserver.enable = true;

	# Enable Flatpak
	services.flatpak.enable = true;

	# Configure keymap in X11
	services.xserver = {
		exportConfiguration = true; # link /usr/share/X11/ properly
		layout = "pt,jp";
		xkbVariant = "";
        xkbOptions = "grp:win_space_toggle";
	};

	# Configure console keymap
	console.keyMap = "pt-latin1";

	# Enable CUPS to print documents.
	services.printing.enable = true;

	# Enable sound with pipewire.
	sound.enable = true;
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};

	# Define a user account.
	users.users.eduardo = {
		isNormalUser = true;
		description = "Eduardo Correia";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [
			spotify
		];
	};

	# Enable automatic login for the user.
	services.xserver.displayManager.autoLogin.enable = true;
	services.xserver.displayManager.autoLogin.user = "eduardo";

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	# Make NUR packages accessible
	nixpkgs.config.packageOverrides = pkgs: {
		nur = import (builtins.fetchTarball { 
			url = "https://github.com/nix-community/NUR/archive/68008bb1e456742f6f4cba73ecd94b0c197e5a61.tar.gz";
			sha256 = "1pspq047p75m9szj31z74z3ac97g7n26c6pqyx7p7jvzl6c4ykc6";
		}) {
			inherit pkgs;
		};
	};

	# List packages installed in system profile
	environment.systemPackages = with pkgs; [
		nodejs
		haskellPackages.cabal-install
		vscode
  		(python3.withPackages (ps: with ps; [ 
			jupyter
			ipython
			ipykernel
			i3ipc 
		]))
		nur.repos.xeals.samrewritten
		nur.repos.mikilio.xwaylandvideobridge
		nur.repos.willpower3309.ani-cli
	];

	hardware.opengl.enable = true;
	hardware.opengl.driSupport32Bit = true;

	programs = {
		nix-ld.enable = true;
		steam = {
			enable = true;
			remotePlay.openFirewall = true;      # Open ports in the firewall for Steam Remote Play
			dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
		};
	};

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "23.05"; # Did you read the comment?
}
