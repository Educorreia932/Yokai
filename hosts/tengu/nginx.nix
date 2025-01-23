{ config, ... }:

{
  services.nginx = {
    enable = true;
    virtualHosts = {
      # Immich
      "immich" = {
        listen = [
          {
            port = 8081;
            addr = "0.0.0.0";
          }
        ];
        locations."/" = {
          proxyPass = "http://[::1]:${toString config.services.immich.port}";
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
      # Paperless
      "paperless" = {
        listen = [
          {
            port = 8082;
            addr = "0.0.0.0";
          }
        ];
        locations."/" = {
          proxyPass = "http://127.0.0.1:${toString config.services.paperless.port}";
          extraConfig = ''
            client_max_body_size 50000M;
            proxy_read_timeout   600s;
            proxy_send_timeout   600s;
            send_timeout         600s;
          '';
        };
      };
    };
  };
}
