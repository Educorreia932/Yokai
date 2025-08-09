{ config, ... }:

let
  mkVirtualHost = serverName: port: {
    listen = [
      {
        port = 80;
        addr = "0.0.0.0";
      }
      {
        port = 443;
        addr = "0.0.0.0";
        ssl = true;
      }
    ];
    serverName = "${serverName}";
    addSSL = true;
    enableACME = true;
    root = "/var/lib/www/${serverName}";
    locations."/" = {
      proxyPass = "http://localhost:${toString port}";
      proxyWebsockets = true;
      recommendedProxySettings = true;
      extraConfig = ''
        proxy_read_timeout   600s;
        proxy_send_timeout   600s;
        send_timeout         600s;
      '';
    };
  };

in
{
  services.nginx = {
    enable = true;
    clientMaxBodySize = "1G";
    virtualHosts = with config.services; {
      "homepage-dashboard" = mkVirtualHost "home.educorreia932.dev" homepage-dashboard.listenPort;
      "immich" = mkVirtualHost "immich.educorreia932.dev" immich.port;
      "jellyfin" = mkVirtualHost "jellyfin.educorreia932.dev" 8096;
      "komga" = mkVirtualHost "komga.educorreia932.dev" komga.settings.server.port;
      "paperless" = mkVirtualHost "paperless.educorreia932.dev" paperless.port;
      "slskd" = mkVirtualHost "slskd.educorreia932.dev" slskd.settings.web.port;
      "syncthing" = mkVirtualHost "syncthing.educorreia932.dev" 8384;
      "transmission" = mkVirtualHost "transmission.educorreia932.dev" transmission.settings.rpc-port;
      "website" = mkVirtualHost "educorreia932.dev" website.port;
    };
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "web+acme@company.org";
  };
}
