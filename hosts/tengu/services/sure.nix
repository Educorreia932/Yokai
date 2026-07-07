{
  config,
  mkServiceHost,
  ...
}:

{
  services.sure = {
    enable = true;
    port = 3000;
    environmentFile = "/home/eduardo/env"; # exports SECRET_KEY_BASE
    databaseUrl = "postgresql://sure_user:password@127.0.0.1/sure_production";
    redisUrl = "redis://127.0.0.1:${toString config.services.redis.servers.sure.port}/0";
    dataDir = "/mnt/media/sure";
  };

  services.redis.servers.sure = {
    enable = true;
    bind = "127.0.0.1";
    port = 6379;
  };

  services.nginx.virtualHosts.sure = mkServiceHost {
    subdomain = "sure";
    port = config.services.sure.port;
  };
}
