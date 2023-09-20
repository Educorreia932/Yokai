{ config, lib, pkgs, ... }:

with lib;

{
	home-manager.users.eduardo = {
        home.file =  {
            i3 = {
                source = ./config;
                target = ".config/i3";
                recursive = true;
            };
        };
    };
}
