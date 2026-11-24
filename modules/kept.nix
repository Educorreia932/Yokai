{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.services.kept;
  networkName = "kept";
  keptImage = {
    image = cfg.image;
    extraOptions = [
      "--read-only"
      "--tmpfs=/tmp"
      "--security-opt=no-new-privileges:true"
    ];
    capabilities.ALL = false;
  };
  waitForDatabase = pkgs.writeShellApplication {
    name = "wait-for-kept-database";
    runtimeInputs = [
      config.virtualisation.docker.package
      pkgs.coreutils
    ];
    text = ''
      for _ in $(seq 1 30); do
        if status=$(docker inspect --format '{{.State.Health.Status}}' kept-db 2>/dev/null); then
          if [ "$status" = healthy ]; then
            exit 0
          fi
        fi
        sleep 5
      done
      echo "Kept's PostgreSQL container did not become healthy" >&2
      exit 1
    '';
  };
  createDockerNetwork = pkgs.writeShellApplication {
    name = "create-kept-docker-network";
    runtimeInputs = [ config.virtualisation.docker.package ];
    text = ''
      docker network inspect ${networkName} >/dev/null 2>&1 \
        || docker network create ${networkName}
    '';
  };
  appEnvironment = {
    KEPT_DATABASE_URL = "postgres://kept_app:@kept-db:5432/kept";
    KEPT_AUTH_DATABASE_URL = "postgres://kept_auth:@kept-db:5432/kept";
    KEPT_SYSTEM_DATABASE_URL = "postgres://kept_system:@kept-db:5432/kept";
    KEPT_DB_APP_PASSWORD_FILE = "/config/database/kept_app";
    KEPT_DB_AUTH_PASSWORD_FILE = "/config/database/kept_auth";
    KEPT_DB_SYSTEM_PASSWORD_FILE = "/config/database/kept_system";
    KEPT_PUBLIC_URL = cfg.publicUrl;
    KEPT_LOG_LEVEL = "info";
    KEPT_LOG_FORMAT = "json";
    KEPT_STORAGE = "local";
  }
  // cfg.environment;
in
{
  options.services.kept = {
    enable = lib.mkEnableOption "Kept";

    image = lib.mkOption {
      type = lib.types.str;
      default = "ghcr.io/keptinventory/kept:1.14.7";
      description = "Kept container image.";
    };

    port = lib.mkOption {
      type = lib.types.port;
      default = 8080;
      description = "Host port used to access Kept.";
    };

    publicUrl = lib.mkOption {
      type = lib.types.str;
      default = "http://localhost:8080";
      description = "Public URL at which users access Kept.";
    };

    dataDir = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/kept/data";
      description = "Directory used to persist Kept files and backup data.";
    };

    configDir = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/kept/config";
      description = "Directory used to persist Kept configuration and generated database passwords.";
    };

    ownerDir = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/kept/owner";
      description = "Directory used to persist the Kept database owner password.";
    };

    dbDir = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/kept/db";
      description = "Directory used to persist the PostgreSQL database.";
    };

    environment = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = { };
      description = "Additional environment variables passed to Kept and its migrations.";
    };

    environmentFiles = lib.mkOption {
      type = lib.types.listOf lib.types.path;
      default = [ ];
      description = "Environment files passed to Kept and its migrations.";
    };
  };

  config = lib.mkIf cfg.enable {
    virtualisation.oci-containers = {
      backend = "docker";

      containers = {
        kept-db = {
          image = "pgvector/pgvector:0.8.6-pg18-bookworm@sha256:2ba9ca5f2e7daa0f0e7723cba1ee9167bab54efd3640516a44ac1a928dd67e7a";
          entrypoint = "sh";
          cmd = [
            "-c"
            ''
              if [ -z "$POSTGRES_PASSWORD" ]; then
                POSTGRES_PASSWORD=$(od -An -N32 -tx1 /dev/urandom | tr -d ' \n')
                export POSTGRES_PASSWORD
              fi
              exec docker-entrypoint.sh "$@"
            ''
            "db"
            "postgres"
          ];
          environment = {
            POSTGRES_DB = "kept";
            POSTGRES_PASSWORD = "";
            POSTGRES_USER = "postgres";
            TZ = "UTC";
          };
          extraOptions = [
            "--health-cmd=pg_isready -h 127.0.0.1 -U postgres -d kept"
            "--health-interval=5s"
            "--health-timeout=5s"
            "--health-retries=30"
          ];
          networks = [ networkName ];
          volumes = [ "${cfg.dbDir}:/var/lib/postgresql" ];
        };

        kept-bootstrap = keptImage // {
          entrypoint = "kept";
          cmd = [ "bootstrap" ];
          dependsOn = [ "kept-db" ];
          extraOptions = keptImage.extraOptions ++ [ "--network=container:kept-db" ];
          environment = {
            PGHOST = "127.0.0.1";
            PGPORT = "5432";
            PGUSER = "postgres";
            PGDATABASE = "kept";
            KEPT_DB_OWNER_PASSWORD_FILE = "/owner/kept_owner";
            KEPT_DB_APP_PASSWORD_FILE = "/config/database/kept_app";
            KEPT_DB_AUTH_PASSWORD_FILE = "/config/database/kept_auth";
            KEPT_DB_SYSTEM_PASSWORD_FILE = "/config/database/kept_system";
          };
          volumes = [
            "${cfg.configDir}:/config"
            "${cfg.ownerDir}:/owner"
          ];
        };

        kept-migrate = keptImage // {
          entrypoint = "kept";
          cmd = [ "migrate" ];
          dependsOn = [
            "kept-db"
            "kept-bootstrap"
          ];
          environment = {
            KEPT_OWNER_DATABASE_URL = "postgres://kept_owner:@kept-db:5432/kept";
            KEPT_DB_OWNER_PASSWORD_FILE = "/owner/kept_owner";
          }
          // appEnvironment;
          inherit (cfg) environmentFiles;
          networks = [ networkName ];
          volumes = [
            "${cfg.dataDir}:/data"
            "${cfg.configDir}:/config:ro"
            "${cfg.ownerDir}:/owner:ro"
          ];
        };

        kept = keptImage // {
          dependsOn = [
            "kept-db"
            "kept-migrate"
          ];
          environment = appEnvironment;
          inherit (cfg) environmentFiles;
          networks = [ networkName ];
          ports = [ "127.0.0.1:${toString cfg.port}:8080" ];
          volumes = [
            "${cfg.dataDir}:/data"
            "${cfg.configDir}:/config"
          ];
        };
      };
    };

    systemd.services.kept-docker-network = {
      description = "Create the Docker network used by Kept";
      after = [ "docker.service" ];
      requires = [ "docker.service" ];
      before = [ "docker-kept-db.service" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = "${createDockerNetwork}/bin/create-kept-docker-network";
      };
    };

    systemd.services.docker-kept-db = {
      requires = [ "kept-docker-network.service" ];
      after = [ "kept-docker-network.service" ];
    };

    systemd.services.docker-kept-bootstrap.serviceConfig = {
      ExecStartPre = lib.mkAfter [ "${waitForDatabase}/bin/wait-for-kept-database" ];
      Restart = lib.mkForce "no";
      Type = lib.mkForce "oneshot";
    };

    systemd.services.docker-kept-migrate.serviceConfig = {
      Restart = lib.mkForce "no";
      Type = lib.mkForce "oneshot";
    };

    systemd.tmpfiles.rules = [
      "d /var/lib/kept 0750 root root - -"
      "d ${cfg.dbDir} 0700 999 999 - -"
      "d ${cfg.dataDir} 0750 10001 10001 - -"
      "d ${cfg.configDir} 0700 10001 10001 - -"
      "d ${cfg.ownerDir} 0700 10001 10001 - -"
    ];
  };
}
