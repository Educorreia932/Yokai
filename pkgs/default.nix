pkgs: {
  sonata-bot = pkgs.callPackage ./sonata-bot.nix { };
  website = pkgs.callPackage ./website.nix { };
}
