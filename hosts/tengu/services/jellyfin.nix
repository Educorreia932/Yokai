{ mkServiceHost, ... }:

{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  services.nginx.virtualHosts.jellyfin = mkServiceHost {
    subdomain = "jellyfin";
    port = 8096;
  };
}
