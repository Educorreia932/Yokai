{
  pkgs,
  user,
  ...
}:

{
  imports = [
    ../../modules/direnv.nix
    ../../modules/home-manager.nix
    ../../modules/git.nix
    ../../modules/nix.nix
    ../../modules/zsh
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
        nil
        wget
      ];
    };
  };

  system.stateVersion = "24.11";
}
