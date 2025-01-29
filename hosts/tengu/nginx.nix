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
      "immich" = mkVirtualHost "immich.educorreia932.dev" immich.port;
      "paperless" = mkVirtualHost "paperless.educorreia932.dev" paperless.port;
      "monit" = mkVirtualHost "monit.educorreia932.dev" 2812;
      "sharkey" = mkVirtualHost "tomobiki.city" sharkey.settings.port;
    };
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "web+acme@company.org";
  };
}
