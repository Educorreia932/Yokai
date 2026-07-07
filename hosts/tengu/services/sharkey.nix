{
  config,
  mkServiceHost,
  domain,
  ...
}:

{
  services.sharkey = {
    enable = true;
    settings = {
      address = "127.0.0.1";
      port = 7283;
      url = "https://tomobiki.${domain}";
    };
  };

  services.nginx.virtualHosts.tomobiki = mkServiceHost {
    subdomain = "tomobiki";
    port = config.services.sharkey.settings.port;
  };
}
