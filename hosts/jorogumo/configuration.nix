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

  nix.settings.trusted-users = [
    "root"
    "@admin"
    user
  ];

  nix.linux-builder = {
    enable = true;
    config = {
      virtualisation.darwin-builder.diskSize = 51200; # 50 GB (MiB)
      virtualisation.darwin-builder.memorySize = 8192; # 8 GB (MiB)
    };
  };

  users.users.${user} = {
    home = "/Users/${user}";
  };

  system.primaryUser = user;

  # Enable sudo Touch ID authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  home-manager.users.${user} = {
    home = {
      # Installed packages
      packages = with pkgs; [
        colima
        docker
        just
        nil
      ];
      homeDirectory = "/Users/${user}";
    };

    programs.git = {
      settings = {
        credential.helper = "osxkeychain";
      };
      includes = [
        {
          condition = "gitdir:~/Documents/Trumpf/**";
          contents = {
            user = {
              name = "Eduardo-Correia-external";
              email = "eduardo.correia.external@trumpf.com";
              signingkey = "~/.ssh/trumpf";
            };
          };
        }
      ];
    };
  };

  system.stateVersion = 5;
}
