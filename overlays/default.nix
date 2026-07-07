{ ... }:
{
  # Add custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # Patch upstream szurubooru to fix an SQLAlchemy import bug
  szurubooru = import ./szurubooru-overlay.nix;
}
