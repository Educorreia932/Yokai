{ config, domain, ... }:

{
  services.szurubooru = {
    enable = true;
    openFirewall = true;
    database = {
      passwordFile = config.age.secrets.szurubooruSecret.path;
    };
    dataDir = "/mnt/media/szurubooru";
    server = {
      settings = {
        domain = "https://szurubooru.${domain}";
        secretFile = config.age.secrets.szurubooruSecret.path;
        # Make instance private by default, and only allow registered users to view posts and tags.
        privileges = {
          "users:create:self" = "administrator"; # Registration permission
          "posts:create:anonymous" = "regular";
          "posts:list" = "regular";
          "posts:view" = "regular";
          "posts:view:featured" = "regular";
          "tags:view" = "regular";
          "tag_categories:list" = "regular";
          "tag_categories:view" = "regular";
          "pools:view" = "regular";
          "pool_categories:list" = "regular";
          "pool_categories:view" = "regular";
        };
      };
      port = 9000;
    };
  };

  services.nginx.virtualHosts.szurubooru = {
    serverName = "szurubooru.${domain}";
    addSSL = true;
    enableACME = true;
    root = "${config.services.szurubooru.server.package}/public";
    locations = {
      "/api/".proxyPass = "http://localhost:${builtins.toString config.services.szurubooru.server.port}/";
      "/data/".root = config.services.szurubooru.dataDir;
      "/" = {
        root = config.services.szurubooru.client.package;
        tryFiles = "$uri /index.htm";
      };
    };
  };
}
