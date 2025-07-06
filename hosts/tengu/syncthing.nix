{
  services.syncthing = {
    enable = true;
    user = "eduardo";
    dataDir = "/mnt/media/syncthing";
    openDefaultPorts = true;
    guiAddress = "0.0.0.0:8384";
  };
}
