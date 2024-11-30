{ pkgs, ... }:

{
  # Enable GNOME Desktop Environment
  services.xserver = {
    enable = true;

    desktopManager = {
      gnome.enable = true;
    };

    displayManager = {
      gdm.enable = true;
    };
  };

  # Disable GNOME's default applications
  environment.gnome.excludePackages = with pkgs; [
    cheese # Photo booth
    epiphany # Web browser
    geary # Email client
    simple-scan # Document scanner
    gnome-maps # Maps
    gnome-tour # Tour
    gnome-console # Console
  ];

  # Systray Icons
  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnome-tweaks
  ];

  services.udev.packages = with pkgs; [ gnome-settings-daemon ];

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # dconf settings
  home-manager.users.eduardo = {
    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/peripherals/touchpad" = {
          "tap-to-click" = true;
          "two-finger-scrolling-enabled" = true;
        };
        "org/gnome/desktop/interface" = {
          "text-scaling-factor" = 1.00;
        };
        "org.gnome.gnome-screenshot" = {
          "auto-save-directory" = "file:///home/eduardo/Pictures/Screenshots";
        };
        "org/gnome/shell" = {
          disable-user-extensions = false; # Enable user extensions
          "enabled-extensions" = [
            "appindicatorsupport@rgcjonas.gmail.com"
            "blur-my-shell@aunetx"
          ];
        };
      };
    };
  };
}
