{ pkgs, user, ... }:

{
  home-manager.users.${user} = {
    programs.emacs = {
      enable = true;
      defaultEditor = true;
      extraConfig = builtins.readFile ./config.el;
    };
    home.packages = with pkgs; [
      nil # Nix LSP
    ];
  };
}
