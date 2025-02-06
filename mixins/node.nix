{ pkgs, user, ... }:

{
  home-manager.users.${user} = {
    home.packages = with pkgs; [ nodejs ];
    home.file.".npmrc".text = ''
      prefix = ''${HOME}/.npm-packages
    '';
  };
}
