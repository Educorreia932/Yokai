{
  pkgs,
}:

pkgs.python3Packages.buildPythonApplication {
  pname = "sonata-bot";
  version = "0.1.0";

  src = builtins.fetchGit {
    url = "git@github.com:hsc00/sonata-bot.git";
    ref = "refactor";
    rev = "4a6e9538fcd4bd940e2e96d00344420cf1340769";
    allRefs = true;
  };

  propagatedBuildInputs = with pkgs.python3Packages; [
    apscheduler
    beautifulsoup4
    discordpy
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
      byestorm
      educorreia932
      hsc00
      hypogirl
    ];
  };
}
