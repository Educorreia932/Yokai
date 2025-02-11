{
  pkgs,
  user,
  outputs,
  ...
}:

{
  imports = [
    ../../mixins/direnv.nix
    ../../mixins/home-manager.nix
    ../../mixins/git.nix
    ../../mixins/nix.nix
    ../../mixins/zsh
  ];

  nixpkgs.overlays = [
    outputs.overlays.additions
  ];

  # WSL
  wsl.enable = true;
  wsl.extraBin = with pkgs; [
    { src = "${coreutils}/bin/uname"; }
    { src = "${coreutils}/bin/dirname"; }
    { src = "${coreutils}/bin/readlink"; }
  ];
  wsl.defaultUser = "nixos";

  programs.nix-ld.enable = true;

  users.users.${user} = {
    group = "users";
    home = "/home/${user}";
  };

  home-manager.users.${user} = {
    programs.git = {
      userName = "Eduardo Correia";
      userEmail = "skelozard1@gmail.com";
    };
    home = {
      # Installed packages
      packages = with pkgs; [
        ffmpeg
        nil
        yt-dlp
        wget
      ];
    };
  };

  system.stateVersion = "24.11";
}
