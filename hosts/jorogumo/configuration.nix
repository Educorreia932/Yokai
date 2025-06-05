{
  pkgs,
  user,
  ...
}:

{
  imports = [
    ./hunter
    ../../mixins/direnv.nix
    ../../mixins/emacs
    ../../mixins/home-manager.nix
    ../../mixins/git.nix
    ../../mixins/nix.nix
    ../../mixins/style.nix
    ../../mixins/zsh
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.${user} = {
    home = "/Users/${user}";
  };

  # Enable sudo Touch ID authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  home-manager.users.${user} = {
    home = {
      # Installed packages
      packages = with pkgs; [
        _1password-cli
        git-crypt
        nil
      ];
      homeDirectory = "/Users/${user}";
    };
  };

  system.stateVersion = 5;
}
