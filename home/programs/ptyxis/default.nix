{ pkgs, ... }:

let
  ptyxis = pkgs.ptyxis.overrideAttrs (finalAttrs: previousAttrs: {
    postInstall = ''
      mkdir -p $out/share/icons/hicolor/256x256/apps/
      cp -f ${./icon.png} $out/share/icons/hicolor/256x256/apps/org.gnome.Ptyxis.png
      rm -f $out/share/icons/hicolor/scalable/apps/org.gnome.Ptyxis.svg
    '';
  });
in
{
  home.packages = [
    ptyxis
  ];
}
