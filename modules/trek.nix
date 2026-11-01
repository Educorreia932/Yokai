{
  config,
  lib,
  ...
}:

let
  cfg = config.services.trek;
in
{
  options.services.trek = {
    enable = lib.mkEnableOption "Trek";

    port = lib.mkOption {
      type = lib.types.port;
      default = 5982;
      description = "Host port used to access Trek.";
    };

    dataDir = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/trek/data";
      description = "Directory used to persist Trek data.";
    };

    uploadsDir = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/trek/uploads";
      description = "Directory used to persist Trek uploads.";
    };

    environmentFiles = lib.mkOption {
      type = lib.types.listOf lib.types.path;
      default = [ ];
      description = "Environment files passed to the Trek container.";
    };
  };

  config = lib.mkIf cfg.enable {
    virtualisation.oci-containers = {
      backend = "docker";

      containers.trek = {
        image = "mauriceboe/trek:5.1.0";
        ports = [ "127.0.0.1:${toString cfg.port}:3000" ];
        volumes = [
          "${cfg.dataDir}:/app/data"
          "${cfg.uploadsDir}:/app/uploads"
        ];
        environment = {
          NODE_ENV = "production";
          TZ = "Europe/Lisbon";
        };
        inherit (cfg) environmentFiles;
        autoStart = true;
      };
    };

    systemd.tmpfiles.rules = [
      "d /var/lib/trek 0750 root root - -"
      "d ${cfg.dataDir} 0750 root root - -"
      "d ${cfg.uploadsDir} 0750 root root - -"
    ];
  };
}
