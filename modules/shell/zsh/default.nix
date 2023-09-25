{ config, lib, pkgs, ... }:

with lib;

{
	home-manager.users.eduardo = {
        programs.zsh = {
            enable = true;
            oh-my-zsh = {
                enable = true;
                theme = "robbyrussell";
                plugins = [
                    "sudo"
                    "git"
                ];
            };
            initExtra = builtins.readFile ./zshrc;
        };
    };
}
