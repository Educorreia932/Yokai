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
      shares = {
        directories = [
          "/mnt/media/transmission/Downloads"
        ];
      };
    };
  };
}