{ config, mkServiceHost, ... }:

{
  services.deluge = {
    enable = true;
    web.enable = true;
    dataDir = "/mnt/media/deluge";
  };

  services.nginx.virtualHosts.deluge = mkServiceHost {
    subdomain = "deluge";
    port = config.services.deluge.web.port;
  };
}
