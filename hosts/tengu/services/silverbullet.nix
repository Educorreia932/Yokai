{
  config,
  mkServiceHost,
  ...
}:

{
  services.silverbullet = {
    enable = true;
    listenPort = 5230;
  };

  services.nginx.virtualHosts.silverbullet = mkServiceHost {
    subdomain = "silverbullet";
    port = config.services.silverbullet.listenPort;
  };
}
