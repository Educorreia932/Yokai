{ pkgs, user, ... }:

{
  nix = {
    # Save space by hardlinking identical files in the Nix store
    optimise.automatic = true;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    # Parallel builds
    settings.max-jobs = "auto";
    settings.cores = 0;

    # Cachix
    settings.substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    settings.trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59o4W7FBy9D3v5p5N4bxvsSK+4F8j9Y+Y6CqQ="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];

    settings.trusted-users = [
      "root"
      user
    ];
  };

  # Enable the unfree packages
  nixpkgs.config.allowUnfree = true;

  # Formatting
  environment.systemPackages = with pkgs; [
    nixfmt
    nixfmt-tree
  ];
}
