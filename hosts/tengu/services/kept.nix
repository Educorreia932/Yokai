{ config, mkServiceHost, ... }:

{
  services.kept = {
    enable = true;
    publicUrl = "https://kept.educorreia932.dev";
  };

  services.nginx.virtualHosts.kept = mkServiceHost {
    subdomain = "kept";
    port = config.services.kept.port;
  };
}
