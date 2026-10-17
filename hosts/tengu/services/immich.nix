{ config, mkServiceHost, ... }:

{
  services.immich = {
    enable = true;
    port = 2283;
  };

  services.nginx.virtualHosts.immich = mkServiceHost {
    subdomain = "immich";
    port = config.services.immich.port;
  };
}
