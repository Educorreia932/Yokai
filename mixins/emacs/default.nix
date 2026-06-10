{
  user,
  pkgs,
  config,
  lib,
  ...
}:

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

    stylix.targets.emacs.enable = lib.mkIf config.stylix.enable true;
  };

  environment.variables.EDITOR = "emacs";
}
