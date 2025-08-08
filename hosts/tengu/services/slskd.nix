{
  services.slskd = rec {
    enable = true;
    domain = "slskd.educorreia932.dev";
    environmentFile = /etc/slskd.env;
    settings = {
      soulseek = {
        username = "Skelozard";
        address = "server.slsknet.org";
        port = 2242;
      };
      directories = {
        downloads = "/var/lib/slskd/downloads";
      };
      shares = {
        directories = [
          settings.directories.downloads
        ];
      };
    };
  };
}
