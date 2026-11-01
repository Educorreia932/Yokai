{ config, mkServiceHost, ... }:

{
  services.trek = {
    enable = true;
  };

  services.nginx.virtualHosts.trek = mkServiceHost {
    subdomain = "trek";
    port = config.services.trek.port;
  };
}
