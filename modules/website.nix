{
  config,
  lib,
  pkgs,
  ...
}:

let
  website = import ./../pkgs/website.nix { pkgs = pkgs; };
in
{
  options.services.website = {
    enable = lib.mkEnableOption "My personal website";
    port = lib.mkOption {
      type = lib.types.port;
      default = 3000;
      description = "Port to serve the website on";
    };
  };

  config = lib.mkIf config.services.website.enable {
    systemd.services.website = {
      description = "My Personal Website";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.nodejs_20}/bin/node ${website}/.output/server/index.mjs";
        Restart = "always";
        User = "nobody";
        ProtectSystem = "strict";
      };
    };
  };
}
