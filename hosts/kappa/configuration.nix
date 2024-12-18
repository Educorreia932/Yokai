{ inputs, pkgs, user, ... }:

{
  imports = [
    inputs.nur.nixosModules.nur
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    ../../modules/audio.nix
    ../../modules/direnv.nix
    ../../modules/fonts
    ../../modules/git.nix
    ../../modules/gnome.nix
    .../../modules/immich.nix
    ../../modules/nix.nix
    ../../modules/nvidia.nix
    ../../modules/steam.nix
    ../../modules/zsh
  ];

  # Configure booting
  boot = {
    loader = {
      # Use the systemd-boot EFI boot loader
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # Enable NTFS filesystem
    supportedFilesystems = [ "ntfs" ];
  };

  # Register AppImage files as a binary type
  programs.appimage.binfmt = true;

  networking.hostName = "nixos"; # Define your hostname.

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
  users.users.${user} = {
    isNormalUser = true;
    description = "Eduardo Correia";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = user;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [ "electron-25.9.0" ];

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    cachix
    killall
    nix-output-monitor
    haskellPackages.cabal-install
    vscode
    xorg.xbacklight
    brightnessctl
    (python3.withPackages (
      ps: with ps; [
        ipython
        ipykernel
        i3ipc
        jupyter
        matplotlib
        numpy
        pandas
        cvxpy
        opencv4
      ]
    ))
    appimage-run
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

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

  # Asus services
  services = {
    asusd.enable = true;
    asusd.enableUserService = true;

    udev.extraHwdb = ''
      evdev:name:*:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
      KEYBOARD_KEY_ff31007c=f20    # Fixes mic mute button
    '';
  };

  services.supergfxd.enable = true;

  services.xserver.dpi = 188;

  system.stateVersion = "24.05";
}
