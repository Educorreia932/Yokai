{ pkgs, ... }:

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
      "eduardo"
      "nixos"
    ];
  };

  # Enable the unfree packages
  nixpkgs.config.allowUnfree = true;

  # Formatting
  environment.systemPackages = [ pkgs.nixfmt-rfc-style ];
}
