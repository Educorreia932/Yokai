{ pkgs }:

pkgs.python3Packages.buildPythonApplication {
  pname = "sonata";
  version = "0.1.0";

  src = builtins.fetchGit {
    url = "git@github.com:hsc00/sonata-bot.git";
    ref = "main";
  };

  dependencies = with pkgs.python3Packages; [
    beautifulsoup4
    discordpy
    pynacl
    python-dotenv
    requests
    spotipy
    syncedlyrics
    unidecode
  ];

  meta = with pkgs.lib; {
    description = "Discord bot to gather music info";
    maintainers = [ maintainers.educorreia932 ];
    platforms = platforms.all;
  };
}