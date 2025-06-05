{ pkgs, ... }:

{

  stylix = {
    image = ../_img/bakeneko.png;
    enable = true;
    polarity = "dark";
    autoEnable = true;

    # Color scheme
    base16Scheme = {
      scheme = "Kurenai";
      base00 = "1B1B1B";
      base01 = "3D3D3D";
      base02 = "545454";
      base03 = "979797";
      base04 = "E0E3C8";
      base05 = "E0E3C8";
      base06 = "E0E3C8";
      base07 = "FFFFFF";
      base08 = "FFFFFF";
      base09 = "9E2224";
      base0A = "E0E3C8";
      base0B = "E0E3C8";
      base0C = "9E9F6C";
      base0D = "E0E3C8";
      base0E = "E0E3C8";
      base0F = "E0E3C8";
    };

    # Fonts
    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      monospace = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
