{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    package = pkgs.steam.override {
      extraLibraries = (pkgs: [ pkgs.openssl pkgs.nghttp2 pkgs.libidn2 pkgs.rtmpdump pkgs.libpsl pkgs.curl pkgs.krb5 pkgs.keyutils ]);
    };
  };
}
