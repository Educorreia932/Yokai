{ pkgs, user, ... }:

{
  home-manager.users.${user}.home = {
    packages = with pkgs; [
      nodejs
      pnpm
    ];
    file.".npmrc".text = ''

      prefix = ''${HOME}/.npm-packages
    '';
  };
}
