{ pkgs, user, ... }:

{
  imports = [
    ../../modules/direnv.nix
    ../../modules/home-manager.nix
    ../../modules/git.nix
    ../../modules/nix.nix
    ../../modules/zsh
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.${user} = {
    home = "/Users/${user}";
  };

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
        crowdin-cli
        nil
      ];
      homeDirectory = "/Users/${user}";
    };
  };

  system.stateVersion = 5;
}
