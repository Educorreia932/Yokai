{ config, pkgs, lib, ... }:

with lib;

let
    user = "eduardo";
in
{
    home.username = "${user}";
    home.homeDirectory = "/home/${user}";

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

        dconf.settings = {
            "org/gnome/desktop/peripherals/touchpad" = {
                "tap-to-click" = true;
                "two-finger-scrolling-enabled" = true;
            };
            "org/gnome/desktop/interface" = {
                "text-scaling-factor" = 1.00;
            };
        };

        programs = {
            pywal = {
                enable = true;
            };
            vscode = {
                enable = true;
            };
        };
    };

    finalConfiguration = recursiveUpdate commonConfiguration hostConfiguration;
in
    finalConfiguration
