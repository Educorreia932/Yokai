{ pkgs, lib, ... }:

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
    jetbrains.webstorm
    jetbrains.idea-ultimate
    neofetch
    nil
    obsidian
    spotify
  ];

  programs = {
    rofi = {
      enable = true;
    };
    vscode = {
      enable = true;
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
