{ config, pkgs, lib, ... }:

with lib;

let
    user = "eduardo";

    commonConfiguration = import ../../common/home-manager.nix { config = config; pkgs = pkgs; lib = lib; };

    hostConfiguration = {
        home.username = "${user}";
        home.homeDirectory = "/home/${user}";

        home.file =  {
            i3 = {
                source = ./config/i3;
                target = ".config/i3";
                recursive = true;
            };
	    };

        home.packages = with pkgs; [
            google-chrome
            flameshot
            discord
            gitkraken
            obsidian
            jetbrains.webstorm
            jetbrains.idea-ultimate
        ];

        services = {
            polybar = {
                enable = true;
                package = pkgs.polybar.override {
                    i3Support = true;
                    alsaSupport = true;
                    iwSupport = true;
                    githubSupport = true;
                };
                config = ./config/polybar/bottom/config.ini;
                script = "polybar &";
            };
        };

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
    };

    finalConfiguration = recursiveUpdate commonConfiguration hostConfiguration;
in
    finalConfiguration
