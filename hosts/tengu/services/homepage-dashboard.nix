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
    environmentFiles = [ config.age.secrets.homepageDashboardEnv.path ];
    widgets = [
      {
        resources = {
          cpu = true;
          disk = "/";
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
                  key = "{{HOMEPAGE_VAR_JELLYFIN_KEY}}";
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
            "Romm" = rec {
              href = "https://romm.${domain}";
              siteMonitor = href;
              description = "ROM manager";
              icon = "sh-romm";
              widgets = [
                {
                  type = "romm";
                  url = href;
                }
              ];
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
            "Personal" = [
              {
                "SilverBullet" = rec {
                  href = "https://silverbullet.${domain}";
                  siteMonitor = href;
                  description = "Note taking";
                  icon = "sh-silverbullet";
                };
              }
              {
                "Trek" = rec {
                  href = "https://trek.${domain}";
                  siteMonitor = href;
                  description = "Travel planning";
                  icon = "sh-trek";
                };
              }
            ];
          }
          {
            "Bots" = [
              {
                "Sonata Bot" = {
                  href = "https://hsc00.github.io/sonata-bot/";
                  description = "A Discord bot for music lovers";
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
