{ pkgs, user, ... }:

{
  imports = [
    ./immich.nix
    ./hardware-configuration.nix
    ./nginx.nix
    ./paperless.nix
    ../../modules/git.nix
    ../../modules/home-manager.nix
    ../../modules/immich.nix
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
      vim
    ];
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Disable the firewall
  networking.firewall.enable = false;

  system.stateVersion = "24.11";
}
