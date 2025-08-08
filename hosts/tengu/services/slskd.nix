{
  services.slskd = {
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
}
