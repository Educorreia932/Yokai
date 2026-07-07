{ config, mkServiceHost, ... }:

{
  services.immich = {
    enable = true;
    port = 2283;
    mediaLocation = "/mnt/media/immich";
  };

  services.nginx.virtualHosts.immich = mkServiceHost {
    subdomain = "immich";
    port = config.services.immich.port;
  };
}
