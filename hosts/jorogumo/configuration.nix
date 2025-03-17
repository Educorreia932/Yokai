{ pkgs, user, ... }:

{
  imports = [
    ../../mixins/direnv.nix
    ../../mixins/home-manager.nix
    ../../mixins/git.nix
    ../../mixins/nix.nix
    ../../mixins/zsh
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.${user} = {
    home = "/Users/${user}";
  };

  # Enable sudo Touch ID authentication
  security.pam.enableSudoTouchIdAuth = true;

  home-manager.users.${user} = {
    # Git configuration
    programs.git = {
      userName = "Eduardo Correia";
      userEmail = "eduardo.correia@freiheit.com";
    };
    home = {
      # Installed packages
      packages = with pkgs; [
        _1password-cli
        nil
      ];
      homeDirectory = "/Users/${user}";
    };
  };

  system.stateVersion = 5;
}
