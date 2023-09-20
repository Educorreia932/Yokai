{ config, pkgs, lib, ... }:

with lib;

{
    home.stateVersion = "22.11"; 

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;

    home.username = "eduardo";
    home.homeDirectory = "/home/eduardo";

    home.packages = with pkgs; [
        google-chrome
        flameshot
        discord
        gitkraken
        obsidian
        jetbrains.webstorm
        jetbrains.idea-ultimate
    ];

    programs = {
        rofi = {
            enable = true;
        };
        vscode = {
            enable = true;
        };
    };

    dconf.settings = {
        "org/gnome/desktop/peripherals/touchpad" = {
            "tap-to-click" = true;
            "two-finger-scrolling-enabled" = true;
        };
        "org/gnome/desktop/interface" = {
            "text-scaling-factor" = 1.00;
        };
    };
}
    

