{ config, mkServiceHost, ... }:

{
  services.komga = {
    enable = true;
    settings.server.port = 25600;
    stateDir = "/mnt/media/komga";
  };

  services.nginx.virtualHosts.komga = mkServiceHost {
    subdomain = "komga";
    port = config.services.komga.settings.server.port;
  };
}
