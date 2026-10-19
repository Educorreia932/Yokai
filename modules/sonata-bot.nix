{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.services.sonata-bot;
  sonata = inputs.sonata.packages.${pkgs.system}.default;
in
{
  options.services.sonata-bot = {
    enable = lib.mkEnableOption "Sonata Bot";

    environmentFile = lib.mkOption {
      type = lib.types.path;
      description = "Path to the environment file for Sonata Bot";
    };

    databaseLocation = lib.mkOption {
      type = lib.types.path;
      default = /var/lib/sonata-bot/sonata.db;
      description = "Path to the database location for Sonata Bot";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.sonata-bot = {
      description = "A Discord bot for music lovers";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${sonata}/bin/sonata";
        EnvironmentFile = cfg.environmentFile;
        Restart = "on-failure";
        StateDirectory = "sonata-bot";
        WorkingDirectory = "/var/lib/sonata-bot";
        User = "sonata-bot";
        Group = "sonata-bot";
      };
    };

    users.users.sonata-bot = {
      group = "sonata-bot";
      description = "User for the Sonata Discord bot";
      isSystemUser = true;
    };

    users.groups.sonata-bot = { };
  };
}
