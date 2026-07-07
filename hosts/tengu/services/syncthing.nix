{ mkServiceHost, ... }:

{
  services.syncthing = {
    enable = true;
    user = "eduardo";
    dataDir = "/mnt/media/syncthing";
    openDefaultPorts = true;
    guiAddress = "0.0.0.0:8384";
  };

  services.nginx.virtualHosts.syncthing = mkServiceHost {
    subdomain = "syncthing";
    port = 8384;
  };
}
