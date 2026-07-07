{ lib, config, ... }:

let
  # Base domain shared by every public-facing service on this host.
  domain = "educorreia932.dev";

  # Helper to create a reverse-proxy virtual host for a given server name and port.
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
    serverName = serverName;
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
  # Expose the domain and virtual-host helpers to service modules.
  _module.args.domain = domain;
  _module.args.mkVirtualHost = mkVirtualHost;

  # Convenience helper: build a virtual host for "<subdomain>.<domain>".
  _module.args.mkServiceHost =
    { subdomain, port }:
    lib.mkIf config.services.nginx.enable (mkVirtualHost "${subdomain}.${domain}" port);

  services.nginx = {
    enable = true;

    # Use recommended settings
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    clientMaxBodySize = "1G";
  };

  # Enable ACME for automatic TLS certificates
  security.acme = {
    acceptTerms = true;
    defaults.email = "web+acme@${domain}";
  };
}
