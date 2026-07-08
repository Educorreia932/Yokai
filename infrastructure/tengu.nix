{ lib, ... }:

# Terranix configuration for the Tengu server hosted on Hetzner Cloud.
let
  mkRRSet = name: {
    zone = "\${hcloud_zone.educorreia932.name}";
    inherit name;
    type = "A";

    ttl = 86400;

    records = [
      {
        value = "\${hcloud_rdns.primary_ip-79707539.ip_address}";
      }
    ];
  };
in
{
  config = {
    terraform = {
      required_providers = {
        hcloud = {
          source = "hetznercloud/hcloud";
        };
      };
    };

    variable.hcloud_token = {
      sensitive = true;
    };

    provider.hcloud = {
      token = "\${var.hcloud_token}";
    };

    # Server
    resource.hcloud_server.tengu = {
      image = "ubuntu-22.04";
      name = "Tengu";
      server_type = "cax21";
      location = "nbg1";
      keep_disk = true;
      public_net = {
        ipv4_enabled = true;
        ipv6_enabled = true;
      };
    };

    # DNS
    resource.hcloud_rdns.primary_ip-79707539 = {
      dns_ptr = "static.123.156.245.188.clients.your-server.de";
      ip_address = "188.245.156.123";
      primary_ip_id = 79707539;
    };

    resource.hcloud_primary_ip.primary_ip-79707539 = {
      name = "primary_ip-79707539";
      type = "ipv4";
      location = "nbg1";
    };

    resource.hcloud_zone."educorreia932" = {
      name = "educorreia932.dev";
      mode = "primary";
    };

    resource.hcloud_zone_rrset = lib.genAttrs [
      "deluge"
      "home"
      "immich"
      "jellyfin"
      "komga"
      "paperless"
      "slskd"
      "sonata"
      "sure"
      "syncthing"
      "szurubooru"
      "tomobiki"
      "www"
    ] mkRRSet;
  };
}
