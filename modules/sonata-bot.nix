{
  config,
  lib,
  pkgs,
  ...
}:

let
  sonata-bot = import ./../pkgs/sonata-bot.nix { pkgs = pkgs; };
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

  config = lib.mkIf config.services.sonata-bot.enable {
    systemd.services.sonata-bot = {
      description = "A Discord bot for music lovers";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${sonata-bot}/bin/sonata-bot";
        EnvironmentFile = config.services.sonata-bot.environmentFile;
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
