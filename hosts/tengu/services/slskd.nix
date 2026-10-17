{
  config,
  mkServiceHost,
  domain,
  ...
}:
{
  services.slskd = {
    enable = true;
    domain = "slskd.${domain}";
    environmentFile = config.age.secrets.slskdEnv.path;
    settings = {
      soulseek = {
        username = "Skelozard";
        address = "server.slsknet.org";
        port = 2242;
      };
      directories = {
        downloads = "/var/lib/slskd/downloads";
        incomplete = "/var/lib/slskd/incomplete";
      };
    };
  };

  systemd.services.slskd.serviceConfig.UMask = "0002";

  services.nginx.virtualHosts.slskd = mkServiceHost {
    subdomain = "slskd";
    port = config.services.slskd.settings.web.port;
  };
}
