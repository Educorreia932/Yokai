{ lib, ... }:
{
  services.homepage-dashboard = {
    enable = true;
    allowedHosts = lib.concatStringsSep "," [
      "localhost:8082"
      "127.0.0.1:8082"
      "home.educorreia932.dev"
    ];
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
            "Immich" = {
              href = "https://immich.educorreia932.dev";
              siteMonitor = "https://immich.educorreia932.dev";
              description = "Photo and video management";
              icon = "sh-immich";
            };
          }
          {
            "Jellyfin" = {
              href = "https://jellyfin.educorreia932.dev";
              siteMonitor = "https://jellyfin.educorreia932.dev";
              description = "Media system";
              icon = "sh-jellyfin";
            };
          }
          {
            "Komga" = {
              href = "https://komga.educorreia932.dev";
              siteMonitor = "https://komga.educorreia932.dev";
              description = "Media server for comics, mangas, BDs, magazines and eBooks";
              icon = "sh-komga";
            };
          }
          {
            "Paperless" = {
              href = "https://paperless.educorreia932.dev";
              siteMonitor = "https://komga.educorreia932.dev";
              description = "Document management";
              icon = "sh-paperless-ngx";
            };
          }
        ];
      }
      {
        "Download" = [
          {
            "Soulseek" = {
              href = "https://slskd.educorreia932.dev";
              siteMonitor = "https://komga.educorreia932.dev";
              description = "Peer-to-peer file sharing";
              icon = "https://upload.wikimedia.org/wikipedia/commons/8/83/Soulseek-png-3.png";
            };
          }
          {
            "Transmission" = {
              href = "https://transmission.educorreia932.dev";
              siteMonitor = "https://komga.educorreia932.dev";
              description = "BitTorrent client";
              icon = "sh-transmission";
            };
          }
        ];
      }
    ];
  };
}
