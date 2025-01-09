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
