{ ... }:

# Baseline configuration shared by every host
{
  imports = [
    ../mixins/direnv.nix
    ../mixins/emacs
    ../mixins/home-manager.nix
    ../mixins/nix.nix
    ../mixins/style.nix
    ../mixins/zsh.nix
  ];
}
