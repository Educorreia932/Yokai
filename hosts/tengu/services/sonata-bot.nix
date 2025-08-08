{ config, ... }:

{
  services.sonata-bot = {
    enable = true;
    environmentFile = config.age.secrets.sonataBotEnvFile.path;
  };
}
