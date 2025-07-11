{ pkgs, user, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./immich.nix
    ./jellyfin.nix
    ./komga.nix
    ./monit.nix
    ./nginx.nix
    ./paperless.nix
    ./sharkey
    ./slskd.nix
    ./sonata-bot.nix
    ./syncthing.nix
    ./transmission.nix
    ./website.nix
    ../../mixins/direnv.nix
    ../../mixins/git.nix
    ../../mixins/home-manager.nix
    ../../mixins/nix.nix
    ../../mixins/zsh
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable network manager
  networking.networkmanager.enable = true;

  # Set time zone
  time.timeZone = "Europe/Lisbon";

  users.users.${user} = {
    home = "/home/${user}";
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      busybox
    ];
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Disable the firewall
  networking.firewall.enable = false;

  # Agenix
  age.identityPaths = [ "/home/eduardo/.ssh/id_ed25519" ];
  # age.secrets.transmission-password.file = ../../secrets/transmission-password.age;
  age.secrets.sonataBotEnvFile.file = ../../secrets/sonata-bot-env.age;

  system.stateVersion = "24.11";
}
