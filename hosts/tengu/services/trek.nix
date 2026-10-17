{ mkServiceHost, ... }:

{
  virtualisation.oci-containers = {
    backend = "docker";

    containers.trek = {
      image = "mauriceboe/trek:latest";

      ports = [
        "127.0.0.1:5982:3000"
      ];

      volumes = [
        "/var/lib/trek/data:/app/data"
        "/var/lib/trek/uploads:/app/uploads"
      ];

      environment = {
        NODE_ENV = "production";
        TZ = "Europe/Lisbon";
      };

      environmentFiles = [
      ];

      autoStart = true;
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/trek 0750 root root - -"
    "d /var/lib/trek/data 0750 root root - -"
    "d /var/lib/trek/uploads 0750 root root - -"
  ];

  services.nginx.virtualHosts.trek = mkServiceHost {
    subdomain = "trek";
    port = 5982;
  };
}
