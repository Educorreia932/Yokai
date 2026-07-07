{
  pkgs,
}:

let
  lyricsgenius = pkgs.callPackage ./lyricsgenius.nix { };
in
pkgs.python3Packages.buildPythonApplication rec {
  pname = "sonata-bot";
  version = "0.1.0";

  src = pkgs.fetchFromGitHub {
    owner = "hsc00";
    repo = pname;
    rev = "main";
    sha256 = "sha256-B19BFhIaMo9YEt6rvj+5ekw5OlaWkkUz8r5x1wudWwI=";
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

  pyproject = true;
  build-system = with pkgs.python3Packages; [ setuptools ];

  meta = {
    description = "A Discord bot for music lovers";
    homepage = "https://hsc00.github.io/sonata-bot/";
    maintainers = with pkgs.lib.maintainers; [
      educorreia932
    ];
  };
}
