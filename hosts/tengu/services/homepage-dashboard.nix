{
  config,
  lib,
  mkServiceHost,
  domain,
  ...
}:
{
  services.homepage-dashboard = {
    enable = true;
    allowedHosts = lib.concatStringsSep "," [
      "localhost:8082"
      "127.0.0.1:8082"
      "home.${domain}"
    ];
    settings = {
      title = "Educorreia932's Homepage";
      description = "Homepage dashboard for my personal services";
      statusStyle = "dot";
      hideVersion = true;
      style = "row";
      columns = 2;
      layout = {
        "Media" = {
          style = "column";
        };
        "Misc" = {
          style = "column";
          header = false;
        };
      };
    };
    # environmentFile = config.age.secrets.dashboardEnv.path;
    environmentFiles = [ "/home/eduardo/env" ];
    widgets = [
      {
        resources = {
          cpu = true;
          disk = "/mnt/media";
          memory = true;
        };
      }
    ];
    services = [
      {
        "Media" = [
          {
            "Immich" = rec {
              href = "https://immich.${domain}";
              siteMonitor = href;
              description = "Photo and video management";
              icon = "sh-immich";
              widgets = [
                {
                  type = "immich";
                  url = href;
                  key = "{{HOMEPAGE_VAR_IMMICH_KEY}}";
                  version = 2;
                }
              ];
            };
          }
          {
            "Jellyfin" = rec {
              href = "https://jellyfin.${domain}";
              siteMonitor = href;
              description = "Media system";
              icon = "sh-jellyfin";
              widgets = [
                {
                  type = "jellyfin";
                  url = href;
                  enableBlocks = true;
                  enableUser = false;
                  enableNowPlaying = false;
                  expandOneStreamToTwoRows = false;
                }
              ];
            };
          }
          {
            "Komga" = rec {
              href = "https://komga.${domain}";
              siteMonitor = href;
              description = "Media server for comics, mangas, BDs, magazines and eBooks";
              icon = "sh-komga";
              widgets = [
                {
                  type = "komga";
                  url = href;
                  key = "{{HOMEPAGE_VAR_KOMGA_KEY}}";
                }
              ];
            };
          }
          {
            "Paperless" = rec {
              href = "https://paperless.${domain}";
              siteMonitor = href;
              description = "Document management";
              icon = "sh-paperless-ngx";
              widgets = [
                {
                  type = "paperlessngx";
                  url = href;
                  key = "{{HOMEPAGE_VAR_PAPERLESS_KEY}}";
                }
              ];
            };
          }
          {
            "Szurubooru" = rec {
              href = "https://szurubooru.${domain}";
              siteMonitor = href;
              description = "Image board";
              icon = "https://raw.githubusercontent.com/rr-/szurubooru/refs/heads/master/client/img/app.png";
            };
          }
        ];
      }
      {
        Misc = [
          {
            "Download" = [
              {
                "Deluge" = rec {
                  href = "https://deluge.${domain}";
                  siteMonitor = href;
                  description = "BitTorrent client";
                  icon = "sh-deluge";
                };
              }
              {
                "Soulseek" = rec {
                  href = "https://slskd.${domain}";
                  siteMonitor = href;
                  description = "Peer-to-peer file sharing";
                  icon = "https://upload.wikimedia.org/wikipedia/commons/8/83/Soulseek-png-3.png";
                };
              }
            ];
          }
          {
            "Sync" = [
              {
                "Syncthing" = rec {
                  href = "https://syncthing.${domain}";
                  siteMonitor = href;
                  description = "Continuous file synchronization";
                  icon = "sh-syncthing";
                };
              }
            ];
          }
          {
            "Personal" = [
              {
                "Sure" = rec {
                  href = "https://sure.${domain}";
                  siteMonitor = href;
                  description = "Finance and budgeting manager";
                  icon = "https://cdn.jsdelivr.net/gh/selfhst/icons@main/png/sure-finance.png";
                };
              }
            ];
          }
          {
            "Bots" = [
              {
                "Sonata Bot" = {
                  href = "https://hsc00.github.io/sonata-bot/";
                  description = "A Discord bot for music lovers ";
                  icon = "https://raw.githubusercontent.com/hsc00/sonata-bot/main/logo.png";
                };
              }
            ];
          }
        ];
      }
    ];
  };

  services.nginx.virtualHosts.homepage-dashboard = mkServiceHost {
    subdomain = "home";
    port = config.services.homepage-dashboard.listenPort;
  };
}
