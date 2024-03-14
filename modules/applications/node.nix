{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nodejs
  ];

  home-manager.users.eduardo = {
    home.file.".npmrc".text = ''
      prefix = ''${HOME}/.npm-packages
    '';
  };
}
