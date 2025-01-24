{ config, ... }:

let
  baseDomain = "educorreia932.dev";
  mkVirtualHost = serverName: proxyAddress: port: {
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
    serverName = "${serverName}.${baseDomain}";
    addSSL = true;
    enableACME = true;
    root = "/var/lib/www/${serverName}.${baseDomain}";
    locations."/" = {
      proxyPass = "http://localhost:${toString port}";
      proxyWebsockets = true;
      recommendedProxySettings = true;
      extraConfig = ''
        client_max_body_size 50000M;
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
    virtualHosts = {
      "immich" = mkVirtualHost "immich" "[::1]" config.services.immich.port;
      "paperless" = mkVirtualHost "paperless" "127.0.0.1" config.services.paperless.port;
    };
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "web+acme@company.org";
  };
}
