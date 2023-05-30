{ config, pkgs, lib, ... }:

let
    user = "eduardo";
in
{
    home.username = "${user}";
    home.homeDirectory = "/home/${user}";
} // import ../../common/home-manager.nix { config = config; pkgs = pkgs; lib = lib; }