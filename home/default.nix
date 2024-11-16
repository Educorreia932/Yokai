{ inputs, user, pkgs, ... }:

{
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs user; };
    backupFileExtension = "backup";
    users.${user} = {
      imports = [
        ./programs/firefox.nix
        ./programs/lutris.nix
        ./programs/node.nix
        ./programs/ptyxis
        ./shell/git.nix
        ./shell/neovim
        ./shell/zsh
      ];
      # Enabled programs
      programs = {
        direnv = {
          enable = true;
          enableZshIntegration = true;
          nix-direnv.enable = true;
        };
        obs-studio.enable = true;
        pywal.enable = true;
        vscode.enable = true;
      };
      # Home configuration
      home = {
        stateVersion = "24.05";
        username = "${user}";
        homeDirectory = "/home/${user}";
        # Installed packages
        packages = with pkgs; [
          calibre
          discord
          gimp
          gitkraken
          inkscape
          jetbrains.webstorm
          neofetch
          nixpkgs-fmt
          nil
          obsidian
          qbittorrent
          spotify
          syncthing
          yarn
          webcord
          zoom-us
        ];
      };
      # Let Home Manager install and manage itself.
      programs.home-manager.enable = true;
    };
  };
}
