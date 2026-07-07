{
  config,
  mkVirtualHost,
  domain,
  ...
}:

{
  services.website = {
    enable = true;
    port = 3000;
  };

  services.nginx.virtualHosts.website = mkVirtualHost domain config.services.website.port;
}
