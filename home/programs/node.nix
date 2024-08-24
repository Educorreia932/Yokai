{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs
  ];
  home.file.".npmrc".text = ''
    prefix = ''${HOME}/.npm-packages
  '';
}
