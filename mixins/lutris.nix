{ pkgs, user, ... }:

{
  home-manager.users.${user} = {
    home.packages = with pkgs; [
      lutris
      wineWowPackages.stable
    ];
  };
}
