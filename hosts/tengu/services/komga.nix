{ config, mkServiceHost, ... }:

{
  services.komga = {
    enable = true;
    settings.server.port = 25600;
  };

  services.nginx.virtualHosts.komga = mkServiceHost {
    subdomain = "komga";
    port = config.services.komga.settings.server.port;
  };
}
