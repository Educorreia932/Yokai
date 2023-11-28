{ pkgs, lib, ... }:

with lib;

{
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.username = "eduardo";
  home.homeDirectory = "/home/eduardo";

  home.packages = with pkgs; [
    google-chrome
    flameshot
    discord
    gimp
    gitkraken
    jetbrains.webstorm
    jetbrains.idea-ultimate
    neofetch
    nixpkgs-fmt
    nil
    qbittorrent
    spotify
    zoom-us
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
