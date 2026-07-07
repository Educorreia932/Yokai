{ config, ... }:

{
  services.sonata-bot = {
    enable = true;
    environmentFile = config.age.secrets.sonataBotEnvFile.path;
  };

  # Make data directory writable by everyone
  systemd.tmpfiles.rules = [
    "z /var/lib/sonata-bot 0777 sonata-bot sonata-bot -"
  ];

  systemd.services.sonata-bot.serviceConfig.UMask = "0000";
}
