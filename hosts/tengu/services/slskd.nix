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
    environmentFile = /etc/slskd.env;
    settings = {
      soulseek = {
        username = "Skelozard";
        address = "server.slsknet.org";
        port = 2242;
      };
      directories = {
        downloads = "/mnt/media/slskd/downloads";
        incomplete = "/mnt/media/slskd/incomplete";
      };
      shares = {
        directories = [
          "/mnt/media/slskd/shared"
        ];
      };
    };
  };

  # Make data directory writable by everyone
  systemd.tmpfiles.rules = [
    "d /mnt/media/slskd 0777 slskd slskd -"
  ];

  systemd.services.slskd.serviceConfig.UMask = "0000";

  services.nginx.virtualHosts.slskd = mkServiceHost {
    subdomain = "slskd";
    port = config.services.slskd.settings.web.port;
  };
}
