{
  pkgs,
}:

let
  lyricsgenius = pkgs.callPackage ./lyricsgenius.nix { };
in
pkgs.python3Packages.buildPythonApplication {
  pname = "sonata-bot";
  version = "0.1.0";

  src = builtins.fetchGit {
    url = "git@github.com:hsc00/sonata-bot.git";
    ref = "refactor";
    rev = "3e2f654f73f1d8d608904f69a55344d84af6601d";
    allRefs = true;
  };

  propagatedBuildInputs = with pkgs.python3Packages; [
    apscheduler
    beautifulsoup4
    discordpy
    lyricsgenius
    python-dotenv
    peewee
    requests
    rich
    syncedlyrics
  ];

  meta = {
    description = "A Discord bot for music lovers";
    homepage = "https://github.com/hsc00/sonata-bot";
    maintainers = with pkgs.lib.maintainers; [
      educorreia932
    ];
  };
}
