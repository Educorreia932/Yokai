{ ... }: {
  imports = [
    ./applications/alacritty.nix
    ./applications/docker.nix
    ./applications/steam.nix
    ./applications/obsidian.nix
    ./applications/virtualbox.nix
    ./graphical/fonts
    ./graphical/gnome.nix
    ./hardware/audio.nix
    ./hardware/nvidia.nix
    ./services/asusctl.nix
    ./shell/git.nix
    ./shell/neovim
    ./shell/wal.nix
    ./shell/zsh
  ];
}
