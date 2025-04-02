{ user, ... }:

{
  home-manager.users.${user} = {
    programs.emacs = {
      enable = true;
      extraConfig = builtins.readFile ./config.el;
      extraPackages = epkgs: with epkgs; [
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
}
