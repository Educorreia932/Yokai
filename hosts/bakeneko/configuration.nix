{
  pkgs,
  user,
  inputs,
  ...
}:

{
  imports = [
    ../../modules/direnv.nix
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

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs user; };
    backupFileExtension = "backup";
    users.${user} = {
      # Home configuration
      home = {
        stateVersion = "24.11";
        username = "${user}";
        homeDirectory = "/home/${user}";
        # Installed packages
        packages = with pkgs; [
          nil
          wget
        ];
      };

      # Let Home Manager install and manage itself.
      programs.home-manager.enable = true;
    };
  };

  system.stateVersion = "24.11";
}
