{ config, mkServiceHost, ... }:

{
  services.deluge = {
    enable = true;
    web.enable = true;
  };

  services.nginx.virtualHosts.deluge = mkServiceHost {
    subdomain = "deluge";
    port = config.services.deluge.web.port;
  };
}
