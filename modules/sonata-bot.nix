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

    discord_bot_token = lib.mkOption {
      type = lib.types.str;
      description = "Discord token for Sonata Bot";
    };

    google_token = lib.mkOption {
      type = lib.types.str;
      description = "Google Search API token for Sonata Bot";
    };

    google_cse_id = lib.mkOption {
      type = lib.types.str;
      description = "Google Custom Search Engine ID for Sonata Bot";
    };

    google_cse_id_streaming = lib.mkOption {
      type = lib.types.str;
      description = "Google Custom Search Engine ID for streaming services in Sonata Bot";
    };

    last_fm_api_key = lib.mkOption {
      type = lib.types.str;
      description = "Last.fm API key for Sonata Bot";
    };

    database_location = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/sonata-bot/sonata.db";
    };
  };

  config = lib.mkIf config.services.sonata-bot.enable {
    systemd.services.sonata-bot = {
      description = "A Discord bot for music lovers";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      environment = with config.services.sonata-bot; {
        DISCORD_SONATA_TOKEN = discord_bot_token;
        GOOGLE_API_KEY = google_token;
        GOOGLE_CSE_ID = google_cse_id;
        GOOGLE_CSE_ID_STREAMING = google_cse_id_streaming;
        LASTFM_API_KEY = last_fm_api_key;
        SONATA_BOT_DB_PATH = database_location;
      };
      serviceConfig = {
        ExecStart = "${sonata-bot}/bin/sonata-bot";
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
