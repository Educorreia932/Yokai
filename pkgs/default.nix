pkgs: {
  website = pkgs.callPackage ./website.nix { };
  lyricsgenius = pkgs.callPackage ./lyricsgenius.nix { };
}
