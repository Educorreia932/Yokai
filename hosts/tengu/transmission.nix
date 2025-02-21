{ config, lib, ... }:

{
  services.transmission = {
    enable = true;
    openRPCPort = true; # Allow remote access
    home = "/mnt/media/transmission";

    settings = {
      rpc-bind-address = "0.0.0.0"; # Allow external access
      rpc-port = 9091;
      rpc-authentication-required = true;
      rpc-whitelist = "127.0.0.1,transmission.educorreia932.dev";
      rpc-whitelist-enabled = true;
      rpc-username = "Skelozard";
      rpc-password = lib.fileContents config.age.secrets.transmission-password.path;
    };
  };
}
