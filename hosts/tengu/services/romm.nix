{
  config,
  domain,
  ...
}:

{
  services.romm = {
    enable = true;
    port = 8385;
    nginx = {
      enable = true;
      virtualHost = "romm.${domain}";
    };
    environmentFile = config.age.secrets.rommEnv.path;
  };

  services.nginx.virtualHosts."romm.${domain}" = {
    forceSSL = true;
    enableACME = true;
  };
}
