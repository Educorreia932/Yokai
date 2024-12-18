{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    package = pkgs.steam.override {
      extraLibraries = (
        pkgs: with pkgs; [
          openssl
          nghttp2
          libidn2
          rtmpdump
          libpsl
          curl
          krb5
          keyutils
        ]
      );
    };
  };
}
