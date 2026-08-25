{ pkgs, user, ... }:

{
  nix = {
    # Save space by hardlinking identical files in the Nix store
    optimise.automatic = true;
    settings.experimental-features = [
      "nix-command"
      "flakes"
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
