pkgs: {
  website = pkgs.callPackage ./website.nix { };
  sonata-bot = pkgs.callPackage ./sonata-bot.nix { };
  lyricsgenius = pkgs.callPackage ./lyricsgenius.nix { };
}
