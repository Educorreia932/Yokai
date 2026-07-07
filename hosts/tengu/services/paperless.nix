{
  config,
  mkServiceHost,
  domain,
  ...
}:

{
  services.paperless = {
    enable = true;
    port = 28981;
    consumptionDirIsPublic = true;
    dataDir = "/mnt/media/paperless";
    settings = {
      PAPERLESS_URL = "https://paperless.${domain}";
    };
  };

  services.nginx.virtualHosts.paperless = mkServiceHost {
    subdomain = "paperless";
    port = config.services.paperless.port;
  };
}
