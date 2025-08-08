{ lib, ... }:
{
  imports = [
    ./immich.nix
    ./jellyfin.nix
    ./komga.nix
    ./monit.nix
    ./paperless.nix
    ./slskd.nix
    ./sonata-bot.nix
    ./syncthing.nix
    ./transmission.nix
    ./website.nix
  ];
}
