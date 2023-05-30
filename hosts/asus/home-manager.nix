{ config, pkgs, lib, ... }:

let
    user = "eduardo";
in
{
    home.username = "${user}";
    home.homeDirectory = "/home/${user}";

    dconf.settings = {
        "org/gnome/desktop/peripherals/touchpad" = {
            "tap-to-click" = true;
            "two-finger-scrolling-enabled" = true;
        };
        "org/gnome/desktop/interface" = {
            "text-scaling-factor" = 1.25;
        };
    };
} // import ../../common/home-manager.nix { config = config; pkgs = pkgs; lib = lib; }