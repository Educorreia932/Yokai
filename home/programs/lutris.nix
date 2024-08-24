{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lutris
    wineWowPackages.stable
  ];
}
