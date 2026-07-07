final: prev:
let
  # Fix upstream bug in szurubooru 2.5-unstable-2025-07-19:
  # posts.py uses `sa.events.event.listens_for(...)` but the correct SQLAlchemy
  # public API is `sa.event.listens_for(...)` (`events` is a separate internal module).
  # This causes an AttributeError at import time when running migrations or the server.
  patchedServer = prev.szurubooru.server.overridePythonAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      substituteInPlace szurubooru/func/posts.py \
        --replace-fail "sa.events.event.listens_for" "sa.event.listens_for"
    '';
  });

  # Workaround for nixpkgs issue #522895:
  fixedAlembic =
    (prev.python3Packages.alembic.overridePythonAttrs (oldAttrs: {
      version = "1.8.1";
      src = prev.fetchPypi {
        pname = "alembic";
        version = "1.8.1";
        hash = "sha256-zQteRbFLcGQmuDPwY2m5ptXuA/gm7DI4cjzoyq9uX/o=";
      };
      doCheck = false;
      dependencies =
        (builtins.filter (p: p.pname or "" != "sqlalchemy") (oldAttrs.dependencies or [ ]))
        ++ [ prev.python3Packages.sqlalchemy_1_3 ];
    })).overrideAttrs
      (old: {
        propagatedBuildInputs = old.propagatedBuildInputs ++ [ patchedServer ];
      });
in
{
  szurubooru = prev.szurubooru // {
    server = patchedServer // {
      alembic = fixedAlembic;
    };
  };
}
