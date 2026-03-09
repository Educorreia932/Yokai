{
  pkgs,
  user,
  outputs,
  ...
}:

{
  imports = [
    ../../mixins/direnv.nix
    ../../mixins/emacs
    ../../mixins/home-manager.nix
    ../../mixins/git.nix
    ../../mixins/lf.nix
    ../../mixins/nix.nix
    ../../mixins/node.nix
    ../../mixins/style.nix
    ../../mixins/zsh.nix
  ];

  nixpkgs.overlays = [
    outputs.overlays.additions
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

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
    programs.git.settings.user = {
      name = "Eduardo Correia";
      email = "skelozard1@gmail.com";
    };
    home = {
      # Installed packages
      packages = with pkgs; [
        ffmpeg
        just
        nil
        yt-dlp
        wget

        # Haskell development
        cabal-install
        ghc
        haskellPackages.cabal-fmt
        haskellPackages.fourmolu
        haskellPackages.haskell-language-server
      ];
    };
  };

  system.stateVersion = "24.11";
}
