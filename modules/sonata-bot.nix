{ config, lib, pkgs, ... }:

with lib;

{
  options.services.sonataBot = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable the Sonata bot service.";
    };
  };

  config = mkIf config.services.sonataBot.enable {
    systemd.services.sonataBot = {
      description = "Sonata bot service";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.python3}/bin/python3 ~/sonata-bot/bot.py";
        Restart = "always";
        User = "sonata-bot"; 
        Group = "sonata-bot"; 
      };
    };
  };
}