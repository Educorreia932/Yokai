{ config, lib, pkgs, ... }:

{
    # Enable GNOME Desktop Environment
	services.xserver = {
		desktopManager = {
			gnome.enable = true;
		};
	
		displayManager = {
			gdm.enable = true;
		};
	};

 	# Disable GNOME's default applications
	environment.gnome.excludePackages = with pkgs.gnome; [
		cheese       # Photo booth
		epiphany     # Web browser
		geary        # Email client
		simple-scan  # Document scanner
		gnome-maps  
	];

    # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
	systemd.services."getty@tty1".enable = false;
	systemd.services."autovt@tty1".enable = false;
	
	home-manager.users.eduardo = {
		dconf.settings = {
			"org/gnome/desktop/peripherals/touchpad" = {
				"tap-to-click" = true;
				"two-finger-scrolling-enabled" = true;
			};
			"org/gnome/desktop/interface" = {
				"text-scaling-factor" = 1.00;
			};
		};
	};
}
