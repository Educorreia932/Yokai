{ config, pkgs, lib, ... }:

let
    user = "eduardo";
in
{
    home.username = "${user}";
    home.homeDirectory = "/home/${user}";
	home.stateVersion = "22.11"; 
    

}