{ pkgs, ... }:

{
  home-manager.users.eduardo = {
    home.packages = with pkgs; [
      obsidian
    ];
  };
}
