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
      packages =
        with pkgs;
        let
          gdk = (
            google-cloud-sdk.withExtraComponents (
              with pkgs.google-cloud-sdk.components;
              [
                gke-gcloud-auth-plugin
              ]
            )
          );
        in
        [
        _1password-cli
        crowdin-cli
          gdk
        nil
          nodejs_18
      ];
      homeDirectory = "/Users/${user}";
    };
  };

  system.stateVersion = 5;
}
