{ inputs, ... }: {
  imports = [
    inputs.nur.nixosModules.nur
    inputs.home-manager.nixosModules.home-manager
    ./configuration.nix
    ./hardware-configuration.nix
    ../../home
    ./graphical/fonts
    ./graphical/gnome
    ./hardware/audio
    ./hardware/nvidia
    ./programs/docker
    ./programs/paperless
    ./programs/steam
  ];
}
