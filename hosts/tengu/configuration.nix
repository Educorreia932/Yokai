{ pkgs, user, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./immich.nix
    ./monit.nix
    ./nginx.nix
    ./paperless.nix
    ./sharkey.nix
    ../../modules/git.nix
    ../../modules/home-manager.nix
    ../../modules/nix.nix
    ../../modules/zsh
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
      nodejs_18
      vim
      (yarn.override {
        nodejs = null;
      })
    ];
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Disable the firewall
  networking.firewall.enable = false;

  system.stateVersion = "24.11";
}
