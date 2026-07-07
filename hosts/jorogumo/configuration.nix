{
  pkgs,
  user,
  ...
}:

{
  imports = [
    ../../profiles/workstation.nix
    ../../mixins/k9s.nix
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
        just
        nil
      ];
      homeDirectory = "/Users/${user}";
    };
  };

  system.stateVersion = 5;
}
