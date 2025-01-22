{
  services.nginx = {
    enable = true;
    virtualHosts = {
      # Immich
      "immich" = {
        listen = [ { port = 2283; addr="0.0.0.0"; } ];
        locations."/" = {
          proxyPass = "http://[::1]:2283";
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
        listen = [ { port = 28981; addr="0.0.0.0"; } ];
        locations."/" = {
        proxyPass = "http://[::1]:28981";
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
    };
  };
}