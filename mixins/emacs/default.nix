{ user, pkgs, ... }:

{
  home-manager.users.${user} = {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs-nox;
      extraConfig = builtins.readFile ./config.el;
      extraPackages =
        epkgs: with epkgs; [
          # Evil mode
          evil
          evil-collection
          evil-surround
          evil-commentary
          # Auto-completion
          corfu
        ];
    };
  };

  environment.variables.EDITOR = "emacs";
}
