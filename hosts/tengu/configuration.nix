{
  pkgs,
  user,
  outputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./services
    ../../profiles/common.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable network manager
  networking.networkmanager.enable = true;

  # Set time zone
  time.timeZone = "Europe/Lisbon";

  nixpkgs.overlays = [
    outputs.overlays.additions
  ];

  users.users.${user} = {
    home = "/home/${user}";
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "sonata-bot"
      "media"
    ];
    packages = with pkgs; [
      coreutils
      litecli
      systemctl-tui
    ];
  };

  security.sudo.extraRules = [
    {
      groups = [ "wheel" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Disable the firewall
  networking.firewall.enable = false;

  # Agenix
  age = {
    identityPaths = [ "/home/eduardo/.ssh/id_ed25519" ];
    secrets = {
      homepageDashboardEnv.file = ../../secrets/homepage-dashboard-env.age;
      rommEnv.file = ../../secrets/romm-env.age;
      slskdEnv.file = ../../secrets/slskd-env.age;
      sonataBotEnvFile.file = ../../secrets/sonata-bot-env.age;
      resticPassword.file = ../../secrets/restic-password.age;
    };
  };

  system.stateVersion = "26.05";
}
