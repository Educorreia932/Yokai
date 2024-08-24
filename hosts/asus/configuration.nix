{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    settings.trusted-users = [ "root" "eduardo" ];
  };

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable NTFS filesystem
  boot.supportedFilesystems = [ "ntfs" ];

  # Register AppImage files as a binary type
  programs.appimage.binfmt = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Save space by hardlinking identical files in the Nix store
  nix.settings.auto-optimise-store = true;

  # Enable networking
  services.resolved.enable = true;

  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "systemd-resolved";
  systemd.services.systemd-udevd.restartIfChanged = false;
  systemd.services.NetworkManager-wait-online.enable = false;

  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ mozc ];
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable Flatpak
  services.flatpak.enable = true;

  # Configure keymap in X11
  services.xserver = {
    exportConfiguration = true; # link /usr/share/X11/ properly
    xkb = {
      variant = "";
      options = "grp:win_space_toggle";
      layout = "pt,jp";
    };
  };

  # Configure console keymap
  console.keyMap = "pt-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Define a user account.
  users.users.eduardo = {
    isNormalUser = true;
    description = "Eduardo Correia";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "eduardo";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    cachix
    killall
    nix-output-monitor
    haskellPackages.cabal-install
    vscode
    (python3.withPackages (ps: with ps; [
      ipython
      ipykernel
      i3ipc
      jupyter
      matplotlib
      numpy
      pandas
      cvxpy
      opencv4
    ]))
    appimage-run
    config.nur.repos.mikilio.xwaylandvideobridge
  ];

  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # List by default
      zlib
      zstd
      stdenv.cc.cc
      curl
      openssl
      attr
      libssh
      bzip2
      libxml2
      acl
      libsodium
      util-linux
      xz
      systemd

      # Required
      glib
      gtk2
    ];
  };  

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
